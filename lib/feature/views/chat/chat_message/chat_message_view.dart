import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/progress/custom_progress_widget.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/extension/date_time_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/models/messaging/message.dart';
import 'package:mobuni_v2/feature/views/chat/chat_group_info/chat_group_info_view.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:path/path.dart' as p;
import '../chat_media_preview/chat_media_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chat_message_view_model.dart';

class ChatMessageView extends StatefulWidget {
  final Chat chat;
  final bool isCreated;
  final bool isSelect;
  final dynamic data;
  const ChatMessageView(
      {Key? key,
      required this.chat,
      required this.isCreated,
      this.isSelect = false,
      this.data = ''})
      : super(key: key);

  @override
  _ChatMessageViewState createState() => _ChatMessageViewState();
}

class _ChatMessageViewState extends State<ChatMessageView> {
  @override
  void initState() {
    super.initState();
    // GlobalValue.activeChatReceiverGid = widget.chat.receiverUser!.gid;
    FirebaseService.instance!
        .updateUserState(true, currentCahtId: widget.chat.id);
  }

  @override
  void dispose() {
    super.dispose();
    // GlobalValue.activeChatReceiverGid = '';
    FirebaseService.instance!.updateUserState(true, currentCahtId: null);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatMessageViewModel>.reactive(
        viewModelBuilder: () => ChatMessageViewModel(widget.chat),
        onModelReady: (viewModel) => viewModel.onModelReadyInitialize(
            context, widget.chat.id!, widget.isSelect, widget.data!),
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: customHeader(viewModel),
              body: GestureDetector(
                onTap: () {
                  if (viewModel.isMoreAction) {
                    viewModel.isMoreAction = false;
                  }
                },
                child: Stack(
                  children: [
                    viewModel.dataReady('message')
                        ? Container(
                            child: Column(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 16, right: 16, bottom: 8),
                                    child: ListView(
                                      controller: viewModel.scrollController,
                                      physics: ClampingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      reverse: true,
                                      children: viewModel.getMessages.reversed
                                          .map((message) {
                                        var index = viewModel.getMessages
                                            .indexOf(message);
                                        return Container(
                                            margin: index == 0
                                                ? EdgeInsets.only(top: 12, bottom: 6).add(message
                                                            .sender ==
                                                        GeneralManager.user.id
                                                    ? EdgeInsets.only(
                                                        left: context
                                                            .dynamicWidth(0.2))
                                                    : EdgeInsets.only(
                                                        right: context
                                                            .dynamicWidth(0.2)))
                                                : EdgeInsets.only(top: 6, bottom: 6)
                                                    .add(message.sender ==
                                                            GeneralManager.user.id
                                                        ? EdgeInsets.only(left: context.dynamicWidth(0.2))
                                                        : EdgeInsets.only(right: context.dynamicWidth(0.2))),
                                            alignment: message.sender == GeneralManager.user.id ? Alignment.centerRight : Alignment.centerLeft,
                                            child: _buildMessageField(index, message, viewModel));
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                Container(child: bottomBarWidget(viewModel))
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
                        ))
                  ],
                ),
              ));
        });
  }

  AppBar appBarWidget(ChatMessageViewModel viewModel) {
    return AppBar(
      title: InkWell(
        // onTap: widget.chat.type == ChatType.SINGLE.index
        //     ? null
        //     : () => GeneralManager.navigationS.navigateTo(ChatGroupInfoView(
        //           chat: widget.chat,
        //           isCreated: widget.isCreated,
        //         )),
        child: Row(
          children: [
            UserPhoto(
              currentUser: false,
              size: context.dynamicValue(0.05),
              url: widget.chat.type == ChatType.GROUP.index
                  ? widget.chat.groupPhoto
                  : null,
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      widget.chat.type == ChatType.SINGLE.index
                          ? widget.chat.receiverUser?.fullName
                          : widget.chat.groupName!,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.5),
                  viewModel.chat.type == ChatType.SINGLE.index &&
                          viewModel.dataReady('userState') &&
                          viewModel.userState
                      ? CustomText('Çevrimiçi',
                          fontSize: 15, color: context.colors.secondary)
                      : viewModel.chat.type == ChatType.SINGLE.index &&
                              viewModel.dataReady('userState') &&
                              viewModel.lastSeen != null
                          ? CustomText('viewModel.lastSeen!.customFormatDate',
                              fontSize: 15, color: Colors.white)
                          : SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.theme.primaryColorDark,
      centerTitle: true,
      iconTheme: IconThemeData(color: context.theme.primaryColor),
    );
  }

  dynamic customHeader(ChatMessageViewModel viewModel) {
    return CustomAppBar(
      titleWidget: InkWell(
        onTap: widget.chat.type == ChatType.SINGLE.index
            ? null
            : () => GeneralManager.navigationS.navigateToView(
                  ChatGroupInfoView(
                    chat: widget.chat,
                    isCreated: widget.isCreated,
                  ),
                ),
        child: Row(
          children: [
            UserPhoto(
              currentUser: false,
              size: context.dynamicValue(0.05),
              assetPath: widget.chat.type == ChatType.GROUP.index
                  ? 'assets/ic_group_chat.png'
                  : null,
              url: widget.chat.type == ChatType.GROUP.index
                  ? widget.chat.groupPhoto
                  : widget.chat.receiverUser != null
                      ? widget.chat.receiverUser!.image
                      : null,
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      widget.chat.type == ChatType.SINGLE.index
                          ? widget.chat.receiverUser?.fullName
                          : widget.chat.groupName!,
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                      fontSize: 12),
                  viewModel.chat.type == ChatType.SINGLE.index &&
                          viewModel.dataReady('userState') &&
                          viewModel.userState
                      ? CustomText(
                          'Çevrimiçi',
                          fontSize: 12,
                          color: context.colors.primary.withOpacity(0.7),
                        )
                      : viewModel.chat.type == ChatType.SINGLE.index &&
                              viewModel.dataReady('userState') &&
                              viewModel.lastSeen != null
                          ? CustomText(viewModel.lastSeen!.customFormatDate,
                              fontSize: 12,
                              color: context.colors.primary.withOpacity(0.7))
                          : SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBarWidget(ChatMessageViewModel viewModel) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xffacacac).withOpacity(0.1), //context.colors.onSecondary,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        boxShadow: [
          // BoxShadow(color: context.theme.primaryColorDark, blurRadius: 8)
        ],
        //border: Border.all(color: context.theme.primaryColorDark
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        onEnd: () => viewModel.showMenu = viewModel.isExpanded,
        height: viewModel.isExpanded ? 130 : 50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    viewModel.isExpanded = !viewModel.isExpanded;
                    if (!viewModel.showMenu) viewModel.showMenu = true;
                  },
                  child: Icon(
                    MdiIcons.plus,
                    color: Color(0xff919195), //context.theme.primaryColorDark,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5), //Spacing.left(16),
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      toolbarOptions: ToolbarOptions(
                        paste: true,
                        cut: true,
                        copy: true,
                        selectAll: true,
                      ),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: context.theme.primaryColorDark),
                      decoration: InputDecoration(
                        hintText: 'Mesaj yazın',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(
                                0xff919195) //context.theme.primaryColorDark
                            ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                                color: Color(0xffacacac).withOpacity(0.1),
                                width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                                color: Color(0xffacacac).withOpacity(0.1),
                                width: 0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                color: Color(0xffacacac).withOpacity(0.1),
                                width: 0)),
                        isDense: true,

                        contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                        //filled: true,
                        //fillColor: context.colors.onSecondary
                      ),
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (message) {
                        viewModel.sendMessage();
                      },
                      controller: viewModel.chatTextController,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    viewModel.sendMessage();
                  },
                  child: Icon(
                    MdiIcons.send,
                    color: Color(0xff919195),
                    size: 20,
                  ),
                ),
              ],
            ),
            viewModel.showMenu
                ? Container(
                    margin: EdgeInsets.only(top: 16), //Spacing.top(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMediaShareButton(
                          iconData: MdiIcons.imageOutline,
                          title: 'Fotoğraf',
                          onPressed: () => viewModel.loadImages(),
                        ),
                        // optionWidget(
                        //     iconData: MdiIcons.mapMarkerOutline,
                        //     title: 'Konum',
                        //     onPressed: () => viewModel.sendLocation()),
                        // optionWidget(
                        //     iconData: MdiIcons.accountOutline,
                        //     title: 'Contact'),
                        _buildMediaShareButton(
                          iconData: MdiIcons.fileDocumentOutline,
                          title: 'Dosya',
                          onPressed: () => viewModel.loadFile(),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildMediaShareButton({
    IconData? iconData,
    String title = '',
    void Function()? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.theme.primaryColorDark.withAlpha(40),
            ),
            child: Icon(
              iconData,
              color: context.theme.primaryColorDark,
              size: 22,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: CustomText(
              title,
              fontWeight: FontWeight.w600,
              color: context.theme.primaryColorDark,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageField(
    int index,
    Message message,
    ChatMessageViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: message.sender == GeneralManager.user.id
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        InkWell(
          onLongPress: message.sender == GeneralManager.user.id
              ? () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return Container(
                          // color: Colors.transparent,
                          child: Container(
                            // decoration: BoxDecoration(color: Colors.white60),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: message.receiverList!
                                    .map((e) =>
                                        singleContact(e, message.isReadMap!))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                      });
                }
              : null,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(
                color: (message.messageType != MessageType.IMAGE.index &&
                        message.messageType != MessageType.FILE.index &&
                        message.messageType != MessageType.LOCATION.index)
                    ? (message.sender == GeneralManager.user.id
                        ? context.colors.primary.withOpacity(0.4)
                        : context.theme.primaryColor)
                    : null,
                border: message.sender == GeneralManager.user.id ? null : null,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.sender != GeneralManager.user.id &&
                    widget.chat.type == ChatType.GROUP.index)
                  CustomText(
                    message.senderName,
                    color: Colors.white,
                  ),
                if (message.messageType == MessageType.IMAGE.index &&
                    message.imageList!.isNotEmpty)
                  InkWell(
                    onTap: () async {
                      if (message.messageType == MessageType.IMAGE.index) {
                        await GeneralManager.navigationS.navigateToView(
                          ChatMediaPreviewView(
                            chat: widget.chat,
                            imageList: message.imageList,
                            type: 1,
                          ),
                        );
                      }
                    },
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          message.imageList!.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          bottom: 7,
                          right: 7,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: context.colors.primary,
                            child: CustomText(
                              message.imageList!.length.toString(),
                              color: context.theme.scaffoldBackgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ))
                    ]),
                  ),
                // if (message.messageType == MessageType.LOCATION.index)
                //   ChatMapMessageContainer(
                //       message.latitude!, message.longitude!),
                if (message.messageType == MessageType.FILE.index)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: _buildMediaIcon(message.fileName!),
                    title: CustomText(message.fileName,
                        fontWeight: FontWeight.w400, fontSize: 16),
                    onTap: () async {
                      print('ab');
                      var url = message.filePath;
                      // if (await canLaunch(url!)) {
                      await launchUrl(Uri.parse(url!));
                      // } else {
                      //   throw 'Could not launch $url';
                      // }
                      // await e
                      //     .open();
                    },
                  ),
                if (message.message!.isNotEmpty)
                  SelectableText(
                    message.message!,
                    onTap: () async {
                      // var a = message.message!.substring(0, 3);
                      // var b = !message.message!.contains(' ');
                      if (message.messageType == MessageType.TEXT.index) {
                        if (await canLaunchUrl(Uri.parse(message.message!))) {
                          await launchUrl(Uri.parse(message.message!));
                        } else if (message.message!.substring(0, 3) == "www" &&
                            message.message!.contains('.')) {
                          await launchUrl(
                              Uri.parse('https://' + message.message!));
                        }
                      }
                    },
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: message.sender == GeneralManager.user.id
                            ? context.colors.primary //context.colors.onSurface
                            : Color(0xffffffff), //context.colors.onSecondary,
                        letterSpacing: 0.1),
                  ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(message.time!.customFormatDate4,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: context.colors
                    .primary), //context.theme.primaryColorDark, fontSize: 14),
            if (message.sender == GeneralManager.user.id)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                    message.isReadMessage ? MdiIcons.checkAll : MdiIcons.check,
                    size: 14),
              ),
          ],
        )
      ],
    );
  }

  Widget _buildMediaIcon(String path) {
    print(p.extension(path));
    var icon;
    switch (p.extension(path)) {
      case '.pdf':
        icon = Icons.picture_as_pdf;
        break;
      case '.mp4':
        icon = Icons.perm_media;
        break;
      case '.png':
      case '.jpg':
        icon = Icons.image;
        break;
      case '.ppsx':
      case '.ppt':
      case '.pptm':
      case '.pptx':
        icon = Icons.access_alarm;
        break;
      case '.docs':
      case '.dot':
      case '.dotx':
        icon = Icons.ac_unit;
        break;

      case '.xlsx':
      case '.xlsm':
      case '.xlsb':
      case '.xltx':
        icon = Icons.abc;
        break;
      default:
        icon = Icons.file_copy;
    }
    return CircleAvatar(
          backgroundColor: Color(0xffacacac).withOpacity(0.2),
          radius: 20,
          child: Icon(
            Icons.picture_as_pdf,
            color: Colors.grey.shade800,
          ),
        );
  }

  Widget singleContact(String userId, Map isReadMap) {
    var user = GeneralManager.userDummy;
    // GeneralManager.userList!.firstWhere((element) => element.gid == userId);
    return Container(
      margin: EdgeInsets.only(top: 16), //Spacing.top(16),
      child: Row(
        children: <Widget>[
          UserPhoto(url: user.image, size: 50),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: CustomText(
                user.fullName,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: context.colors.primary,
              ),
            ),
          ),
          Icon(
            isReadMap[userId] ? MdiIcons.checkAll : MdiIcons.check,
            size: 14,
          )
        ],
      ),
    );
  }
}
