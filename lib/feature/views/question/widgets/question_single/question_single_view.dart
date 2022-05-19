import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../subviews/question_comments/question_comments_view.dart';

// ignore: must_be_immutable
class QuestionSingleView extends StatefulWidget {
  QuestionSingleView({Key? key, required this.questionModel, this.onTap}) : super(key: key);
  final QuestionModel questionModel;
  Function()? onTap;

  @override
  State<QuestionSingleView> createState() => _QuestionSingleViewState();
}

class _QuestionSingleViewState extends State<QuestionSingleView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      onDoubleTap: () async {
        widget.questionModel.isLiked = !widget.questionModel.isLiked;
        await locator<QuestionService>().setQuestionLike(questionId: widget.questionModel.id!);
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: widget.questionModel.user!.image == null || widget.questionModel.user!.image == ''
                  ? Image.asset('assets/empty_profile.png').image
                  : NetworkImage(
                      widget.questionModel.user!.image!,
                    ),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              width: context.width / 1.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.questionModel.user!.userName!,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(widget.questionModel.text!),
                  if (widget.questionModel.image != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ZoomOverlay(
                        minScale: 1,
                        // Optional
                        maxScale: 3.0,
                        //
                        animationDuration: Duration(seconds: 1),
                        // Optional
                        twoTouchOnly: true,
                        // Defaults to false
                        child: CachedNetworkImage(
                          imageUrl: widget.questionModel.image!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: context.height / 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LikeButton(
                            onTap: (val) async {
                              widget.questionModel.isLiked = !widget.questionModel.isLiked;
                              await locator<QuestionService>().setQuestionLike(questionId: widget.questionModel.id!);
                              return widget.questionModel.isLiked;
                            },
                            size: 20,
                            isLiked: widget.questionModel.isLiked,
                            circleColor: CircleColor(start: Theme.of(context).primaryColor, end: Theme.of(context).primaryColor),
                            bubblesColor: BubblesColor(dotPrimaryColor: Theme.of(context).primaryColor, dotSecondaryColor: Colors.grey),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          if (widget.questionModel.likeCount > 0) CustomText('${widget.questionModel.likeCount} beğenme', color: Colors.grey)
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.messenger_outlined,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          if (widget.questionModel.commentCount > 0) CustomText('${widget.questionModel.commentCount} cevap', color: Colors.grey)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        timeago.format(DateTime.now().subtract(Duration(minutes: Random().nextInt(999)))).toString(),
                        style: TextStyle(
                          color: context.colors.onBackground,
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),

                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
