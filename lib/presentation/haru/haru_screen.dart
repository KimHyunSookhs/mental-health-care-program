import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/presentation/component/haru_card.dart';
import 'package:mental_health_care/presentation/component/weekend_circle.dart';
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
    widget.viewModel.pickHaru();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('하루하루'),
            Text(
              DateFormat("yyyy.MM.dd").format(DateTime.now()),
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
        color: ColorStyle.lightGrey,
        child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) {
              if (widget.viewModel.state.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              final haru = widget.viewModel.state.haru;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: switch (haru) {
                  Success(:final data) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 1,
                                    spreadRadius: 0.5)
                              ]),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '오늘의 긍정적인 행동',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '작은 실천으로 시작하는 행복한 하루',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final haru = data[index];
                                          return HaruCard(haru: haru);
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 10,
                                            ),
                                        itemCount: data.length),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          '이번 주 실천률',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        WeekendCircle(),
                      ],
                    ),
                  Error(:final e) => Center(
                      child: Text('에러 발생: ${e.toString()}'),
                    ),
                },
              );
            }),
      )),
    );
  }
}
