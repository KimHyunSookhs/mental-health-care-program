import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/data/model/haru.dart';

class HaruCard extends StatelessWidget {
  final Haru haru;
  bool isChecked;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorStyle.lightGrey,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorStyle.lightGrey)),
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: onChanged,
                  activeColor: Colors.black38,
                  side: BorderSide(color: Colors.black),
                  checkColor: Colors.white,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        haru.content,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        haru.timeOfDay,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  HaruCard({
    super.key,
    required this.haru,
    required this.isChecked,
    required this.onChanged,
  });
}
