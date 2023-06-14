import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/presentation/cubit/auth/auth_cubit.dart';

class ProfileMenuModelSheetDataWidget extends StatefulWidget {
  final VoidCallback onTapToEditPost;

  const ProfileMenuModelSheetDataWidget({Key? key, required this.onTapToEditPost}) : super(key: key);

  @override
  State<ProfileMenuModelSheetDataWidget> createState() => _ProfileMenuModelSheetDataWidgetState();
}

class _ProfileMenuModelSheetDataWidgetState extends State<ProfileMenuModelSheetDataWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.gear),
                          horizontalSize(15),
                          Text(
                            "Setting and privacy",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(Icons.schedule),
                          horizontalSize(15),
                          Text(
                            "Schedule content",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(Icons.insights_rounded),
                          horizontalSize(15),
                          Text(
                            "Insights",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      GestureDetector(
                        onTap: widget.onTapToEditPost,
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.arrow_clockwise_circle),
                            horizontalSize(15),
                            Text(
                              "Your activity",
                              style: Styles.titleLine2.copyWith(
                                  color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(CupertinoIcons.star),
                          horizontalSize(15),
                          Text(
                            "Favorites",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                          ),
                          horizontalSize(15),
                          Text(
                            "Orders and payments",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                          ),
                          horizontalSize(15),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context).loggedOut();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, PageConsts.signInPage, (route) => false);
                            },
                            child: Text(
                              "Log Out",
                              style: Styles.titleLine2.copyWith(
                                  color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      verticalSize(25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
