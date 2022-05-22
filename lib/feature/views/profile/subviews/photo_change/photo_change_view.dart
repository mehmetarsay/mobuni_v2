import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/profile/subviews/photo_change/photo_change_view_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';

class PhotoChangeView extends StatelessWidget {
  const PhotoChangeView({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhotoChangeViewModel>.reactive(
      viewModelBuilder: () => PhotoChangeViewModel(),
      builder: builder,
      onModelReady: (vm) => vm.initialize(imageUrl),
    );
  }

  Widget builder(BuildContext context, PhotoChangeViewModel vm, Widget? child) {
    return Scaffold(
      key: GlobalKey(debugLabel: 'PhotoView'),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => vm.getImage(),
              child: Material(
                color: context.theme.primaryColorDark,
                shape: CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.edit,
                    color: context.theme.primaryColorLight,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: vm.initialised ? Container(
          child: Stack(
            children: [
              Hero(
                tag: 'Unique tag999',
                child: Container(
                  height: context.height,
                  width: context.width,
                  child: InteractiveViewer(
                      child: Image(
                          image: vm.imageFile == null ? NetworkImage(imageUrl) : Image
                              .file(File(vm.imageFile!.path))
                              .image,
                        fit: BoxFit.contain,
                      ),
                  ),
                ),
              ),
              if(vm.imageFile != null)Positioned(
                right: 10,
                left: 10,
                bottom: 10,
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: context.theme.primaryColorDark, width: 1),
                      color: context.theme.primaryColorDark.withOpacity(0.5)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: Image
                                .file(File(vm.imageFile!.path))
                                .image,
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  GeneralManager.user.userName!,
                                  color: context.theme.primaryColorLight,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomText('Bu fotoğraf efsane oldu :) ⭐🌟️⭐🌟️⭐'
                                  ,
                                  color: context.theme.primaryColorLight,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      CustomButton(
                        text: 'Kaydet',
                        onPressed: () {
                          vm.save(context);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ) : Container(
        color: context.theme.primaryColorLight,
        child: Center(
          child: GestureDetector(
            onTap: vm.getImage,
            child: CustomText(
              'Lütfen fotoğraf seçiniz...',
              color: context.theme.primaryColorDark,
            ),
          ),
        ),
      ),
    );
  }
}
