import 'package:arrivo/domain/model/new_post_details.dart';
import 'package:arrivo/domain/model/post_details.dart';
import 'package:arrivo/infrastructure/api/post_repository.dart';
import 'package:arrivo/application/post/post_event.dart';
import 'package:arrivo/application/post/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreenBloc extends Bloc<PostScreenEvent, PostScreenState> {
  final PostRepository _postRepository = PostRepository();
  PostScreenBloc() : super(PostScreenStateInitial()) {
    on<OnGetPostListAction>((event, emit) async {
        try {
          List<PostDetails> response = await _postRepository.getPostsAction();
          emit(
            PostScreenGetPostListSuccess(response, response, "")
          );
        } catch (e) {
          emit(
            PostScreenError(e.toString()),
          );
        }
      },
    );
    on<OnGetPostByIdAction>((event, emit) async {
      try {
        PostDetails response = await _postRepository.getPostByIdAction(id: event.id);
        emit(
          PostScreenGetPostByIdSuccess(response),
        );
      } catch (e) {
        emit(
          PostScreenError(e.toString()),
        );
      }
    });


    on<OnSearchPostListByIdTitleBodyAction>((event, emit) async {
      try {
        
        List<PostDetails> filterDataList = event.data.allDataList.where((element) => element.id.toString().toLowerCase().contains(event.searchText) || element.title.toLowerCase().contains(event.searchText) || element.body.toLowerCase().contains(event.searchText)).toList();
        emit(
          PostScreenGetPostListSuccess(
            event.data.allDataList,
            filterDataList,
            event.searchText
          ),
        );
      } catch (e) {
        emit(
          PostScreenError(e.toString()),
        );
      }
    });

    on<OnSortPostListAction>((event, emit) async {
      try {
        List<PostDetails> filterDataList = event.data.filterDataList;
        switch (event.sortField) {
          case "ID":
            if(event.isAsc){
              filterDataList = filterDataList..sort((a, b) => a.id.compareTo(b.id));
            }
            else{
              filterDataList = filterDataList..sort((a, b) => b.id.compareTo(a.id));
            }
            break;
          case "Title":
            if(event.isAsc){
              filterDataList = filterDataList..sort((a, b) => a.title.compareTo(b.title));
            }
            else{
              filterDataList = filterDataList..sort((a, b) => b.title.compareTo(a.title));
            }
            break;
          case "Body":
            if(event.isAsc){
              filterDataList = filterDataList..sort((a, b) => a.body.compareTo(b.body));
            }
            else{
              filterDataList = filterDataList..sort((a, b) => b.body.compareTo(a.body));
            }
            break;
          case "UserID":
            if(event.isAsc){
              filterDataList = filterDataList..sort((a, b) => a.userId.compareTo(b.userId));
            }
            else{
              filterDataList = filterDataList..sort((a, b) => b.userId.compareTo(a.userId));
            }
            break;
          default:
            break;
        }
        
        emit(
          PostScreenGetPostListSuccess(
            event.data.allDataList,
            filterDataList,
            event.data.searchText
          ),
        );
        
        
      } catch (e) {
        emit(
          PostScreenError(e.toString()),
        );
      }
    });

    on<OnEditAddPostAction>((event, emit) async {
      try {
        PostDetails response = PostDetails();
        if(event.isEdit){
          response = await _postRepository.putCurrentPostAction(updateData: event.newData);
        }
        else{
          response = await _postRepository.postNewPostAction(newData: NewPostDetails(userId: event.newData.userId, title: event.newData.title, body: event.newData.body));
        }

        var existPost = event.data.allDataList.where((post) => post.id == response.id).firstOrNull;
        if(existPost != null){
          existPost.body = response.body;
          existPost.title = response.title;
        }
        else{
          event.data.allDataList.add(response);
        }
        emit(
          PostScreenGetPostListSuccess(
            event.data.allDataList,
            event.data.allDataList,
            ""
          ),
        );
      } catch (e) {
        emit(
          PostScreenError(e.toString()),
        );
      }
    });

    on<OnDeletePostAction>((event, emit) async {
      try {
        bool isSuccess = await _postRepository.deleteCurrentPostAction(updateData: event.updateData) ?? false;
        
        if(isSuccess){
          List<PostDetails> newAllDataList = List.from(event.data.allDataList);
          newAllDataList.removeWhere((post) => post.id == event.updateData.id);

          emit(
            PostScreenGetPostListSuccess(
              newAllDataList,
              newAllDataList,
              ""
            ),
          );
          return;
        }
        else{
          emit(PostScreenError("Delete failed"));
          return;
        }
        
      } catch (e) {
        emit(
          PostScreenError(e.toString()),
        );
      }
    });
  }
}
  
