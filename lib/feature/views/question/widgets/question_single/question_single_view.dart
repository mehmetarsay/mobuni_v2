import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class QuestionSingleView extends StatelessWidget {
  const QuestionSingleView({Key? key,required this.questionModel}) : super(key: key);
  final QuestionModel questionModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionSingleViewModel>.reactive(
      builder: (context, vm, child) =>
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                  NetworkImage("https://pbs.twimg.com/profile_images/1486436054169268238/-jsp8MLq_400x400.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(width: 6,),
                Container(
                  width: context.width/1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mehmet Arsay',style: Theme.of(context).textTheme.headline1,),
                      Text(questionModel.text),
                      if(questionModel.image!=null)Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ZoomOverlay(
                          minScale: 1, // Optional
                          maxScale: 3.0, //
                          animationDuration: Duration(seconds: 1),// Optional
                          twoTouchOnly: true, // Defaults to false
                          child: CachedNetworkImage(
                            imageUrl: questionModel.image!,
                            imageBuilder: (context, imageProvider) => Container(
                              height:context.height/5 ,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            )
      ),
      viewModelBuilder: () => QuestionSingleViewModel(),
    );
  }
}
