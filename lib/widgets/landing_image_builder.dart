import 'package:flutter/material.dart';
import 'package:news_app/valueNotifiers.dart';

class LandingImageBuilder extends StatelessWidget {
  final String urlImage;
  final int index;
  const LandingImageBuilder(this.index, this.urlImage);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      
      body: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(urlImage,
        height: size.height*.8,
        width: size.width,
        fit: BoxFit.cover,
        ),
      ),
    );
  }
}
