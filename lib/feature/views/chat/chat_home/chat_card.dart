import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/extension/date_time_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/views/chat/chat_group_info/chat_group_info_view.dart';
import 'package:mobuni_v2/feature/views/chat/chat_home/big_image_view.dart';
import 'package:mobuni_v2/feature/views/chat/chat_message/chat_message_view.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';

class ChatCard extends StatefulWidget {
  ChatCard({Key? key, required this.chat}) : super(key: key);
  final Chat chat;

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  var isActive = false;
  late final badgeNumber;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    badgeNumber =
        ((widget.chat.unReadInfo![GeneralManager.user.id] ?? UnReadInfo())
                .unReadMessage) ??
            0;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox()
        : Column(
            children: [
              InkWell(
                onTap: () async {
                  var data = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatMessageView(
                        chat: widget.chat,
                        isCreated: false,
                        // isSelect: widget.isSelect,
                        // data: widget.data,
                      ),
                    ),
                  );
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
                              if (widget.chat.type == ChatType.SINGLE.index) {
                                _showFullImage(widget.chat.receiverUser!.image,
                                    widget.chat.id!);
                              } else if (widget.chat.type ==
                                  ChatType.GROUP.index) {
                                GeneralManager.navigationS.navigateToView(
                                    ChatGroupInfoView(
                                        chat: widget.chat, isCreated: false));
                              }
                            },
                            child: Badge(
                              showBadge: badgeNumber > 0,
                              badgeContent: Text(
                                badgeNumber.toString(),
                                style: TextStyle(
                                  color: context.colors.onSecondary,
                                ),
                              ),
                              child: Hero(
                                tag: widget.chat.id!,
                                transitionOnUserGestures: true,
                                child: UserPhoto(
                                  currentUser: false,
                                  size: context.dynamicValue(0.05),
                                  assetPath:
                                      widget.chat.type == ChatType.GROUP.index
                                          ? 'assets/ic_group_chat.png'
                                          : null,
                                  url: widget.chat.type == ChatType.GROUP.index
                                      ? widget.chat.groupPhoto
                                      : widget.chat.receiverUser!.image,
                                ),
                              ),
                            ),
                          ),
                          isActive
                              ? Positioned(
                                  bottom: 4,
                                  right: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          width: 2,
                                        ),
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
                              : Container()
                        ],
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                widget.chat.type == ChatType.SINGLE.index
                                    ? widget.chat.receiverUser!.fullName
                                    : widget.chat.groupName!,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: context.colors.primary,
                              ),
                              if (widget.chat.lastMessage != null)
                                Row(
                                  children: [
                                    if (widget.chat.lastMessage?.sender ==
                                        GeneralManager.user.id)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Icon(
                                          widget.chat.lastMessage!.isReadMessage
                                              ? MdiIcons.checkAll
                                              : MdiIcons.check,
                                          size: 14,
                                        ),
                                      ),
                                    if (widget.chat.lastMessage != null &&
                                        widget.chat.lastMessage?.sender !=
                                            GeneralManager.user.id &&
                                        widget.chat.type ==
                                            ChatType.GROUP.index)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: CustomText(
                                            '${widget.chat.lastMessage?.senderName} : ',
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
                                          widget.chat.lastMessage
                                                      ?.messageType ==
                                                  MessageType.TEXT.index
                                              ? widget.chat.lastMessage
                                                      ?.message ??
                                                  ''
                                              : widget.chat.lastMessage
                                                          ?.messageType ==
                                                      MessageType.IMAGE.index
                                                  ? 'Fotoğraf'
                                                  : widget.chat.lastMessage
                                                              ?.messageType ==
                                                          MessageType.FILE.index
                                                      ? 'Dosya'
                                                      : widget.chat.lastMessage
                                                                  ?.messageType ==
                                                              MessageType
                                                                  .LOCATION
                                                                  .index
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
                                        ),
                                      ),
                                    ),
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
                              widget.chat.lastMessage != null
                                  ? widget
                                      .chat.lastMessage!.time!.formatDateToTime
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
              ),
              Divider()
            ],
          );
  }

  void _showFullImage(String? imagePath, String imageTag) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => BigImageView(
          imagePath: imagePath,
          imageTag: imageTag,
          backgroundOpacity: 200,
        ),
      ),
    );
  }
}
