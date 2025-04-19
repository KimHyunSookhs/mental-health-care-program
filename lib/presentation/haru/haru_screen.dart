import 'package:flutter/material.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/presentation/component/haru_card.dart';
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
                return Container(
                  color: ColorStyle.lightGrey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: switch (haru) {
                      Success(:final data) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '오늘의 긍정적인 행동',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '작은 실천으로 시작하는 행복한 하루',
                                style: TextStyle(fontSize: 14),
                              ),
                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final haru = data[index];
                                      return HaruCard(haru: haru);
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 10,
                                        ),
                                    itemCount: data.length),
                              ),
                            ]),
                      Error(:final e) => Center(
                          child: Text('에러 발생: ${e.toString()}'),
                        ),
                    },
                  ),
                );
              })),
    );
  }
}
