import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/components/image/cached_image.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/profile/profile_view.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class QuestionSingleView extends StatefulWidget {
  QuestionSingleView({Key? key, required this.questionModel, this.onTap})
      : super(key: key);
  final QuestionModel questionModel;
  Function()? onTap;

  @override
  State<QuestionSingleView> createState() => _QuestionSingleViewState();
}

class _QuestionSingleViewState extends State<QuestionSingleView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 0, top: 5, bottom: 0),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.navigationService.navigateToView(
                  ProfileView(userId: widget.questionModel.userId));
            },
            child: UserPhoto(
              url: widget.questionModel.user!.image,
              size: 50,
              currentUser: false,
            ),
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
                if (!widget.questionModel.user!.isUniversityStudent!)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          widget.questionModel.university!.name,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          widget.questionModel.department != null
                              ? widget.questionModel.department!.name
                              : 'Genel',
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                if (widget.questionModel.image != null &&
                    widget.questionModel.image != '')
                  photoWidget(),
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
                locator<QuestionService>()
                    .setQuestionLike(questionId: widget.questionModel.id!);
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
              circleColor: CircleColor(
                  start: Theme.of(context).primaryColor,
                  end: Theme.of(context).primaryColor),
              bubblesColor: BubblesColor(
                  dotPrimaryColor: Theme.of(context).primaryColor,
                  dotSecondaryColor: Colors.grey),
            ),
            SizedBox(
              width: 4,
            ),
            if (widget.questionModel.likeCount > 0)
              CustomText('${widget.questionModel.likeCount} beğenme',
                  color: Colors.grey)
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
              if (widget.questionModel.commentCount > 0)
                CustomText('${widget.questionModel.commentCount} cevap',
                    color: Colors.grey)
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
          style: TextStyle(
              color: context.colors.onBackground,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  photoWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CachedImage(
        imageUrl: widget.questionModel.image!,
        height: context.height / 3.5,
        width: context.width / 1.1,
        borderRadiusGeometry: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
