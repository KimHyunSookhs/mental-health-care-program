import 'package:flutter/material.dart';
import 'package:mental_health_care/presentation/haruharu/haruharu_view_model.dart';

class HaruHaruScreen extends StatefulWidget {
  final HaruHaruViewModel viewModel;

  const HaruHaruScreen({super.key, required this.viewModel});

  @override
  State<HaruHaruScreen> createState() => _HaruHaruScreenState();
}

class _HaruHaruScreenState extends State<HaruHaruScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getHaruHaruUseCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('하루하루')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, child) {
                final state = widget.viewModel.state;
                return Column(
                  children: [
                    Divider(color: Colors.grey),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text('오늘의 긍정적인 행동'),
                          SizedBox(height: 20),
                          state.haruModel.isEmpty
                              ? const CircularProgressIndicator() // 로딩 혹은 '없음' 표시
                              : Column(
                                children: [
                                  Text('오늘의 긍정적인 행동'),
                                  const SizedBox(height: 20),
                                  Text(state.haruModel.first.toString()),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
