import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/profile/profile_tab_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileTabViewModel>.reactive(
      // onModelReady: (model) => model.init()
      builder: (context, vm, child) => SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: vm.controller,
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                title:Container(
                  color: Colors.white,
                  child: CustomText(
                    vm.selectListType==ProfileListType.ActivityType?'Etkinlikler':'Sorularım',
                    style: TextStyle(color: context.theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ) ,
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: context.height / 2.02,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,

                  background: sliverBackroundWidget(context,vm),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return QuestionSingleView( questionModel: vm.questions!.elementAt(index),onTapNavigate: true,);

                  },
                  childCount: vm.questions!.length,
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ProfileTabViewModel(),
    );
  }

   sliverBackroundWidget(BuildContext context,ProfileTabViewModel vm) {
    return GestureDetector(
      onTap: (){
        context.navigationService.navigateTo(Routes.profileRedesignView);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: context.height / 15,
            ),
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: Constants.mehmetPhoto,
                  imageBuilder: (context, imageProvider) => Container(
                    width: context.height / 6,
                    height: context.height / 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned(
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
            CustomText(
              '@mehmetarsay',
              style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: context.height / 50),
            buildUserInfoWidget(context),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                radiusTextOntapWidget(context,isSelect:vm.selectListType==ProfileListType.QuestionType,text: 'Sorularım',onTap: (){
                  vm.selectListType=ProfileListType.QuestionType;
                }),
                radiusTextOntapWidget(context,isSelect:vm.selectListType==ProfileListType.ActivityType,text: 'Etkinliklerim',onTap: (){
                  vm.selectListType=ProfileListType.ActivityType;
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

   radiusTextOntapWidget(BuildContext context,{String text='',required Function() onTap,bool isSelect=false}) {
    Color color = isSelect?context.theme.primaryColor:context.theme.primaryColorDark;
    Color color1 = isSelect?context.theme.primaryColorLight:context.theme.primaryColorLight;
    return Container(
      width: 150,
      child: Column(
        children: [
          Material(
            color: color,
            borderRadius:BorderRadius.all(Radius.circular(15)) ,
            child: Ink(
              height: 40,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                splashColor: context.theme.primaryColor,
                onTap:onTap,
                child: Center(
                    child: CustomText(
                  text,
                  style: TextStyle(color: color==context.theme.primaryColor?Colors.white:color1, fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            ),
          ),
          Divider(thickness: 2,color: color,)
        ],
      ),
    );
  }

  Row buildUserInfoWidget(BuildContext context) {
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
                'Mehmet Arsay',
                style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            SizedBox(height: 5),
            iconAndTextWidget(
              context,
              iconSize: 16,
              iconData: Icons.school,
              customText: CustomText(
                'İstanbul Medeniyet Üniversitesi',
                style: TextStyle(color: context.theme.primaryColorDark, fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            SizedBox(height: 5),
            iconAndTextWidget(context,
                iconSize: 14,
                iconData: Icons.mosque,
                customText: CustomText(
                  'Bilgisayar Mühendisliği',
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
