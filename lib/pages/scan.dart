import 'dart:convert';
import 'package:crackapp/pages/segmentation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class scan extends StatefulWidget {
  const scan({Key? key,}) : super(key: key);

  @override
  State<scan> createState() => _scanState();}



class _scanState extends State<scan> {

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }



  final String apiUrl = "https://a48e-203-192-251-182.ngrok.io/imageapi";
  // final String apiUrl = "http://10.0.2.2:3000/imageapi";
  String? b64;

  Future sendImage(File imageFile, BuildContext context) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64.encode(imageBytes);

    print(base64Image);
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({'image': base64Image}),
    );

    if (response.statusCode == 200) {
      // handle success

      print('output from here');
      print(response.body);
      this.b64 = response.body;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => segmentation(b64!)));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => segmentation(base64String)),
      // );

      // List<int> bytes = base64.decode(base64String);
      // //
      // // imageBytes = base64.b64decode(response.body);
      // // Uint8List imgbytes = Uint8List.fromList(imageBytes);
      // final processed = image!;
      // processed.writeAsBytesSync(bytes);
      // final imageTemp = File(processed.path);
      // setState(() {
      //   this.image = response.body as File?;
      // });
      // print(imageTemp==image);
      // print('this is image');
      // print(image);
      // // print(imageTemp);
      // setState(() {
      //
      // });
    } else {
      // handle error
      print('Error sending image: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/illustration.png');
    var emptyimage = new Image(image: assetsImage, fit: BoxFit.cover);
    // SvgPicture.asset("assets/alarm_icon.svg");

    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),

        body: Center(
          child: Column(

            children: [

              SizedBox(height: 10,),
              image != null
                  ? Image.file(image!, height: 500, width: 700,)
                  : emptyimage,
              SizedBox(height: 10,),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                        color: Colors.lightGreen,

                        child: const Text(
                            "Pick Image from Gallery",
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            )
                        ),
                        onPressed: () {
                          pickImage();
                        }
                    ),
                    SizedBox(width: 20,),
                    MaterialButton(
                        color: Colors.greenAccent,
                        child: const Text(
                            "Pick Image from Camera",
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            )
                        ),
                        onPressed: () {
                          pickImageC();
                        }
                    ),
                  ],

                ),
              ),
              MaterialButton(
                  color: Colors.greenAccent,
                  child: const Text(
                      "UPLOAD",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      )
                  ),
                  onPressed: () {
                    sendImage(image!, context);
                  }
              ),

            ],
          ),
        )
    );
  }
}



