import 'package:backend_pratice/Profile/profile.dart';
import 'package:backend_pratice/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class Bottomnavigator extends StatefulWidget {
  const Bottomnavigator({super.key});

  @override
  State<Bottomnavigator> createState() => _BottomnavigatorState();
}

class _BottomnavigatorState extends State<Bottomnavigator> {
  int currentindex = 0;
  List<Widget>pages=[
    Dashboard(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: const[
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add_solid),label: 'Person'),
      ],
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        onTap: (value){
        setState(() {
          currentindex = value;
        });
        },
      ),
      body: IndexedStack(
        index:  currentindex,
        children: pages,
      ),
    );
  }
}
