import 'dart:async'; // Import dart:async for Timer

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool _showAppBarAndBottomBar = true; 
  late Timer _timer; // Timer for auto-hide

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        _showAppBarAndBottomBar = false; // Hide after 3 seconds
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
    String currentTime = DateFormat('HH:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFE6EEF7),
      body: GestureDetector(
        onTap: () {
          _timer.cancel(); 
          setState(() {
            _showAppBarAndBottomBar = !_showAppBarAndBottomBar;
            _timer = Timer(const Duration(seconds: 3), () {
              setState(() {
                _showAppBarAndBottomBar = false; // Hide  after 3 seconds
              });
            });
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Hero(
                  tag: widget.imageUrl, // Tag for Hero animation
                  child: PhotoView(
                    imageProvider: NetworkImage(widget.imageUrl),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0, //  top space here
              left: 0,
              right: 0,
              child: Visibility(
                visible: _showAppBarAndBottomBar,
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    child: CupertinoNavigationBar(
                      backgroundColor: Colors.white,
                      leading: CupertinoButton(
                        padding: const EdgeInsets.only(right: 25, bottom: 10),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Icon(CupertinoIcons.back),
                      ),
                      middle: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 270),
                          child: Column(
                            children: [
                              Text(
                                currentDate,
                                style: const TextStyle(
                                  color: Colors.black, // Date text color
                                  fontSize: 18, // Date text size
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 68),
                                child: Text(
                                  currentTime,
                                  style: const TextStyle(
                                    color: Colors.grey, // Time text color
                                    fontSize: 15, // Time text size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: _showAppBarAndBottomBar,
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    child: CupertinoTabBar(
                      backgroundColor: Colors.white,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.ios_share,
                            color: Colors.black54,
                            size: 22,
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon:
                              Icon(Icons.edit, color: Colors.black54, size: 22),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.favorite_outline_rounded,
                              color: Colors.black54, size: 22),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.delete,
                              color: Colors.black54, size: 22),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.more_horiz_outlined,
                              color: Colors.black54, size: 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
