import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/base/view/base_view.dart';
import 'package:mobuni_v2/feature/models/comment/comment_model.dart';
import 'package:stacked/stacked.dart';

class QuestionCommentsViewModel extends BaseViewModel{
  var formKey = GlobalKey<FormState>();
   TextEditingController commentController = TextEditingController();
   FocusNode focusNode = FocusNode();
   
   List<CommentModel> comments = [
     CommentModel(
       content: 'Yorum 1',
       createdTime: DateTime.now(),
       likeCount: 10
     ),
     CommentModel(
         content: 'Yorum 2',
         createdTime: DateTime.now(),
         likeCount: 100
     ),
     CommentModel(
         content: 'Yorum 3',
         createdTime: DateTime.now(),
         likeCount: 1000
     ),
     CommentModel(
         content: 'Yorum 3',
         createdTime: DateTime.now(),
         likeCount: 1000
     ),
     CommentModel(
         content: 'Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3Yorum 3',
         createdTime: DateTime.now(),
         likeCount: 1000
     ),
     CommentModel(
         content: 'Yorum 3',
         createdTime: DateTime.now(),
         likeCount: 1000
     ),
   ];

   init(){
     focusNode.requestFocus();
   }
}