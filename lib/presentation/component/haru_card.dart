import 'package:flutter/material.dart';
import 'package:mental_health_care/data/model/haru.dart';

class HaruCard extends StatefulWidget {
  final Haru haru;

  const HaruCard({super.key, required this.haru});

  @override
  State<HaruCard> createState() => _HaruCardState();
}

class _HaruCardState extends State<HaruCard> {
  @override
  Widget build(BuildContext context) {
    bool? isChecked = false;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  activeColor: Colors.grey,
                  checkColor: Colors.white,
                ),
                Text(widget.haru.content)
              ],
            ),
          )
        ],
      ),
    );
  }
}
