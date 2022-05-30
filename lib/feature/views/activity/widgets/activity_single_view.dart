import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/components/image/cached_image.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/extension/date_time_extension.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/views/activity/service/activity_service.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivitySingleView extends StatefulWidget {
   ActivitySingleView({Key? key, required this.activity,required this.onTapJoin})
      : super(key: key);
  ActivityModel activity;
  dynamic onTapJoin;

  @override
  State<ActivitySingleView> createState() => _ActivitySingleViewState();
}

class _ActivitySingleViewState extends State<ActivitySingleView> {
  double paddingH = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          //user
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: paddingH),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UserPhoto(url: widget.activity.user!.image,size: 30,),
                    SizedBox(width: 10),
                    CustomText(widget.activity.user!.userName,style: context.theme.textTheme.headline1,),
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
          //image
          if (widget.activity.image != null)
            CachedImage(
              imageUrl: widget.activity.image!,
              height: context.height / 3.5,
              width: context.width,
            ),
          //title content
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: paddingH),
            child: Column(
              children: [
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    context.navigationService.navigateToView(
                      CommentView(activityModel: widget.activity),
                    )!.then((value) async{
                      widget.onTapJoin(value);
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: context.width/1.08,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(widget.activity.title, fontWeight: FontWeight.bold,fontSize: 13,),
                            SizedBox(height: 5,),
                            CustomText(
                              widget.activity.content ?? '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                //yorum - katıl butonu
                Row(
                  children: [
                    Icon(
                      Icons.messenger_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    CustomText(
                      '${widget.activity.commentCount} yorum',
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10,),
                //ücret - üniversite adı
                Row(
                  children: [
                    CustomText('Ücret: ', fontWeight: FontWeight.bold),
                    CustomText(widget.activity.ticketPrice == 0
                        ? 'Ücretsiz'
                        : '${widget.activity.ticketPrice} ₺'),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    CustomText(widget.activity.university!.name,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(height: 5),
                //başlangıç - bitiş tarihi
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      widget.activity.activityStartTime!.customFormatDate,
                      fontWeight: FontWeight.bold,
                    ),
                    Text(' - '),
                    CustomText(
                      widget.activity.activityEndTime!.customFormatDate,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                //oluşturulma tarihi
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    timeago.format(widget.activity.createdTime!).toString(),
                    color: context.colors.onBackground,
                    fontSize: 13,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                if(widget.activity.joinedCount! < widget.activity.maxUser!||widget.activity.maxUser==0)Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          body: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.activity.isJoined!?
                                'Etkinlikten ayrılmak istediğinize emin misiniz?':
                                'Etkinliğe katılmak istediğinize emin misiniz?',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),),
                          btnOkOnPress: () async{
                            ActivityModel? res =  await locator<ActivityService>().joinActivity(activityId: widget.activity.id!);
                            if(res!=null){
                              widget.onTapJoin(res);
                            }

                          },
                          btnOkColor: context.theme.primaryColor,
                          btnCancelOnPress: (){
                            return false;
                          },
                          btnOkText: 'Evet',
                          btnCancelText: 'Geri',

                        )..show();
                      },
                      child: CustomText(
                        !widget.activity.isJoined!?
                        'Katıl\n${widget.activity.joinedCount}${widget.activity.maxUser!=0?'/${widget.activity.maxUser}':''}':
                        'Ayrıl\n${widget.activity.joinedCount}${widget.activity.maxUser!=0?'/${widget.activity.maxUser}':''}',
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary:widget.activity.isJoined! ? context.theme.primaryColor:Colors.green.shade900),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider()
        ],
      ),
    );
  }
}
