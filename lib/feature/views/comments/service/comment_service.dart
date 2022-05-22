import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/base/models/base_response/empty_response.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/feature/models/comment/comment_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class CommentService {
  final NetworkManager? _networkManager = locator<NetworkManager>();

  Future getCommentQuestion(int questionId) async {
    return  await _networkManager!.request(
      method: ReqTypes.get,
      path: '${ApiConstants.questionCommentGetByActivityId}/${questionId}',
      model: CommentModel(),
    );

  }
  Future getCommentActivity(int activityId) async {
    return await _networkManager!.request(
        method: ReqTypes.get,
        path: '${ApiConstants.questionCommentGetByActivityId}/${activityId}',
        model: CommentModel(),
    );
  }
  Future postComment(dynamic data) async {
    return await _networkManager!.request(
        method: ReqTypes.post,
        path: ApiConstants.questionComment,
        model: CommentModel(),
        data: data
    );
  }

  setCommentLike({required int id})async{
    return  await _networkManager!.request(
      method: ReqTypes.post,
      path: ApiConstants.like,
      model: EmptyModel(),
      queryParameters:{
        //Tabletype 2 olursa yorumu beğenir
        'TableType':2,
        'id':id
      } ,
    );
  }
}
