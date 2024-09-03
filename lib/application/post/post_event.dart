import 'package:arrivo/domain/model/post_details.dart';
import 'package:arrivo/application/post/post_state.dart';
import 'package:equatable/equatable.dart';

abstract class PostScreenEvent extends Equatable {}

class InitEvent extends PostScreenEvent {
  InitEvent();
  @override
  List<Object?> get props => [];
}

class OnGetPostListAction extends PostScreenEvent {
  OnGetPostListAction();
  @override
  List<Object?> get props => [];
}

class OnGetPostByIdAction extends PostScreenEvent {
  final int id;
  OnGetPostByIdAction(this.id);
  @override
  List<Object?> get props => [id];
}

class OnSearchPostListByIdTitleBodyAction extends PostScreenEvent {
  final String searchText;
  final PostScreenGetPostListSuccess data;
  OnSearchPostListByIdTitleBodyAction({required this.data, required this.searchText});
  @override
  List<Object?> get props => [searchText];
}

class OnSortPostListAction extends PostScreenEvent {
  final String sortField;
  final bool isAsc;
  final PostScreenGetPostListSuccess data;
  OnSortPostListAction({required this.data, required this.sortField, required this.isAsc});
  @override
  List<Object?> get props => [sortField, isAsc];
}

class OnEditAddPostAction extends PostScreenEvent {
  final PostDetails newData;
  final bool isEdit;
  final PostScreenGetPostListSuccess data;
  OnEditAddPostAction({required this.newData, required this.isEdit, required this.data});
  @override
  List<Object?> get props => [newData, isEdit, data];
}

class OnDeletePostAction extends PostScreenEvent {
  final PostDetails updateData;
  final PostScreenGetPostListSuccess data;
  OnDeletePostAction({required this.updateData, required this.data});
  @override
  List<Object?> get props => [updateData, data];
}
