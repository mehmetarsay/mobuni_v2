import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/progress/custom_progress_widget.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:stacked/stacked.dart';
import 'chat_media_preview_view_model.dart';

/// type = 0 => Fotoğraf Gönderme
/// type = 1 => Fotoğraf Görüntüleme
class ChatMediaPreviewView extends StatelessWidget {
  final Chat? chat;
  final List<Media>? mediaList;
  final List<String>? imageList;
  final int? type;

  ChatMediaPreviewView(
      {Key? key, this.mediaList, this.chat, this.type, this.imageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatMediaPreviewViewModel>.reactive(
        viewModelBuilder: () =>
            ChatMediaPreviewViewModel(context, chat, mediaList),
        onModelReady: (viewModel) {},
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: type == 0 ? 'Medya Gönder' : 'Medya Görüntüleme',
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: context.theme.scaffoldBackgroundColor,
                      child: PageView(
                        children: type == 0
                            ? mediaList!
                                .map((media) => Container(
                                    child: Image.file(File(media.path!))))
                                .toList()
                            : imageList!
                                .map((image) =>
                                    Container(child: Image.network(image)))
                                .toList(),
                      ),
                    )),
                    type == 0
                        ? Container(
                            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                            color: context.theme.scaffoldBackgroundColor,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    //Spacing.left(16),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              context.theme.primaryColorDark),
                                      decoration: InputDecoration(
                                        hintText: 'Mesaj yaz',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff919195),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          borderSide: BorderSide(
                                              color: Color(0xffacacac)
                                                  .withOpacity(0.1),
                                              width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          borderSide: BorderSide(
                                              color: Color(0xffacacac)
                                                  .withOpacity(0.1),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          borderSide: BorderSide(
                                            color: Color(0xffacacac)
                                                .withOpacity(0.1),
                                            width: 1,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(16, 12, 16, 12),
                                        filled: true,
                                        fillColor:
                                            Color(0xffacacac)
                                                .withOpacity(0.1)
                                      ),
                                      textInputAction: TextInputAction.send,
                                      onFieldSubmitted: (message) {
                                        viewModel.sendMessage();
                                      },
                                      controller: viewModel.controller,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffacacac)
                                                .withOpacity(0.1),
                                      border: Border.all(
                                          color:
                                              Color(0xffacacac)
                                                .withOpacity(0.1))),
                                  child: InkWell(
                                    onTap: () {
                                      viewModel.sendMessage();
                                    },
                                    child: Icon(
                                      MdiIcons.sendOutline,
                                      color: Color(0xff919195),
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                Visibility(
                    visible: viewModel.isLoading,
                    child: Container(
                        color: Colors.grey.withOpacity(0.5),
                        width: double.infinity,
                        height: double.infinity,
                        child: ProgressIndicatorWidget()))
              ],
            ),
          );
        });
  }
}
