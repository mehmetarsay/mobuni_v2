import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:photo_view/photo_view.dart';

class CustomPhotoView extends StatefulWidget {
   CustomPhotoView({Key? key,required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  State<CustomPhotoView> createState() => _CustomPhotoViewState();
}

class _CustomPhotoViewState extends State<CustomPhotoView> {
  ScrollController controller = ScrollController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        edgeOffset: 20,
          notificationPredicate:(val){
            print(val.metrics.pixels);
          if(val.metrics.pixels<15){
             context.navigationService.back();
          }
          return true;
          },
        onRefresh: () async{},
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: controller,
          child: Column(
            children: [
              InteractiveViewer(
                child:Container(
                    height: context.height+50,
                    width: context.width,
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
