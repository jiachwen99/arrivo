import 'package:arrivo/domain/model/new_post_details.dart';
import 'package:arrivo/domain/model/post_details.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<PostDetails>> getPosts();

  @GET('/posts/{id}')
  Future<PostDetails> getPostById({@Path('id') required int id});

  @POST('/posts')
  Future<PostDetails> postNewPost({required NewPostDetails newData});

  @POST('/posts/{id}')
  Future<PostDetails> putCurrentPost({required PostDetails updateData});

  @POST('/posts/{id}')
  Future<bool> deleteCurrentPost({required PostDetails updateData});
}
