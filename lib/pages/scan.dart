// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

// class scan extends StatefulWidget {
//   const scan({Key? key}) : super(key: key);
//
//   @override
//   State<scan> createState() => _scanState();
// }
//
// class _scanState extends State<scan> {
//
//
//
//
//   File? imageFile;
//
//
//   _openGallery(BuildContext context) async{
//     final ImagePicker picker = ImagePicker();
//      final pic = await picker.pickImage(source: ImageSource.gallery);
//      setState(() {
//        File imageFile =pic as File;
//      });
//      Navigator.of(context).pop();
//
//   }
//
//
//
//   _openCamera(BuildContext context) async{
//     final ImagePicker picker = ImagePicker();
//     final pic = await picker.pickImage(source: ImageSource.camera);
//     setState(() {
//        imageFile =pic as File;
//     });
//     Navigator.of(context).pop();
//
//   }
//
//   Future<void> _showChoiceDialog(BuildContext context){
//     return showDialog(context: context, builder: (BuildContext){
//       return AlertDialog(
//         title: Text('Make a choice'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: [
//               GestureDetector(
//                 child : Text('Gallary'),
//                 onTap: (){
//                   _openGallery(context);
//                 },
//               ),
//               Padding(padding: EdgeInsets.all(8.0)),
//               GestureDetector(
//                 child : Text('Camera'),
//                 onTap: (){
//                   _openCamera(context);
//                 },
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var assetsImage = new AssetImage('assets/illustration.jpg'); //<- Creates an object that fetches an image.
//
//     var image = new Image(image: assetsImage, fit: BoxFit.cover);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan the Crack'),
//       ),
//       body: Container(
//         child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//
//           children: [
//             // Text('No image selected'),
//             // SizedBox(height: 50,),
//
//
//             imageFile!= null ? Image.file(imageFile!,width: 4000): image,
//             TextButton(onPressed: () {
//               _showChoiceDialog(context);
//
//             } ,
//                 child: Text('Scan Image'))
//           ],
//         ),
//         ),
//       ),
//     );
//   }
// }


//
class scan extends StatefulWidget {
  const scan({Key? key,}) : super(key: key);



  @override
  State<scan> createState() => _scanState();}

class _scanState extends State<scan> {

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
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
              image != null ? Image.file(image!,height: 500,width: 700,): emptyimage,
              SizedBox(height: 10,),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    pickImage();
                  }
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    pickImageC();
                  }
              ),
            ],
          ),
        )
    );
  }
}

