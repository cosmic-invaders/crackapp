import 'package:flutter/material.dart';
import 'package:crackapp/pages/scan.dart';
import 'package:crackapp/pages/dashboard.dart';

void main() {
  runApp(const MaterialApp(home : home()));
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int index =0;
  final screens = [
    scan(),
    dashboard()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar:NavigationBarTheme(data:  NavigationBarThemeData(indicatorColor: Colors.blue.shade100,
      height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),

      child: NavigationBar(

          selectedIndex: index,
          onDestinationSelected: (index)=>
          setState(()=>
            this.index = index
          ),


          destinations: const [
            NavigationDestination(icon: Icon(Icons.camera_outlined),
                selectedIcon: Icon(Icons.camera),
                label: 'scan'),
            NavigationDestination(icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Dashboard')

          ]),)


    );
  }
}
