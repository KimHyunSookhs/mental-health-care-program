import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/presentation/component/you_tube_card.dart';
import 'package:mental_health_care/presentation/meditation_screen/meditation_view_model.dart';

import '../../core/result/result.dart';

class MeditationScreen extends StatefulWidget {
  final MeditationViewModel viewModel;

  const MeditationScreen({super.key, required this.viewModel});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getYouTube();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('명상'),
      ),
      body: SingleChildScrollView(
          child: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          if (widget.viewModel.state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          final youTube = widget.viewModel.state.youtube;
          return Container(
            color: ColorStyle.lightGrey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: switch (youTube) {
                Success(:final data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '추천 영상',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      YouTubeCard(youTube: youTube.data.first)
                    ],
                  ),
                Error(:final e) => Center(
                    child: Text('에러 발생: ${e.toString()}'),
                  ),
              },
            ),
          );
        },
      )),
    );
  }
}
