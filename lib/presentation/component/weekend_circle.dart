import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';

class WeekendCircle extends StatefulWidget {
  const WeekendCircle({super.key});

  @override
  State<WeekendCircle> createState() => _WeekendCircleState();
}

class _WeekendCircleState extends State<WeekendCircle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircleAvatar('월'),
        _buildCircleAvatar('화'),
        _buildCircleAvatar('수'),
        _buildCircleAvatar('목'),
        _buildCircleAvatar('금'),
        _buildCircleAvatar('토'),
        _buildCircleAvatar('일')
      ],
    );
  }

  Widget _buildCircleAvatar(String day) {
    return CircleAvatar(
        backgroundColor: ColorStyle.moreDarkGrey,
        child: Text(
          day,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ));
  }
}
