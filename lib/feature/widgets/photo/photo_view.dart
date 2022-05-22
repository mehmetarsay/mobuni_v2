import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class CustomPhotoView extends StatefulWidget {
   CustomPhotoView({Key? key,required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  State<CustomPhotoView> createState() => _CustomPhotoViewState();
}

class _CustomPhotoViewState extends State<CustomPhotoView> {


  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        context.navigationService.back();
      },
      direction: DismissiblePageDismissDirection.down,
      isFullScreen: true,
      reverseDuration: Duration(milliseconds: 1),
      child: Hero(
        tag: 'Unique tag',
        child: Container(
          height: context.height,
          width: context.width,
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
              )
          ),
        ),
      ),
    );
  }
}
