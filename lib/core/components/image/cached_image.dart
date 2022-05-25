import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/widgets/photo/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  CachedImage(
      {Key? key,
      required this.imageUrl,
      this.height,
      this.width,
      this.borderRadiusGeometry,
      this.onTapShowImage = true, this.boxFit = BoxFit.cover})
      : super(key: key);
  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final bool onTapShowImage;
  final BoxFit boxFit;

  final tag = Random().nextInt(999).toString();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapShowImage
          ? () {
              if (imageUrl != '')
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        CustomPhotoView(
                      imageUrl: imageUrl,
                      imageTag: imageUrl,
                    ),
                  ),
                );
            }
          : null,
      child: onTapShowImage ? Hero(
        tag: imageUrl,
        child: cachedNetworkImage(),
      ) : cachedNetworkImage(),
    );
  }

  CachedNetworkImage cachedNetworkImage() {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: borderRadiusGeometry,
              image: DecorationImage(image: imageProvider, fit: boxFit),
              ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          highlightColor: context.theme.primaryColorLight.withOpacity(0.1),
          baseColor: context.theme.primaryColorDark.withOpacity(0.1),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: borderRadiusGeometry,
                color: Colors.grey),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: borderRadiusGeometry,
              color: context.theme.primaryColorDark.withOpacity(0.1)),
          child: Icon(Icons.error),
        ),
      );
  }
}
