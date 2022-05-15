import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/base/view/base_view.dart';
import 'package:stacked/stacked.dart';

class QuestionCommentsViewModel extends BaseViewModel{
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
}