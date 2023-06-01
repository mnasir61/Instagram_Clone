import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';

class SaveYourLoginInfoPageWidget extends StatefulWidget {
  final VoidCallback? onTap;

  const SaveYourLoginInfoPageWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SaveYourLoginInfoPageWidget> createState() => _SaveYourLoginInfoPageWidgetState();
}

class _SaveYourLoginInfoPageWidgetState extends State<SaveYourLoginInfoPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Save your login info?",
                  style: Styles.headLine
                      .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.w500),
                ),
                verticalSize(10),
                RichText(
                  text: TextSpan(
                    text:  "We'll save the login info for ",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "User Name here",
                        style: Styles.titleLine2.copyWith(
                          color: Styles.colorBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ", so you won't need to enter it next time you log in.",
                      ),
                    ]
                  ),
                ),
                verticalSize(20),
                GestureDetector(
                  onTap: widget.onTap,
                  child: ContainerButton(
                    fillColor: colorBlue,
                    text: "Save",
                    textStyle: Styles.titleLine1,
                  ),
                ),
                verticalSize(10),
                ContainerButton(
                  text: "Not now",
                  textStyle: Styles.titleLine1
                      .copyWith(color: Styles.colorBlack.withOpacity(.6), fontWeight: FontWeight.w400),
                  isBorder: true,
                  borderColor: Styles.colorGray1.withOpacity(.5),
                  borderWidth: 1,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConsts.signInPage, (route) => false);
                  },
                  child: Text(
                    "Already have an account?",
                    style: Styles.titleLine2.copyWith(color: colorBlue, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
