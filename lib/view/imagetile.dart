import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_app/view/animation.dart';

class ImageTile extends StatefulWidget {
  final String imageUrl;
  final int likes;
  final int views;

  const ImageTile({
    super.key,
    required this.imageUrl,
    required this.likes,
    required this.views,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          AnimationPage(
            imageUrl: widget.imageUrl,
          ),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity, 
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  color: Colors.grey,
                );
              },
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: Row(
              children: [
               const Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                  size: 16.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                  '${widget.views}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}