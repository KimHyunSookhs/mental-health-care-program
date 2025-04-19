import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';

class WeekendCircle extends StatefulWidget {
  const WeekendCircle({super.key});

  @override
  State<WeekendCircle> createState() => _WeekendCircleState();
}

class _WeekendCircleState extends State<WeekendCircle> {
  List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
  List<bool> isCompletedList =
      List.generate(7, (index) => false); // 요일별 완료 상태 저장

  int getTodayIndex() {
    return DateTime.now().weekday - 1; // 월:1~일:7 이므로 -1
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (int i = 0; i < days.length; i++)
              _buildCircleAvatar(days[i], isCompletedList[i])
          ],
        ),
        SizedBox(
          height: 70,
        ),
        _buildButton(),
      ],
    );
  }

  Widget _buildCircleAvatar(String day, bool isCompleted) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: ColorStyle.moreDarkGrey,
          radius: 22,
          child: Text(
            day,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        const SizedBox(height: 4), // 간격 살짝
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? Colors.black : ColorStyle.moreDarkGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            int todayIndex = getTodayIndex();
            isCompletedList[todayIndex] = !isCompletedList[todayIndex];
          });
        },
        child: Text('하루 완료'));
  }
}
