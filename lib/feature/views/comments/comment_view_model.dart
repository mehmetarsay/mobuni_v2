import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/enum/activity_or_question_enum.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
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
    late ActivityModel? activity;
    late BuildContext context;
    late GeneralType generalType;

    bool _commentSend = true;
  bool get commentSend => _commentSend;

  set commentSend(bool value) {
    _commentSend = value;
    notifyListeners();
  }

  init(BuildContext context,{QuestionModel? question,ActivityModel? activity}){
      setInitialised(false);
      this.context = context;
      if(question!=null){
        generalType = GeneralType.QuestionType;
        this.question = question;
      }
      else if(activity!=null){
        generalType = GeneralType.ActivityType;
        this.activity = activity;
      }
      setInitialised(true);
      notifyListeners();

  }

  Future<List<CommentModel>> getComment() async{
      if(generalType==GeneralType.QuestionType){
        return await _commentService.getCommentQuestion(question!.id!);
      }
      else {
        return await _commentService.getCommentActivity(activity!.id!);
      }

  }
  sendComment()async{
    if(commentSend){
      if (formKey.currentState!.validate()) {
       CommentModel commentModel =  getCommentModel();
        commentSend=false;
        focusNode.unfocus();
        await _commentService.postComment(commentModel).then((value){
          commentController.clear();
          commentSend =true;
          Fluttertoast.showToast(msg: 'Gönderildi');
          countCommentSize();

        });
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: 'Boş yorum gönderilemez');
      }
    }


  }

  getCommentModel(){
    CommentModel commentModel;
    if(generalType==GeneralType.QuestionType)
     commentModel = CommentModel(
      content: commentController.text,
      questionId: question!.id,
    );
    else
      commentModel = CommentModel(
        content: commentController.text,
        activityId: activity!.id,
      );
    commentModel.isLiked =null;

    return commentModel;
  }

  countCommentSize(){
    if(generalType==GeneralType.QuestionType)
      question!.commentCount = question!.commentCount + 1;
    else
      activity!.commentCount = activity!.commentCount! + 1;
  }
}