import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/profile/subviews/photo_change/photo_change_view_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';

class PhotoChangeView extends StatelessWidget {
  const PhotoChangeView({Key? key,required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhotoChangeViewModel>.reactive(
      viewModelBuilder: () => PhotoChangeViewModel(),
      builder: builder,
      //onModelReady: (vm) => vm.initialize(context),
    );
  }
  Widget builder(BuildContext context, PhotoChangeViewModel vm, Widget? child){
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: vm.getImage,
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
      body: Container(
          child: Stack(
            children: [
              PhotoView(
                imageProvider:vm.imageFile==null? NetworkImage(image):Image.asset(vm.imageFile!.path).image,
                maxScale: 1.0,
                minScale: 1.1,
                backgroundDecoration: BoxDecoration(
                  color: context.theme.primaryColorLight
                ),
              ),
              if(vm.imageFile!=null)Positioned(
                right: 0,
                left: 0,
                bottom: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height:100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 4),
                        image: DecorationImage(image: Image.asset(vm.imageFile!.path).image, fit: BoxFit.contain),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.grey
                      ),
                      child: Text('Uygula'),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
