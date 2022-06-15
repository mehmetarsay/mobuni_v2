import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/widgets/photo/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatefulWidget {
  CachedImage(
      {Key? key,
      required this.imageUrl,
      this.height,
      this.width,
      this.borderRadiusGeometry,
      this.onTapShowImage = true,
      this.boxFit = BoxFit.cover,
      this.imageTag})
      : super(key: key);
  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final bool onTapShowImage;
  final BoxFit boxFit;
  final String? imageTag;

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late final tag;
  @override
  void initState() {
    super.initState();
    tag = widget.imageTag ?? Random().nextInt(9999).toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapShowImage
          ? () {
              if (widget.imageUrl != '')
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        CustomPhotoView(
                      imageUrl: widget.imageUrl,
                      imageTag: widget.onTapShowImage ? tag : null,
                    ),
                  ),
                );
            }
          : null,
      child: widget.onTapShowImage
          ? Hero(
              tag: widget.imageUrl.hashCode.toString(),
              child: cachedNetworkImage(),
            )
          : cachedNetworkImage(),
    );
  }

  CachedNetworkImage cachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: widget.borderRadiusGeometry,
          image: DecorationImage(image: imageProvider, fit: widget.boxFit),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        highlightColor: context.theme.primaryColorLight.withOpacity(0.1),
        baseColor: context.theme.primaryColorDark.withOpacity(0.1),
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: widget.borderRadiusGeometry,
              color: Colors.grey),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: widget.borderRadiusGeometry,
            color: context.theme.primaryColorDark.withOpacity(0.1)),
        child: Icon(Icons.error),
      ),
    );
  }
}
