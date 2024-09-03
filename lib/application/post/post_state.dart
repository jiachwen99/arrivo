import 'package:arrivo/domain/model/post_details.dart';
import 'package:equatable/equatable.dart';

abstract class PostScreenState extends Equatable {
  const PostScreenState();
  @override
  List<Object> get props => [];
  get temp => null;
}

class PostScreenStateInitial extends PostScreenState {}

class PostScreenStateLoading extends PostScreenState {}

class PostScreenGetPostByIdSuccess extends PostScreenState {
  final PostDetails response;
  const PostScreenGetPostByIdSuccess(this.response);
  @override
  List<Object> get props => [response];
}

class PostScreenGetPostListSuccess extends PostScreenState {
  final List<PostDetails> allDataList;
  final List<PostDetails> filterDataList;
  final String searchText;
  const PostScreenGetPostListSuccess(this.allDataList, this.filterDataList, this.searchText);
  @override
  List<Object> get props => [allDataList, filterDataList, searchText];
}

class PostScreenModifySuccess extends PostScreenState {
  final List<PostDetails> allDataList;
  final List<PostDetails> filterDataList;
  final String searchText;
  const PostScreenModifySuccess(this.allDataList, this.filterDataList, this.searchText);
  @override
  List<Object> get props => [allDataList, filterDataList, searchText];
}

class PostScreenError extends PostScreenState {
  final String errMessage;
  const PostScreenError(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}
