import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  List<DateTime> getThisWeekDates() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // 월요일
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  void initState() {
    super.initState();
    _loadCompletionStatus();
  }

  Future<void> _loadCompletionStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인된 사용자가 없습니다.');

    final userEmail = user.email ?? 'unknown';
    final weekDates = getThisWeekDates();

    List<bool> updatedStatus = List.generate(7, (index) => false);

    for (int i = 0; i < 7; i++) {
      final dayStr = DateFormat('yyyy-MM-dd').format(weekDates[i]);
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .collection('WeekList')
          .doc(dayStr)
          .get();

      if (doc.exists) {
        updatedStatus[i] = true;
      }
    }

    setState(() {
      isCompletedList = updatedStatus;
    });
  }

  Future<void> _saveTodayToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userEmail = user.email ?? 'unknown';
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('WeekList')
        .doc(today)
        .set({'items': today});
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
        const SizedBox(height: 4),
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
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: BorderSide(color: Colors.black38)),
        onPressed: () async {
          setState(() {
            int todayIndex = getTodayIndex();
            isCompletedList[todayIndex] = !isCompletedList[todayIndex];
          });
          await _saveTodayToFirestore();
        },
        child: Text(
          '하루 완료',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ));
  }
}
