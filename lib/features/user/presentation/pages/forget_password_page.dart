import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

import 'widgets/container_button.dart';
import 'widgets/text_field_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  static const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(.1),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Styles.colorBlack,
            size: 18,
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find your account",
              style: Styles.headLine
                  .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.bold),
            ),
            verticalSize(10),
            Text(
              "Enter your username, email, or mobile number.",
              style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontSize: 16),
            ),
            verticalSize(4),
            Text(
              "Can't reset your Password?",
              style: Styles.titleLine2.copyWith(
                color: colorBlue,
                fontSize: 16,
              ),
            ),
            verticalSize(20),
            TextFieldWidget(
              controller: _emailController,
              hintText: "Username, email or mobile number",
              labelText: "Username, email or mobile number",
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (RegExp(emailRegex).hasMatch(value!)) {
                  return null;
                } else if (value.isEmpty) {
                  return "field cannot be empty";
                } else {
                  return "Email is not correctly formatted";
                }
              },
            ),
            verticalSize(20),
            ContainerButton(
              text: "Find account",
              fillColor: colorBlue,
              textStyle: Styles.titleLine1,
            ),
          ],
        ),
      ),
    );
  }
}
