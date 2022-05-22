import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/comment/comment_model.dart';
import 'package:mobuni_v2/feature/views/comments/service/comment_service.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key,required this.commentModel}) : super(key: key);
  final CommentModel commentModel;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
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
                  Text(widget.commentModel.content!),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LikeButton(
                            onTap: (val)async{
                              locator<CommentService>().setCommentLike(id: widget.commentModel.id!);
                              if (widget.commentModel.isLiked&&widget.commentModel.likeCount!>0) {
                                widget.commentModel.likeCount=widget.commentModel.likeCount!-1;
                              } else {
                                widget.commentModel.likeCount=widget.commentModel.likeCount!+1;
                              }
                              setState(() {
                                widget.commentModel.isLiked = !widget.commentModel.isLiked;
                              });
                              return widget.commentModel.isLiked;
                            },
                            size: 20,
                            animationDuration: Duration(milliseconds: 500),
                            isLiked: widget.commentModel.isLiked,
                            circleColor: CircleColor(start: Theme.of(context).primaryColor, end: Theme.of(context).primaryColor),
                            bubblesColor: BubblesColor(dotPrimaryColor: Theme.of(context).primaryColor, dotSecondaryColor: Colors.grey),
                          ),
                          SizedBox(width: 4,),
                          if(widget.commentModel.likeCount!>0)CustomText('${widget.commentModel.likeCount} beğenme',color: Colors.grey)
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
