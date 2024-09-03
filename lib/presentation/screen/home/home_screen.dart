import 'package:arrivo/application/home/home_bloc.dart';
import 'package:arrivo/application/home/home_event.dart';
import 'package:arrivo/application/home/home_state.dart';
import 'package:arrivo/domain/configure/colors.dart';
import 'package:arrivo/domain/configure/theme.dart';
import 'package:arrivo/presentation/screen/home/home_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final menuTree = TreeNode.root()
    ..addAll(
      [
        TreeNode(key: "Post", data: Icons.description),
        TreeNode(key: "Subscriptions", data: Icons.currency_exchange),
        TreeNode(key: "Logout", data: Icons.logout),
      ],
    );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc()..add(FetchHomeEvent(menu: "Post")),
          ),
        ],
        child: Scaffold(
          backgroundColor: ColorConfig.white,
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      color: ColorConfig.blueSub3,
                      child: Column(
                        children: [
                          _buildTitleWidget(),
                          // Sidebar menu widget
                          Expanded(
                            child: TreeView.simple(
                              tree: menuTree,
                              indentation: const Indentation(width: 0),
                              expansionIndicatorBuilder: (context, node) {
                                return ChevronIndicator.rightDown(
                                  alignment: Alignment.centerLeft,
                                  tree: node,
                                  color: Colors.white,
                                  icon: Icons.arrow_right,
                                );
                              },
                              onItemTap: (item) {
                                if(item.key == "Logout"){
                                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                                }
                                BlocProvider.of<HomeBloc>(context).add(FetchHomeEvent(menu: item.key));
                              },
                              builder: (context, node) {
                                final isSelected = state.menu == node.key;
                                final isExpanded = node.isExpanded;
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Container(
                                    color: node.level >= 2 || isExpanded
                                        ? ColorConfig.blueSub3 // For coloring the background of child nodes
                                        : ColorConfig.blueSub3,
                                    height: 42, // Padding between one menu and another.
                                    width: 250,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: node.level >= 2
                                          ? const EdgeInsets.only(left: 27) // Padding for the children of the node
                                          : const EdgeInsets.only(left: 0),
                                      child: Container(
                                        width: 250,
                                        height: 45, // The size dimension of the active button
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? node.isLeaf
                                                  ? ColorConfig.blueDark2 // The color for the active node.
                                                  : null
                                              : null,
                                          
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 25,
                                          ),
                                          child: node.level >= 2
                                              ? Text(
                                                  node.key,
                                                  style: TextStyle(
                                                    color: isSelected ? ColorConfig.white : ColorConfig.black,
                                                    fontSize: 14,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Icon(
                                                      node.data as IconData,
                                                      size: 20,
                                                      color: isSelected ? ColorConfig.white : ColorConfig.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      node.key,
                                                      style: TextStyle(
                                                        color: isSelected ? ColorConfig.white : ColorConfig.black,
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: HomeBodyWidget(
                        menu: state.menu,
                      ),
                    ),
                  ],
                );
              } else if (state is HomeError) {
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
        ),
      ),
    );
  }

  Widget _buildTitleWidget() => Container(
        width: 250,
        child: Padding(
          padding: EdgeInsets.only(
            top: 15,
            left: 12,
            right: 12,
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Menu",
                style: ThemeService.boldTextStyle(fontSize: 20, color: ColorConfig.black)
              ),
            ],
          ),
        ),
      );
}
