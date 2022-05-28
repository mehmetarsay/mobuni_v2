import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/activity_or_question_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/activity/widgets/activity_single_view.dart';
import 'package:mobuni_v2/feature/views/profile/profile_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key,this.userId}) : super(key: key);
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.init(userId),
      builder: (context, vm, child) => vm.initialised
          ? SafeArea(
              child: Scaffold(
                body: CustomScrollView(
                  controller: vm.controller,
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      centerTitle: false,
                      leading:userId!=null? IconButton(onPressed: () {
                        context.navigationService.back();
                      }, icon: Icon(Icons.arrow_back_ios),):Container(),
                      title: CustomText(
                        vm.selectListType == GeneralType.ActivityType ? 'Etkinlikler' : 'Sorular',
                        style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      pinned: true,
                      automaticallyImplyLeading: false,
                      expandedHeight: context.height / 2.02,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.parallax,
                        background: sliverBackroundWidget(context, vm),
                      ),
                    ),
                    vm.selectListType == GeneralType.QuestionType ?SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, int index) {
                          return QuestionSingleView(
                            questionModel: vm.questions!.elementAt(index),
                          );
                        },
                        childCount: vm.questions!.length,
                      ),
                    ):
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (_, int index) {
                          return ActivitySingleView(
                            activity: vm.activities!.elementAt(index),
                          );
                        },
                        childCount: vm.activities!.length,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  sliverBackroundWidget(BuildContext context, ProfileViewModel vm) {
    return GestureDetector(
      onTap: () async {
        if(userId==null)
        await context.navigationService.navigateTo(Routes.profileRedesignView)!.then((value) {
          vm.notifyListeners();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: context.height / 20,
            ),
            /// profil fotoğrafı
            Stack(
              children: [
                UserPhoto(
                  size: context.height / 6,
                  url: vm.viewUser.image,
                ),
                if(userId==null)Positioned(
                  right: 0,
                  child: Material(
                    color: context.theme.primaryColorDark,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.edit,
                        color: context.theme.primaryColorLight,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.height / 50,
            ),
            ///username
            CustomText(
              '@${vm.viewUser.userName}',
              style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: context.height / 50),
            buildUserInfoWidget(context,vm),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                radiusTextOntapWidget(context, isSelect: vm.selectListType == GeneralType.QuestionType, text: 'Sorular', onTap: () {
                  vm.selectListType = GeneralType.QuestionType;
                  vm.notifyListeners();
                }),
                radiusTextOntapWidget(context, isSelect: vm.selectListType == GeneralType.ActivityType, text: 'Etkinlikler', onTap: () {
                  vm.selectListType = GeneralType.ActivityType;
                  vm.notifyListeners();
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  radiusTextOntapWidget(BuildContext context, {String text = '', required Function() onTap, bool isSelect = false}) {
    Color color = isSelect ? context.theme.primaryColor : context.theme.primaryColorDark;
    Color color1 = isSelect ? context.theme.primaryColorLight : context.theme.primaryColorLight;
    return Container(
      width: 150,
      child: Column(
        children: [
          Material(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Ink(
              height: 40,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                splashColor: context.theme.primaryColor,
                onTap: onTap,
                child: Center(
                    child: CustomText(
                  text,
                  style: TextStyle(color: color == context.theme.primaryColor ? Colors.white : color1, fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: color,
          )
        ],
      ),
    );
  }

  Row buildUserInfoWidget(BuildContext context,ProfileViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconAndTextWidget(
              context,
              iconSize: 18,
              iconData: Icons.person,
              customText: CustomText(
                '${vm.viewUser.name} ${vm.viewUser.surname}',
                style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            SizedBox(height: 5),
            iconAndTextWidget(
              context,
              iconSize: 16,
              iconData: Icons.school,
              customText: CustomText(
                '${vm.viewUser.university!.name}',
                style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            SizedBox(height: 5),
            iconAndTextWidget(context,
                iconSize: 14,
                iconData: Icons.mosque,
                customText: CustomText(
                  '${vm.viewUser.department!.name}',
                  style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.w500, fontSize: 14),
                )),
          ],
        ),
      ],
    );
  }

  Row iconAndTextWidget(BuildContext context, {double iconSize = 16, IconData iconData = Icons.person, CustomText? customText}) {
    return Row(
      children: [
        Material(
          color: context.theme.primaryColorDark,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              iconData,
              color: context.theme.primaryColorLight,
              size: iconSize,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        customText ?? CustomText('')
      ],
    );
  }
}
