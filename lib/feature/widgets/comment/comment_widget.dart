import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/comment/comment_model.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key,required this.commentModel}) : super(key: key);
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.0,
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
                  Text(commentModel.content!),
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
                          if(commentModel.likeCount!>0)CustomText('${commentModel.likeCount} beğenme',color: Colors.grey)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
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
