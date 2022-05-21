import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    Key? key,
    this.size = 20,
    this.url,
    this.currentUser = true, 
    this.assetPath,
  }) : super(key: key);
  final double size;
  final String? url;
  ///O anki kullanıcının fotoğrafı istenirse true gönderilmeli
  ///başka kullanıcının gönderilmek istenirse url ile birlikte gönderilmeli
  final bool currentUser;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    if (currentUser) {
      return GeneralManager.user.image != null &&
              GeneralManager.user.image != ''
          ? CachedNetworkImage(
              imageUrl: GeneralManager.user.image!,
              imageBuilder: (context, imageProvider) => Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: Image.asset('assets/empty_profile.png').image,
                    fit: BoxFit.cover),
              ),
            );
    } else {
      return url != null && url != ''
          ? CachedNetworkImage(
              imageUrl: url!,
              imageBuilder: (context, imageProvider) => Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: Image.asset(assetPath ?? 'assets/empty_profile.png').image,
                    fit: BoxFit.cover),
              ),
            );
    }
  }
}
