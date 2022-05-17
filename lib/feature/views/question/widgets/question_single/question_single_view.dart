import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:stacked/stacked.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../subviews/question_comments/question_comments_view.dart';

class QuestionSingleView extends StatelessWidget {
   QuestionSingleView({Key? key,required this.questionModel,this.onTapNavigate=false}) : super(key: key);
  final QuestionModel questionModel;
   bool onTapNavigate=false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onTapNavigate)
          context.navigationService.navigateToView(QuestionCommentsView(questionModel: questionModel),);
      },
      child: Container(
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
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            LikeButton(
                              onTap: onLikeButtonTapped,
                              size: 20,
                              circleColor: CircleColor(start: Theme.of(context).primaryColor, end: Theme.of(context).primaryColor),
                              bubblesColor: BubblesColor(dotPrimaryColor: Theme.of(context).primaryColor, dotSecondaryColor: Colors.grey),
                            ),
                            SizedBox(width: 4,),
                            if(questionModel.likeCount>0)CustomText('${questionModel.likeCount} beğenme',color: Colors.grey)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Icon(Icons.messenger_outlined,size: 20,color: Colors.grey,),
                            SizedBox(width: 4,),
                            if(questionModel.commentCount>0)CustomText('${questionModel.commentCount} cevap',color: Colors.grey)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );

  }

   Future<bool> onLikeButtonTapped(bool isLiked) async{
     /// isteği buraya gönder
     // final bool success= await sendRequest();

     /// başarısız olursa, hiçbir şey yapama
     // return success? !isLiked:isLiked;

     return !isLiked;
   }
}
