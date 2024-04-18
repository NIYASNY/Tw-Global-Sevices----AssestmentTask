import 'package:flutter/material.dart';
import 'package:image_app/view/fullscreenimage.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package

class AnimationPage extends StatefulWidget {
  final String imageUrl;
  // ignore: use_super_parameters
  const AnimationPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FullScreenImage(imageUrl: widget.imageUrl)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:const Color(0xFFE6EEF7),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), 
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/animation.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
             const SizedBox(height: 20),
             const Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
             const SizedBox(height: 10),
            const  CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
