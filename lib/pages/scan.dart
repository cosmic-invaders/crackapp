import 'package:flutter/material.dart';


class scan extends StatefulWidget {
  const scan({Key? key}) : super(key: key);

  @override
  State<scan> createState() => _scanState();
}

class _scanState extends State<scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('scan here',style: TextStyle(fontSize: 70),)),
    );
  }
}
