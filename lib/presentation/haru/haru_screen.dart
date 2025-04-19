import 'package:flutter/material.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/presentation/haru/haru_view_model.dart';

class HaruScreen extends StatefulWidget {
  final HaruViewModel viewModel;

  const HaruScreen({super.key, required this.viewModel});

  @override
  State<HaruScreen> createState() => _HaruScreenState();
}

class _HaruScreenState extends State<HaruScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchHaru();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('하루하루'),
      ),
      body: SafeArea(
          child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, child) {
                if (widget.viewModel.state.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                final haru = widget.viewModel.state.haru;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: switch (haru) {
                    Success(:final data) => Container(
                        color: Colors.grey,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final haru = data[index];
                              return ListTile(
                                title: Text(haru.content),
                                trailing: Checkbox(
                                  value: haru.isChecked,
                                  onChanged: (value) {},
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: data.length),
                      ),
                    Error(:final e) => Center(
                        child: Text('에러 발생: ${e.toString()}'),
                      ),
                  },
                );
              })),
    );
  }
}
