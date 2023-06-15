import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';

class AgreeTermsAndConditionsPageWidget extends StatefulWidget {
  final VoidCallback? onTap;

  const AgreeTermsAndConditionsPageWidget({Key? key, this.onTap}) : super(key: key);

  @override
  State<AgreeTermsAndConditionsPageWidget> createState() => _AgreeTermsAndConditionsPageWidgetState();
}

class _AgreeTermsAndConditionsPageWidgetState extends State<AgreeTermsAndConditionsPageWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  "Agree to Instagram's terms and policies",
                  style: Styles.headLine
                      .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.bold),
                ),
                verticalSize(10),
                RichText(
                  text: TextSpan(
                    text:
                        "People who use our service may have uploaded your contact information to Instagram. ",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Learn more",
                        style: Styles.titleLine2.copyWith(
                          color: colorBlue,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSize(20),
                RichText(
                  text: TextSpan(
                    text: "By tapping ",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "I agree ",
                        style: Styles.titleLine2.copyWith(
                          color: Styles.colorBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "you agree to create an account and the Instagram's ",
                        style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                      ),
                      TextSpan(
                        text: "Terms, Privacy Policy ",
                        style: Styles.titleLine2.copyWith(
                          color: colorBlue,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "and ",
                        style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                      ),
                      TextSpan(
                        text: "Cookies.",
                        style: Styles.titleLine2.copyWith(
                          color: colorBlue,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSize(20),
                RichText(
                  text: TextSpan(
                    text: "The ",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Privacy Policy ",
                        style: Styles.titleLine2.copyWith(
                          color: colorBlue,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "describes the way we can use the information we collect when you create an account. For example, we use the information to provide, personalize and improve our products, including ads.",
                        style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                verticalSize(20),
                GestureDetector(
                  onTap: widget.onTap,
                  child: ContainerButton(
                    fillColor: colorBlue,
                    text: "I Agree",
                    textStyle: Styles.titleLine1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
