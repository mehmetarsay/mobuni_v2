import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';

class UserPhoto extends StatelessWidget {
   UserPhoto({Key? key,this.size=20,this.url,this.currentUser=true}) : super(key: key);
   double size =20;
   String? url;

   ///O anki kullanıcının fotoğrafı istenirse true gönderilmeli
   ///başka kullanıcının gönderilmek istenirse url ile birlikte gönderilmeli
   bool currentUser =true;

  @override
  Widget build(BuildContext context) {
    if(currentUser){
      return GeneralManager.user.image != null&&GeneralManager.user.image != ''
          ? CachedNetworkImage(
        imageUrl: GeneralManager.user.image!,
        imageBuilder: (context, imageProvider) => Container(
          width:size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      )
          : Container(
        width: size,
        height:size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: Image.asset('assets/empty_profile.png').image, fit: BoxFit.cover),
        ),
      );
    }
    else {
      return url != null&&url !=''
          ? CachedNetworkImage(
        imageUrl: GeneralManager.user.image!,
        imageBuilder: (context, imageProvider) => Container(
          width:size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      )
          : Container(
        width: size,
        height:size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: Image.asset('assets/empty_profile.png').image, fit: BoxFit.cover),
        ),
      );
    }

  }
}
