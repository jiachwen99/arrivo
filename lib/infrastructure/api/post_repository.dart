import 'package:arrivo/domain/model/new_post_details.dart';
import 'package:arrivo/infrastructure/api/api_client.dart';
import 'package:arrivo/domain/model/post_details.dart';

class PostRepository {
  PostRepository._internal();

  static final PostRepository _singleton = PostRepository._internal();

  factory PostRepository() {
    return _singleton;
  }

  Future<List<PostDetails>> getPostsAction() {
    return ApiClient.instance.getPosts();
  }

  Future<PostDetails> getPostByIdAction({required int id}) {
    return ApiClient.instance.getPostById(id: id);
  }

  Future<PostDetails> postNewPostAction({required NewPostDetails newData}) {
    return ApiClient.instance.postNewPost(newData: newData);
  }

  Future<PostDetails> putCurrentPostAction({required PostDetails updateData}) {
    return ApiClient.instance.putCurrentPost(updateData: updateData);
  }

  Future<bool> deleteCurrentPostAction({required PostDetails updateData}) {
    return ApiClient.instance.deleteCurrentPost(updateData: updateData);
  }
}
