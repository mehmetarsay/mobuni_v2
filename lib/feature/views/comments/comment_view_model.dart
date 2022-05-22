import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/feature/models/comment/comment_model.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/comments/service/comment_service.dart';
import 'package:stacked/stacked.dart';

class CommentViewModel extends BaseViewModel {

  var formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();
  FocusNode focusNode = FocusNode();


  CommentService _commentService = locator<CommentService>();

  ///TODO buraya ActivityModel gelicek
    late QuestionModel? question;
    late BuildContext context;

    bool _commentSend = true;
  bool get commentSend => _commentSend;

  set commentSend(bool value) {
    _commentSend = value;
    notifyListeners();
  }

  init(BuildContext context,{QuestionModel? question}){
      setInitialised(false);
      this.context = context;
      this.question = question;
      setInitialised(true);
      notifyListeners();

  }

  Future<List<CommentModel>> getComment() async{
      if(question!=null){
        return await _commentService.getCommentQuestion(question!.id!);
      }
      else{
        ///TODO burası daha sonra activity için düzeltilicek
        return await _commentService.getCommentQuestion(question!.id!);
      }

  }
  sendComment()async{
    if(commentSend){
      if (formKey.currentState!.validate()) {
        CommentModel commentModel = CommentModel(
          content: commentController.text,
          // activityId: activityId
          questionId: question!.id,
        );
        commentSend=false;
        focusNode.unfocus();
        await _commentService.postComment(commentModel).then((value){
          commentController.clear();
          commentSend =true;
          Fluttertoast.showToast(msg: 'Gönderildi');
          question!.commentCount = question!.commentCount + 1;
        });
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: 'Boş yorum gönderilemez');
      }
    }


  }
}