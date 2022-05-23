import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

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
      onTap: (){
        context.navigationService.back();
      },
      child: Container(
        height: context.height,
        width: context.width,
        color: Colors.black.withOpacity(0.8),
        child: Hero(
          tag: widget.imageTag,
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: context.height,
                width: context.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                highlightColor: context.theme.primaryColorLight.withOpacity(0.1),
                baseColor: context.theme.primaryColorDark.withOpacity(0.1),
                child: Container(
                  height: context.height ,
                  width: context.width ,
                  decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: context.height ,
                width: context.width ,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: context.theme.primaryColorDark.withOpacity(0.1)),
                child: Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
