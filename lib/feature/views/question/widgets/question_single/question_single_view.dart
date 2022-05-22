import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:mobuni_v2/feature/widgets/photo/photo_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    return Padding(
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
                GestureDetector(
                    onTap: widget.onTap ?? () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.questionModel.text!),
                    )),
                if (widget.questionModel.image != null && widget.questionModel.image != '') photoWidget(),
                SizedBox(
                  height: 25,
                ),
                likeCommentWidget(context),
                timeWidget(context),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  likeCommentWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            LikeButton(
              onTap: (val) async {
                locator<QuestionService>().setQuestionLike(questionId: widget.questionModel.id!);
                if (widget.questionModel.isLiked) {
                  widget.questionModel.likeCount--;
                } else {
                  widget.questionModel.likeCount++;
                }
                widget.questionModel.isLiked = !widget.questionModel.isLiked;
                setState(() {});
                return widget.questionModel.isLiked;
              },
              size: 20,
              animationDuration: Duration(milliseconds: 150),
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
        GestureDetector(
          onTap: widget.onTap ?? () {},
          child: Row(
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
        ),
      ],
    );
  }

  Row timeWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          timeago.format(widget.questionModel.createdTime!).toString(),
          style: TextStyle(color: context.colors.onBackground, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  photoWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          if (widget.questionModel.image != null && widget.questionModel.image != '')
            context.navigationService.navigateToView(
              CustomPhotoView(imageUrl: widget.questionModel.image!),
              fullscreenDialog: true,
            );
        },
        child: CachedNetworkImage(
          imageUrl: widget.questionModel.image!,
          imageBuilder: (context, imageProvider) => Container(
            height: context.height / 3.5,
            width: context.width / 1.1,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                color: Colors.grey),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            highlightColor: context.theme.primaryColorLight.withOpacity(0.1),
            baseColor: context.theme.primaryColorDark.withOpacity(0.1),
            child: Container(
              height: context.height / 3.5,
              width: context.width / 1.1,
              decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: context.height / 3.5,
            width: context.width / 1.1,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: context.theme.primaryColorDark.withOpacity(0.1)),
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
