import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/image/cached_image.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class CustomPhotoView extends StatefulWidget {
   CustomPhotoView({Key? key,required this.imageUrl,required this.imageTag}) : super(key: key);
   final String imageUrl, imageTag;

  @override
  State<CustomPhotoView> createState() => _CustomPhotoViewState();
}

class _CustomPhotoViewState extends State<CustomPhotoView> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (){
      //   context.navigationService.back();
      // },
      onVerticalDragDown: (details){
        if(details.globalPosition.dy<300)
        context.navigationService.back();
      },
      child: Container(
        height: context.height,
        width: context.width,
        color: Colors.black.withOpacity(0.8),
        child: Hero(
          tag: widget.imageTag,
          child: InteractiveViewer(

            child: CachedImage(
              imageUrl: widget.imageUrl,
              onTapShowImage: false,
              boxFit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
