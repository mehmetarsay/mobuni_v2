import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/progress/custom_progress_widget.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/user_chat_info.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';

import 'chat_contact_view_model.dart';
import '../chat_message/chat_message_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

class ChatContactView extends StatefulWidget {
  final bool isCreateGroup;
  const ChatContactView({
    Key? key,
    this.isCreateGroup = false,
  }) : super(key: key);

  @override
  _ChatContactViewState createState() => _ChatContactViewState();
}

class _ChatContactViewState extends State<ChatContactView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatContactViewModel>.reactive(
      viewModelBuilder: () => ChatContactViewModel(context),
      onModelReady: (viewModel) => viewModel.initialize(context),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: _buildAppBar(viewModel),
          bottomNavigationBar: createGrup(viewModel),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  Widget _buildBody(ChatContactViewModel viewModel) {
    return viewModel.dataReady && !viewModel.isLoading
        ? Container(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      if (widget.isCreateGroup)
                        if (widget.isCreateGroup)
                          !viewModel.isforward
                              ? _buildSearchBox(context, viewModel)
                              : SizedBox(),
                      (viewModel.selectUserListPhoto.isNotEmpty &&
                              !viewModel.isforward)
                          ? Container(
                              height: context.dynamicValue(0.1),
                              width: context.dynamicWidth(1),
                              child: selectUserPhotoList(viewModel),
                            )
                          : SizedBox(),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            if (widget.isCreateGroup && viewModel.isforward)
                              isGrup(viewModel),
                            if (!viewModel.isforward)
                              Container(
                                margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                                child: viewModel.isSearch!
                                    ? Column(
                                        children: viewModel.searchUserList
                                            .map((map) => singleContact(
                                                viewModel, map, null))
                                            .toList())
                                    : Column(
                                        children: viewModel.contacts
                                            .map(
                                              (map) => singleContact(
                                                viewModel,
                                                map[0],
                                                map[1],
                                              ),
                                            )
                                            .toList()),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : ProgressIndicatorWidget();
  }

  Container _buildSearchBox(
      BuildContext context, ChatContactViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomTextFormField(
                controller: viewModel.searchController,
                hintText: 'Arama yapın',
                focusNode: viewModel.focus,
                insideHint: true),
          ),
        ],
      ),
    );
  }

  CustomAppBar _buildAppBar(ChatContactViewModel viewModel) {
    return CustomAppBar(
      title: 'Kullanıcılar',
      actions: [appbarAction(viewModel)],
    );
  }

  dynamic appbarAction(ChatContactViewModel viewModel) {
    return (widget.isCreateGroup && !viewModel.isforward)
        ? InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: context.colors.primary.withOpacity(0.25),
                borderRadius: BorderRadius.circular(9),
                child: TextButton(
                  onPressed: () async {
                    if (!viewModel.selectUserList.isNotEmpty) {
                      await Fluttertoast.showToast(
                          msg: 'Lütfen en az 1 kişi seçiniz');
                    } else {
                      viewModel.isforward = true;
                    }
                  },
                  child: CustomText(
                    'İleri',
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
  }

  Widget singleContact(
    ChatContactViewModel viewModel,
    UserModel? user,
    UserChatInfo? userChatInfo,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 16), //Spacing.top(16),
      child: InkWell(
        onTap: widget.isCreateGroup
            ? null
            : () async {
                var chat = await FirebaseService.instance!.getChat(
                    [GeneralManager.user.id!, user!.id!], ChatType.SINGLE);
                await GeneralManager.navigationS.navigateToView(
                  ChatMessageView(
                    chat: chat,
                    isCreated: true,
                  ),
                );
              },
        child: Row(
          children: <Widget>[
            Stack(
              children: [
                UserPhoto(
                  url: user!.image,
                  currentUser: false,
                  size: context.dynamicValue(0.05),
                ),
                userChatInfo != null && userChatInfo.isOnline != null && userChatInfo.isOnline!
                    ? Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: context.colors.onSecondary,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      user.fullName,
                      color: context.colors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isCreateGroup)
              Container(
                child: !viewModel.selectUserList.contains(user.id)
                    ? IconButton(
                        color: context.colors.secondary,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          viewModel.selectUserListUpdate(user.id!,
                              image: user.image, fullname: user.fullName);
                        },
                        icon: Icon(
                          Icons.add,
                          color: context.colors.primary,
                        ),
                      )
                    : CircleAvatar(
                        radius: 17,
                        backgroundColor: context.theme.primaryColor,
                        child: IconButton(
                          color: context.theme.primaryColor,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            viewModel.selectUserListUpdate(user.id!,
                                isRemove: true);
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
              )
          ],
        ),
      ),
    );
  }

  Container cardContainer(String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle(title),
          textSubtitle(subtitle),
        ],
      ),
    );
  }

  Text textSubtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }

  Text textTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: Theme.of(context).colorScheme.secondaryContainer.withAlpha(180),
        fontSize: 13,
      ),
    );
  }

  Container buildExtraButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Icon(
              MdiIcons.shareVariant,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: Text(
              'Invite Friends',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Theme.of(context).colorScheme.secondaryContainer),
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(
              MdiIcons.helpCircle,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: Text(
              'Contacts Help',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Theme.of(context).colorScheme.secondaryContainer),
            ),
          ),
        ],
      ),
    );
  }

  Widget isGrup(ChatContactViewModel viewModel) {
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
                    controller: viewModel.groupDescController,
                    insideHint: true,
                    hintText: 'Grup Açıklaması',
                  ),
                ),
                SizedBox(height: context.dynamicValue(0.05)),
                viewModel.imageFile != null
                    ? InkWell(
                        onTap: () {
                          viewModel.imgFromGallery();
                        },
                        child: Center(
                          child: Container(
                            child: Image.file(
                              viewModel.imageFile!,
                              fit: BoxFit.cover,
                              height: context.dynamicValue(0.09),
                              width: context.dynamicWidth(0.2),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          viewModel.imgFromGallery();
                        },
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt, size: 25),
                              SizedBox(height: context.dynamicValue(0.01)),
                              CustomText(
                                'Grup için Görsel Seçin',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: context.colors.primary,
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: context.dynamicValue(0.05)),
          Container(
            height: context.dynamicValue(0.3),
            width: context.dynamicWidth(1),
            child: isForwardPhotoList(viewModel),
          ),
        ],
      ),
    );
  }

  Widget selectUserPhotoList(ChatContactViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: context.colors.primary.withOpacity(0.046), boxShadow: []),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2),
          CustomText('Seçilen Kişiler'),
          SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.selectUserList.length,
              itemBuilder: (contex, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: context.theme.primaryColor, width: 3),
                        ),
                        child: UserPhoto(
                          url: viewModel.selectUserListPhoto[index].image,
                          currentUser: false,
                          size: context.dynamicValue(0.05),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget isForwardPhotoList(ChatContactViewModel viewModel) {
    return Container(
      child: ListView.builder(
        itemCount: viewModel.selectUserListPhoto.length,
        itemBuilder: (contex, index) {
          return Column(
            children: [
              Row(
                children: [
                  UserPhoto(
                    url: viewModel.selectUserListPhoto[index].image,
                    currentUser: false,
                    size: context.dynamicValue(0.05),
                  ),
                  Spacer(flex: 1),
                  CustomText(
                    viewModel.selectUserListPhoto[index].fullname,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: context.colors.primary,
                  ),
                  Spacer(flex: 5),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: context.theme.primaryColor,
                    child: IconButton(
                      color: context.theme.primaryColor,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: context.dynamicValue(0.01)),
            ],
          );
        },
      ),
    );
  }

  Widget createGrup(ChatContactViewModel viewModel) {
    return (widget.isCreateGroup && viewModel.isforward)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .06,
            margin: EdgeInsets.only(bottom: 24, left: 20, right: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(context.colors.secondary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () async {
                if (viewModel.selectUserList.isNotEmpty) {
                  if (viewModel.groupTitleController.text.isNotEmpty) {
                    viewModel.selectUserListUpdate(GeneralManager.user.id!);
                    var chat = await FirebaseService.instance!.getChat(
                        viewModel.selectUserList, ChatType.GROUP,
                        groupName: viewModel.groupTitleController.text,
                        groupDesc: viewModel.groupDescController.text);
                    var url = await viewModel.updateGrupPhotoFirebase(chat.id!);
                    if (url != null) {
                      chat.groupPhoto = url;
                    }
                    viewModel.isforward = false;

                    await GeneralManager.navigationS
                        .navigateToView(ChatMessageView(
                      chat: chat,
                      isCreated: true,
                    ));
                  } else {
                    await Fluttertoast.showToast(
                        msg: 'Grup adı boş bırakılamaz');
                  }
                } else {
                  await Fluttertoast.showToast(
                      msg: 'Lütfen en az 1 kişi seçiniz');
                }
              },
              child: Text(
                'Grup Oluştur',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
          )
        : SizedBox();
  }
}
