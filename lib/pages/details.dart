import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class details extends StatelessWidget {
  final String imageUrl;

  details({required this.imageUrl});

  // get assetsImage => null;

  String extractCreationTimeFromUrl() {
    // Extract the timestamp from the image URL
    String fileName = imageUrl.split('/').last;
    int startIndex = fileName.indexOf('%2F') + 3;
    int endIndex = fileName.indexOf('.jpg');

    String timestamp = fileName.substring(startIndex, endIndex);

    // Extract date and time components
    String year = timestamp.substring(0, 4);
    String month = timestamp.substring(4, 6);
    String day = timestamp.substring(6, 8);
    String hour = timestamp.substring(8, 10);
    String minute = timestamp.substring(10, 12);
    String second = timestamp.substring(12, 14);

    // Format the timestamp as desired
    String formattedTimestamp =
        'Scanned on:\n\nDate: $day / $month / $year\n\nTime: $hour : $minute : $second';

    return formattedTimestamp;
  }

  @override
  Widget build(BuildContext context) {
    String creationTime = extractCreationTimeFromUrl();
    RegExp dateRegex = RegExp(r'Date: (\d{2} / \d{2} / \d{4})');
    RegExp timeRegex = RegExp(r'Time: (\d{2} : \d{2} : \d{2})');

    String formattedDate = dateRegex.firstMatch(creationTime)?.group(1) ?? '';
    String formattedTime = timeRegex.firstMatch(creationTime)?.group(1) ?? '';
    // var emptyimage = new Image(image: assetsImage, fit: BoxFit.cover);

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Details'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scanned on:',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Date: $formattedDate',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Time: $formattedTime',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
