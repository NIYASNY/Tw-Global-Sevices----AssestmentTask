import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/controller/api/image_service.dart';
import 'package:image_app/view/imagetile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Image Gallery",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFE6EEF7),
        appBar: AppBar(
          automaticallyImplyLeading: false, // Removing the default back button
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                
                },
                child: const Text(
                  "Photos",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              const SizedBox(width: 15),
              TextButton(
                onPressed: () {
                
                },
                child:const Text(
                  "Albums",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon:const Icon(Icons.keyboard_arrow_down), // Icon on the right side
              onPressed: () {},
            ),
          ],
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ),
        body: ImageGallery(),
      ),
    );
  }
}

class ImageGallery extends StatelessWidget {
  final ImageService _imageService = ImageService();

  // ignore: use_key_in_widget_constructors
  ImageGallery({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder(
        future: _imageService.getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            final List<Map<String, dynamic>>? images = snapshot.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns for a square grid
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1, 
              ),
              itemCount: images?.length,
              itemBuilder: (context, index) {
                return ImageTile(
                  imageUrl: images?[index]['webformatURL'],
                  likes: images?[index]['likes'],
                  views: images?[index]['views'],
                );
              },
            );
          }
        },
      ),
    );
  }
}


