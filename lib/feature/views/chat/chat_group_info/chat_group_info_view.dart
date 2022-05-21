import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/progress/custom_progress_widget.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/models/messaging/user_chat_info.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:stacked/stacked.dart';

import 'chat_group_info_view_model.dart';

class ChatGroupInfoView extends StatefulWidget {
  final Chat chat;
  final bool isCreated;

  const ChatGroupInfoView(
      {Key? key, required this.chat, required this.isCreated})
      : super(key: key);

  @override
  State<ChatGroupInfoView> createState() => _ChatGroupInfoViewState();
}

class _ChatGroupInfoViewState extends State<ChatGroupInfoView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatGroupInfoViewModel>.reactive(
        viewModelBuilder: () => ChatGroupInfoViewModel(context, widget.chat),
        onModelReady: (viewModel) =>
            viewModel.initialize(context, widget.chat.users!),
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: CustomAppBar(title: widget.chat.groupName),
              body: Stack(alignment: Alignment.bottomCenter, children: [
                !viewModel.isLoading
                    ? Container(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            isGrup(viewModel),
                            SizedBox(height: context.dynamicValue(.02)),
                            userList(viewModel),
                            SizedBox(height: context.dynamicValue(.02)),
                            updateGrup(viewModel),
                            SizedBox(height: context.dynamicValue(.02)),
                          ],
                        ),
                      )
                    : ProgressIndicatorWidget(),
                Visibility(
                    visible: viewModel.isLoading,
                    child: Container(
                      height: context.dynamicValue(1),
                      width: context.dynamicWidth(1),
                      color: Colors.grey.withOpacity(0.5),
                      child: ProgressIndicatorWidget(),
                    )),
              ]));
        });
  }

  Widget isGrup(ChatGroupInfoViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: context.colors.secondary.withOpacity(0.4),
                    blurRadius: 12,
                    offset: Offset(0, 8),
                    spreadRadius: 0),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CustomTextFormField(
                    controller: viewModel.groupTitleController,
                    hintText: 'Grup Adı',
                  ),
                ),
                Container(
                  child: CustomTextFormField(
                    hintText: 'Grub Açıklaması',
                    controller: viewModel.groupDescController,
                    insideHint: true,
                  ),
                ),
                SizedBox(height: context.dynamicValue(0.02)),
                InkWell(
                  onTap: () {
                    if (widget.chat.groupFounder == GeneralManager.user.id) {
                      viewModel.imgFromGallery();
                    }
                  },
                  child: Center(
                    child: UserPhoto(
                      url: viewModel.chat.groupPhoto,
                      size: 60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userList(ChatGroupInfoViewModel viewModel) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        children: [
          Column(
            children: viewModel.getGroupUsers
                .map((map) => singleContact(map, null, viewModel))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget singleContact(UserModel? user, UserChatInfo? userChatInfo,
      ChatGroupInfoViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(top: 16), //Spacing.top(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              UserPhoto(url: user!.image, size: 50),
              userChatInfo != null && userChatInfo.isOnline!
                  ? Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: context.theme.colorScheme
                                  .onSecondary, //customAppTheme.bgLayer1,
                              width: 2,
                            ),
                            shape: BoxShape.circle),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color:
                                  Colors.green, //customAppTheme.colorSuccess,
                              shape: BoxShape.circle),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: CustomText(
                '${user.fullName} ${user.id == GeneralManager.user.id ? '(sen)' : ''}',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: context.colors.primary,
              ),
            ),
            widget.chat.groupFounder == user.id
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    child: CustomText(
                      'Yönetici',
                      textAlign: TextAlign.left,
                      color: context.colors.primary.withOpacity(0.7),
                    ),
                  )
                : SizedBox()
          ]),
          Spacer(),
          (widget.chat.groupFounder == GeneralManager.user.id &&
                  user.id != GeneralManager.user.id)
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    viewModel.deleteUserGroup(user.id!);
                                  },
                                  child: CustomText(
                                    'Kişiyi Çıkar',
                                    textAlign: TextAlign.left,
                                    color: context.colors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.more_horiz,
                    size: 30,
                    color: context.colors.primary,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  dynamic updateGrup(ChatGroupInfoViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.chat.groupFounder == GeneralManager.user.id)
            _buildButton(
              text: 'Sil',
              onPressed: () async {
                // optionalAlertDialog(
                //     context, 'Grubu Sil', 'Vazgeç', 'Sil', () async {
                //   await viewModel.deleteGroup();
                // },
                //     content:
                //         'Grubu silmek istediğinizden emin misiniz Grubu ait tüm bilgiler silinecektir.');
              },
            ),
          if (widget.chat.groupFounder == GeneralManager.user.id) Spacer(),
          _buildButton(
            text: 'Çık',
            onPressed: () {
              // optionalAlertDialog(context, 'Gruptan Çık', 'Vazgeç', 'Çık',
              //     () async {
              //   await viewModel.exitGroup(widget.isCreated);
              // }, content: 'Grubtan çıkmak istediğinizden emin misiniz');
            },
          ),
          Spacer(flex: 2),
          if (widget.chat.groupFounder == GeneralManager.user.id)
            SizedBox(
              width: context.dynamicWidth(0.4),
              child: _buildButton(
                text: 'Güncelle',
                onPressed: () => viewModel.updateGroup(),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildButton({required String text, void Function()? onPressed}) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor:
              MaterialStateProperty.all<Color>(context.colors.primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      onPressed: onPressed ?? () {},
      child: CustomText(
        text,
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: context.theme.scaffoldBackgroundColor,
      ),
    );
  }
}
