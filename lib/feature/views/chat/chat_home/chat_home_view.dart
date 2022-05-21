import 'package:badges/badges.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/progress/custom_progress_widget.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/extension/date_time_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/views/chat/chat_group_info/chat_group_info_view.dart';
import 'package:mobuni_v2/feature/views/chat/chat_home/chat_card.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:stacked/stacked.dart';
import 'big_image_view.dart';
import '../chat_contact/chat_contact_view.dart';
import '../chat_message/chat_message_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'chat_home_view_model.dart';

class ChatHomeView extends StatefulWidget {
  const ChatHomeView({Key? key, this.isSelect = false, this.data = ''})
      : super(key: key);
  final bool isSelect;
  final dynamic data;
  @override
  _ChatHomeViewState createState() => _ChatHomeViewState();
}

class _ChatHomeViewState extends State<ChatHomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatHomeViewModel>.reactive(
        viewModelBuilder: () => ChatHomeViewModel(),
        onModelReady: (viewModel) => viewModel.initialize(context),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: viewModel.dataReady
                ? ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22), //Spacing.zero,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            // searchBox2(context, viewModel),
                            SizedBox(height: context.dynamicValue(0.01)),
                            ...(viewModel.isSearch!
                                    ? viewModel.searchChatList
                                    : viewModel.getChats)
                                .map(
                                  (chat) {
                                    print('a');
                                    return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8),
                                    child: ChatCard(chat: chat),
                                  );},
                                )
                                .toList(),
                          ],
                        ),
                      )
                    ],
                  )
                : ProgressIndicatorWidget(),
          );
        });
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Sohbet',
      actions: [
        IconButton(
          onPressed: () => GeneralManager.navigationS
              .navigateToView(ChatContactView(isCreateGroup: true)),
          icon: Icon(MdiIcons.accountMultipleOutline),
        ),
        IconButton(
          onPressed: () =>
              GeneralManager.navigationS.navigateToView(ChatContactView()),
          icon: Icon(MdiIcons.messagePlus),
        ),
      ],
    );
  }

  Container searchBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.secondaryContainer.withAlpha(140),
          //context.colors.background,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.all(6), //Spacing.all(6),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: TextFormField(
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    letterSpacing: 0),
                decoration: InputDecoration(
                  hintText: 'Search messages',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSecondary,
                      letterSpacing: 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none),
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Icon(
                MdiIcons.magnify,
                color: Theme.of(context).colorScheme.onSecondary,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container searchBox2(BuildContext context, ChatHomeViewModel viewModel) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomTextFormField(
                controller: viewModel.searchController,
                // prefixIcon: Icon(
                //   EstateIcon.search,
                //   color: Color(0xff2E2E2D),
                //   size: 20,
                // ),
                hintText: 'Arama yapın',
                focusNode: viewModel.focus,
                insideHint: true),
          ),
        ],
      ),
    );
  }

  void _showFullImage(String? imagePath, String imageTag) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => BigImageView(
              imagePath: imagePath,
              imageTag: imageTag,
              backgroundOpacity: 200,
            )));
  }

  Widget singleChat({required Chat chat}) {
    var isActive = false;
    var badgeNumber =
        ((chat.unReadInfo![GeneralManager.user.id] ?? UnReadInfo())
                .unReadMessage) ??
            0;
    return InkWell(
      onTap: () async {
        var data = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatMessageView(
                      chat: chat,
                      isCreated: false,
                      isSelect: widget.isSelect,
                      data: widget.data,
                    )));
        if (data == true) {
          Navigator.pop(context);
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    if (chat.type == ChatType.SINGLE.index) {
                      _showFullImage(chat.receiverUser!.image, chat.id!);
                    } else if (chat.type == ChatType.GROUP.index) {
                      GeneralManager.navigationS.navigateToView(
                          ChatGroupInfoView(chat: chat, isCreated: false));
                    }
                  },
                  child: Badge(
                    showBadge: badgeNumber > 0,
                    badgeContent: Text(
                      badgeNumber.toString(),
                      style: TextStyle(color: context.colors.onSecondary),
                    ),
                    child: Hero(
                        tag: chat.id!,
                        transitionOnUserGestures: true,
                        child: UserPhoto(
                          currentUser: false,
                          size: context.dynamicValue(0.05),
                          assetPath: chat.type == ChatType.GROUP.index
                              ? 'assets/ic_group_chat.png'
                              : null,
                        )),
                  ),
                ),
                // isActive ? 
                    Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  width: 2),
                              shape: BoxShape.circle),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Color(0xff42e031),
                                shape: BoxShape.circle),
                          ),
                        ),
                      )
                    // : Container()
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      chat.type == ChatType.SINGLE.index
                          ? chat.receiverUser!.fullName
                          : chat.groupName!,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(
                          0xff2e2e2d), //context.context.theme.primaryColorDark,
                    ),
                    Row(
                      children: [
                        if (chat.lastMessage?.sender == GeneralManager.user.id)
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                // MdiIcons.check,
                                chat.lastMessage!.isReadMessage
                                    ? MdiIcons.checkAll
                                    : MdiIcons.check,
                                size: 14),
                          ),
                        if (chat.lastMessage != null &&
                            chat.lastMessage?.sender !=
                                GeneralManager.user.id &&
                            chat.type == ChatType.GROUP.index)
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: CustomText(
                                '${chat.lastMessage?.senderName} : ',
                                fontSize: 15,
                                fontWeight: badgeNumber > 0
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: context.colors.primary),
                          ),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.only(right: 13.0),
                                child: Text(
                                  chat.lastMessage?.messageType ==
                                          MessageType.TEXT.index
                                      ? chat.lastMessage?.message ?? ''
                                      : chat.lastMessage?.messageType ==
                                              MessageType.IMAGE.index
                                          ? 'Fotoğraf'
                                          : chat.lastMessage?.messageType ==
                                                  MessageType.FILE.index
                                              ? 'Dosya'
                                              : chat.lastMessage?.messageType ==
                                                      MessageType.LOCATION.index
                                                  ? 'Konum'
                                                  : '',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: badgeNumber > 0
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  overflow: TextOverflow.ellipsis,
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    chat.lastMessage != null
                        ? chat.lastMessage!.time!.formatDateToTime
                        : '',
                    style: TextStyle(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.2),
                  ),
                  //badgeWidget
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
