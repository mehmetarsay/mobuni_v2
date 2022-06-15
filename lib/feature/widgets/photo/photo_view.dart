import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/image/cached_image.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class CustomPhotoView extends StatefulWidget {
   CustomPhotoView({Key? key,required this.imageUrl, this.imageTag}) : super(key: key);
   final String imageUrl;
   final String? imageTag;

  @override
  State<CustomPhotoView> createState() => _CustomPhotoViewState();
}

class _CustomPhotoViewState extends State<CustomPhotoView> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.navigationService.back();
      },
      onVerticalDragDown: (details){
        if(details.globalPosition.dy<300)
        context.navigationService.back();
      },
      child: Container(
        height: context.height,
        width: context.width,
        color: Colors.black.withOpacity(0.8),
        child: widget.imageTag != null ?  Hero(
          tag: widget.imageTag!,
          child: _buildInteractiveViewer(),
        ) : 
        _buildInteractiveViewer(),
      ),
    );
  }

  InteractiveViewer _buildInteractiveViewer() {
    return InteractiveViewer(
          child: CachedImage(
            imageUrl: widget.imageUrl,
            onTapShowImage: false,
            boxFit: BoxFit.contain,
            imageTag: widget.imageTag,
          ),
        );
  }
}
