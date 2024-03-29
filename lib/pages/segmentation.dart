import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class segmentation extends StatefulWidget {
  final String imageBase64;

  segmentation(this.imageBase64);

  @override
  _segmentationState createState() => _segmentationState();
}

class _segmentationState extends State<segmentation> {
  late Image image;

  @override
  void initState() {
    super.initState();
    _loadImageFromBase64String();
  }

  Future<Null> _loadImageFromBase64String() async {
    if (widget.imageBase64 != null && widget.imageBase64.isNotEmpty) {
      setState(() {
        image = Image.memory(
          base64Decode(widget.imageBase64),
          fit: BoxFit.contain,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Processed Image"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                child: image == null
                    ? Center(child: CircularProgressIndicator())
                    : image,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
