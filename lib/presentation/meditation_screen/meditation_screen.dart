import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/presentation/component/you_tube_card.dart';
import 'package:mental_health_care/presentation/meditation_screen/meditation_view_model.dart';

import '../../core/result/result.dart';
import '../../core/ui/button_style.dart';

class MeditationScreen extends StatefulWidget {
  final MeditationViewModel viewModel;

  const MeditationScreen({super.key, required this.viewModel});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

enum SelectedTab { all, meditation, asmr }

class _MeditationScreenState extends State<MeditationScreen> {
  SelectedTab _selectedTab = SelectedTab.all;

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
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YouTubeCard(
                                  youTube: youTube.data.first,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  youTube.data.first.title,
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${youTube.data.first.duration.toString()}분',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: ColorStyle.darkerGrey),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 7,
                                      color: ColorStyle.darkerGrey,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      youTube.data.first.category,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: ColorStyle.darkerGrey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTabButton('전체', SelectedTab.all),
                          _buildTabButton('명상', SelectedTab.meditation),
                          _buildTabButton('ASMR', SelectedTab.asmr)
                        ],
                      ),
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

  Widget _buildTabButton(String title, SelectedTab tab) {
    final bool isSelected = _selectedTab == tab;
    return ElevatedButton(
      style: isSelected
          ? ButtonStyles.selectedButton
          : ButtonStyles.unSelectedButton,
      onPressed: () {
        setState(() {
          _selectedTab = tab;
        });
      },
      child: Text(title,
          style: isSelected
              ? TextStyle(color: Colors.white, fontSize: 14)
              : TextStyle(color: Colors.black, fontSize: 14)),
    );
  }
}
