import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/text_field_widget.dart';

class CreatePasswordPageWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController? passwordController;

  const CreatePasswordPageWidget({Key? key, required this.onTap, this.passwordController})
      : super(key: key);

  @override
  State<CreatePasswordPageWidget> createState() => _CreatePasswordPageWidgetState();
}

class _CreatePasswordPageWidgetState extends State<CreatePasswordPageWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool containsSpecialCharacter(String value) {
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharRegex.hasMatch(value);
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create a password",
                    style: Styles.headLine
                        .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.w500),
                  ),
                  verticalSize(10),
                  Text(
                    "Create a password with at least 6 letters or numbers. It should be something other can't guess.",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 15),
                  ),
                  verticalSize(20),
                  TextFieldWidget(
                    isPasswordField: true,
                    controller: widget.passwordController,
                    labelText: "Password",
                    hintText: "Password",
                    textInputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      } else if (!containsSpecialCharacter(value)) {
                        return "Password must contain at least one special character";
                      } else {
                        return null;
                      }
                    },
                  ),

                  verticalSize(20),
                  GestureDetector(
                    onTap: _submitPassword,
                    child: ContainerButton(
                      fillColor: colorBlue,
                      text: "Next",
                      textStyle: Styles.titleLine1,
                    ),
                  ),
                  verticalSize(10),
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
      ),
    );
  }

  void _submitPassword() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      widget.onTap?.call();
    }
  }
}
