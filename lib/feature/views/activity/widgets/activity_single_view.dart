import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/image/cached_image.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/extension/date_time_extension.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivitySingleView extends StatelessWidget {
  const ActivitySingleView({Key? key, required this.activity})
      : super(key: key);
  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UserPhoto(url: activity.user!.image),
                    SizedBox(width: 10),
                    CustomText(activity.user!.userName),
                  ],
                ),
                Icon(
                  Icons.more_horiz,
                  size: 20,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          if (activity.image != null)
            CachedImage(
              imageUrl: activity.image!,
              height: context.height / 4,
              width: context.width,
            ),
          // if (activity.image == null)
          GestureDetector(
            onTap: (){
              context.navigationService.navigateToView(
                CommentView(activityModel: activity),
              )!.then((value) async{
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(activity.title, fontWeight: FontWeight.bold),
                  CustomText(
                    activity.content ?? '',
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.messenger_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    CustomText(
                      '${activity.commentCount} yorum',
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    // Icon(
                    //   Icons.send,
                    //   size: 20,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: CustomText(
                    'Katıl\n0/${activity.maxUser}',
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: context.theme.primaryColor),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText('Ücret: ', fontWeight: FontWeight.bold),
                    CustomText(activity.ticketPrice == 0
                        ? 'Ücretsiz'
                        : '${activity.ticketPrice} ₺'),
                  ],
                ),
                CustomText(activity.university!.name,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  activity.activityStartTime!.customFormatDate,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  activity.activityEndTime!.customFormatDate,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                timeago.format(activity.createdTime!).toString(),
                color: context.colors.onBackground,
                fontSize: 13,
                // fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
