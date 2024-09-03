import 'package:arrivo/domain/configure/colors.dart';
import 'package:arrivo/domain/configure/dimens.dart';
import 'package:arrivo/domain/configure/theme.dart';
import 'package:arrivo/domain/model/post_details.dart';
import 'package:arrivo/application/post/post_bloc.dart';
import 'package:arrivo/application/post/post_event.dart';
import 'package:arrivo/application/post/post_state.dart';
import 'package:arrivo/presentation/widget/theme_button.dart';
import 'package:arrivo/presentation/widget/theme_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isAscending = true;
  int currentColumnIndex = 0;
  final TextEditingController _serchPostController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
  }

  

  Widget dataTable(PostScreenBloc currentBloc, PostScreenGetPostListSuccess data){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Theme(
            data: Theme.of(context).copyWith(iconTheme: Theme.of(context).iconTheme.copyWith(color: ColorConfig.white)),
            child: DataTable(
              sortAscending: isAscending,
              sortColumnIndex: currentColumnIndex,
              border: TableBorder.all(),
              headingTextStyle: ThemeService.boldTextStyle().copyWith(color: ColorConfig.white),
              headingRowColor: const WidgetStatePropertyAll<Color>(ColorConfig.black),
              dividerThickness: 1,
              dataRowMaxHeight: double.infinity,       // Code to be changed.
              dataRowMinHeight: 60,
              
              columnSpacing: 10,
              horizontalMargin: 10,
              columns: createColumns(currentBloc, data), 
              rows: createRows(currentBloc, data)
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> createColumns(PostScreenBloc currentBloc, PostScreenGetPostListSuccess data){
    return [
      DataColumn(
        label: Text("ID"),
        onSort: (columnIndex, ascending) {
          currentBloc.add(OnSortPostListAction(data: data, sortField: "ID", isAsc: ascending));
          setState(() {
            currentColumnIndex = columnIndex;
            isAscending = ascending;
          });
        },
      ),
      DataColumn(
        label: Text("Title"),
        onSort: (columnIndex, ascending) {
          currentBloc.add(OnSortPostListAction(data: data, sortField: "Title", isAsc: ascending));
          setState(() {
            currentColumnIndex = columnIndex;
            isAscending = ascending;
          });
        },
      ),
      DataColumn(
        label: Text("Body"),
        onSort: (columnIndex, ascending) {
          currentBloc.add(OnSortPostListAction(data: data, sortField: "Body", isAsc: ascending));
          setState(() {
            currentColumnIndex = columnIndex;
            isAscending = ascending;
          });
        },
      ),
      DataColumn(
        label: Text("User ID"),
        onSort: (columnIndex, ascending) {
          currentBloc.add(OnSortPostListAction(data: data, sortField: "UserID", isAsc: ascending));
          setState(() {
            currentColumnIndex = columnIndex;
            isAscending = ascending;
          });
        },
      ),
      DataColumn(
        label: Text("Action"),
      )
    ];
  }

  List<DataRow> createRows(PostScreenBloc currentBloc, PostScreenGetPostListSuccess currentList){
    return currentList.filterDataList.map((data) => DataRow(cells: [
      DataCell(Text(data.id.toString())),
      DataCell(Text(data.title.toString())),
      DataCell(Text(data.body.toString())),
      DataCell(Text(data.userId.toString())),
      DataCell(Row(
        children: [
          IconButton(onPressed: (){
            _addEditPostAction(currentBloc, post: data, isEdit: true, currentList: currentList);
          }, icon: Icon(Icons.edit, color: ColorConfig.greyDark,)),
          IconButton(onPressed: () async {
            await _deletePostAction(currentBloc, post: data, currentList: currentList);

          }, icon: Icon(Icons.delete, color: ColorConfig.greyDark,))
        ],
      ))
    ])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostScreenBloc>(
      create: ((_) {
        return PostScreenBloc()..add(OnGetPostListAction());
      }),
      child: BlocBuilder<PostScreenBloc, PostScreenState>(
        builder: (context, state) {
          if (state is PostScreenGetPostListSuccess) {
            print(state.allDataList.length);
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(DimenConfig.horizontal_margin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Post List',
                          style: ThemeService.mediumTextStyle(fontSize: 24),
                        ),
                      ),
                      ThemeButton(
                        text: 'Add Post',
                        onPressed: () {
                          _addEditPostAction(BlocProvider.of<PostScreenBloc>(context), post: PostDetails(), isEdit: false, currentList: state);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    controller: _serchPostController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    style: ThemeService.regularTextStyle(),
                    decoration: ThemeService.grabTextFieldDecoration("Search by ID, Title or Body", prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), showPrefix: true),
                    onChanged: (String value){
                      BlocProvider.of<PostScreenBloc>(context).add(OnSearchPostListByIdTitleBodyAction(data: state, searchText: value));
                      setState(() {});
                    }
                  ),
                ),
                Expanded(child: dataTable(BlocProvider.of<PostScreenBloc>(context), state))
              ],
            );
          } else if (state is PostScreenError) {
            return const Center(
              child: Text(
                "An error has occurred. Please try again later.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  _deletePostAction(PostScreenBloc currentBloc, {required PostDetails post, required PostScreenGetPostListSuccess currentList}) async {
    //PostScreenBloc().add(OnSearchPostListByIdTitleBodyAction(data: currentList, searchText: post.title));
    currentBloc.add(OnDeletePostAction(updateData: post, data: currentList));
    setState(() {});
  }

  _addEditPostAction(PostScreenBloc currentBloc, {required PostDetails post, bool isEdit = false, required PostScreenGetPostListSuccess currentList}) {
    TextEditingController _titleController = TextEditingController(text: post.title);
    TextEditingController _bodyController = TextEditingController(text: post.body);

    if (isEdit) {
      _titleController.text = post.title ?? '';
      _bodyController.text = post.body ?? '';
    }

    ThemeDialog.show(
        context: context,
        contentWidget: Container(
          width: DimenConfig.getScreenWidth(percent: 40),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(bottom: 24),
                      child: Text(
                        isEdit ? 'Edit Post Information' : 'Add Post Information',
                        style: ThemeService.mediumTextStyle(fontSize: 24),
                      ),
                    ),
                    Container(alignment: Alignment.centerLeft, padding: EdgeInsets.only(bottom: 8), child: Text('Title')),
                    TextFormField(
                      controller: _titleController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      style: ThemeService.regularTextStyle(),
                      decoration: ThemeService.grabTextFieldDecoration("Title", showFilled: false, showLabel: false, showPrefix: false),
                      onChanged: (String value){
                        setState(() {});
                      }
                    ),
                    SizedBox(
                      height: DimenConfig.horizontal_margin,
                    ),
                    Container(alignment: Alignment.centerLeft, padding: EdgeInsets.only(bottom: 8), child: Text('Body')),
                    TextFormField(
                      controller: _bodyController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      style: ThemeService.regularTextStyle(),
                      minLines: 5,
                      maxLines: 10,
                      maxLength: 500,
                      decoration: ThemeService.grabTextFieldDecoration("Body", showFilled: false, showLabel: false, showPrefix: false),
                      onChanged: (String value){
                        setState(() {});
                      }
                    )
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ThemeButton(
                      text: 'Save',
                      onPressed: () {
                        post.title = _titleController.text;
                        post.body = _bodyController.text;
                        currentBloc.add(OnEditAddPostAction(data: currentList, newData: post, isEdit: isEdit));
                        setState(() {});
                        Navigator.of(context).pop();
                        
                      },
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: ThemeButton(
                      color: Colors.white,
                      textStyle: ThemeService.mediumTextStyle(color: Colors.black),
                      borderColor: Colors.grey,
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

