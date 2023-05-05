import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final String apiUrl = "http://10.0.2.2:3000/reverse_string";

  TextEditingController _controller = TextEditingController();
  String _reversedString = '';

  Future<void> _reverseString() async {
    String input2 = _controller.text;
    print(input2);
    // String input = 'hello';
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

    // Send a POST request to the Flask server with the input string
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({'input_string': input2}),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    String reversedString = data['reversed_string'];
    // Update the UI with the reversed string
    setState(() {
      _reversedString = reversedString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter a string',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _reverseString,
              child: Text('Reverse string'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Reversed string: $_reversedString',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}



/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////


//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'String Reversal App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('String Reversal App'),
//         ),
//
//       ),
//     );
//   }
// }
//
