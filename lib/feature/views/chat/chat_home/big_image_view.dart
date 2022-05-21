import 'package:flutter/material.dart';

class BigImageView extends StatefulWidget {
  final String? imagePath, imageTag;
  final int? backgroundOpacity;

  const BigImageView({Key? key, @required this.imagePath, @required this.imageTag, this.backgroundOpacity}) : super(key: key);

  @override
  _BigImageViewState createState() => _BigImageViewState();
}

class _BigImageViewState extends State<BigImageView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black.withAlpha(widget.backgroundOpacity ?? 220),
        body: Center(
          child: Hero(
            tag: widget.imageTag!,
            child: widget.imagePath != null ? Image.network(
              // ApplicationConstants.USER_PATH + 
              widget.imagePath!,
            ): Image.asset(
              'assets/images/profile.png',
            ),
          ),
        ),
      ),
    );
  }
}
