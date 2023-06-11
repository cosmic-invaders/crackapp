import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crackapp/pages/details.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shimmer/shimmer.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> with AutomaticKeepAliveClientMixin {
  Future<List<String>>? _imageUrlsFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlsFuture = getImageUrls();
  }

  Future<List<String>> getImageUrls() async {
    List<String> imageUrls = [];
    firebase_storage.ListResult listResult =
    await firebase_storage.FirebaseStorage.instance.ref('images/').listAll();

    for (var item in listResult.items) {
      String downloadURL = await item.getDownloadURL();
      imageUrls.add(downloadURL);
    }

    return imageUrls;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the state is kept alive

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _imageUrlsFuture = getImageUrls();
          });
        },
        child: FutureBuilder<List<String>>(
          future: _imageUrlsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemCount: 6, // Display 6 loading skeletons
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: Container(
                      height: 180,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<String> imageUrls = snapshot.data!;
              return ListView.builder(
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  String imageUrl = imageUrls[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => details(
                            imageUrl: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
