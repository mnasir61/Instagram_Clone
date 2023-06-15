import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/birthday_form_field.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';

class DateOfBirthPageWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController? dobController;

  const DateOfBirthPageWidget({Key? key, this.onTap, this.dobController}) : super(key: key);

  @override
  State<DateOfBirthPageWidget> createState() => _DateOfBirthPageWidgetState();
}

class _DateOfBirthPageWidgetState extends State<DateOfBirthPageWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    "What's your birthday?",
                    style: Styles.headLine
                        .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.bold),
                  ),
                  verticalSize(10),
                  Text(
                    "Use your own birthday, even if this account is for a business, a pet of something else. No one will see this on your profile.",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                  ),
                  verticalSize(20),
                  BirthdayFormField(
                    isDob: true,
                    controller: widget.dobController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date of birth is required';
                      } else {}

                      return null;
                    },
                  ),
                  verticalSize(20),
                  GestureDetector(
                    onTap: _submitDob,
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

  void _submitDob() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      widget.onTap?.call();
    }
  }
}
