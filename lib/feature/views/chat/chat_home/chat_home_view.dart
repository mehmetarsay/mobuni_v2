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
import 'package:mobuni_v2/feature/views/chat/chat_home/widgets/chat_card.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:stacked/stacked.dart';
import 'widgets/big_image_view.dart';
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

}
