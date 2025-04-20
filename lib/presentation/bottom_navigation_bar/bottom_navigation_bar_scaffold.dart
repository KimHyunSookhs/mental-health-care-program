import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/core/routing/routes.dart';
import 'package:mental_health_care/core/ui/color_style.dart';

class BottomNavigationBarScaffold extends StatefulWidget {
  final Widget child;

  const BottomNavigationBarScaffold({super.key, required this.child});

  @override
  State<BottomNavigationBarScaffold> createState() =>
      _BottomNavigationBarScaffoldState();
}

class _BottomNavigationBarScaffoldState
    extends State<BottomNavigationBarScaffold> {
  int currentIndex = 0;

  void tabChange(int index) {
    switch (index) {
      case 0:
        context.go(Routes.haruScreen);
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: tabChange,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedItemColor: ColorStyle.moreDarkGrey,
          unselectedLabelStyle: TextStyle(
            color: ColorStyle.moreDarkGrey,
          ),
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: '하루하루'),
            BottomNavigationBarItem(
                icon: Icon(Icons.storefront), label: '마음창고'),
          ]),
    );
  }
}
