

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/credentials/credential_cubit.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/text_field_widget.dart';

class CreateUsernamePageWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController? usernameController;
  const CreateUsernamePageWidget({Key? key, this.onTap, this.usernameController}) : super(key: key);

  @override
  State<CreateUsernamePageWidget> createState() => _CreateUsernamePageWidgetState();
}

class _CreateUsernamePageWidgetState extends State<CreateUsernamePageWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                    "Create a username",
                    style: Styles.headLine
                        .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.bold),
                  ),
                  verticalSize(10),
                  Text(
                    "Add a username or use our suggestion. You can change this at any time",
                    style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
                  ),
                  verticalSize(20),
                  TextFieldWidget(
                    controller: widget.usernameController,
                    labelText: "Username",
                    hintText: "Username",
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else if (value.length < 6) {
                        return "Username must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSize(20),
                  GestureDetector(
                    onTap: _submitUsername,
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

  void _submitUsername() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      widget.onTap?.call();
    }
  }

}
