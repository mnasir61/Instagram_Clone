import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/text_field_widget.dart';

class EmailPageWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController emailController;

  const EmailPageWidget({Key? key, this.onTap, required this.emailController}) : super(key: key);

  @override
  State<EmailPageWidget> createState() => _EmailPageWidgetState();
}

class _EmailPageWidgetState extends State<EmailPageWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15,bottom: 15),
        child: Column(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's your email?",
                    style: Styles.headLine
                        .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.w500),
                  ),
                  verticalSize(10),
                  Text(
                    "Enter the email where you can be connected. No one will see this on your profile.",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                  ),
                  verticalSize(20),
                  TextFieldWidget(
                    controller: widget.emailController,
                    labelText: "Email",
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (RegExp(emailRegex).hasMatch(value!)) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Field cannot be empty";
                      } else {
                        return "Email is not correctly formatted";
                      }
                    },
                  ),
                  verticalSize(20),
                  GestureDetector(
                    onTap: _submitEmail,
                    child: ContainerButton(
                      fillColor: colorBlue,
                      text: "Next",
                      textStyle: Styles.titleLine1,
                    ),
                  ),
                  verticalSize(10),
                  ContainerButton(
                    text: "Sign up with mobile number",
                    textStyle: Styles.titleLine1.copyWith(
                        color: Styles.colorBlack.withOpacity(.6), fontWeight: FontWeight.w400),
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
                      style:
                          Styles.titleLine2.copyWith(color: colorBlue, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _submitEmail() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      widget.onTap?.call();
    }
  }

}


