
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/credentials/credential_cubit.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/text_field_widget.dart';

class CreateFullNamePageWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController? fullNameController;

  const CreateFullNamePageWidget({Key? key, this.onTap, this.fullNameController}) : super(key: key);

  @override
  State<CreateFullNamePageWidget> createState() => _CreateFullNamePageWidgetState();
}

class _CreateFullNamePageWidgetState extends State<CreateFullNamePageWidget> {

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
                    "What's your name?",
                    style: Styles.headLine
                        .copyWith(fontSize: 23, color: Styles.colorBlack, fontWeight: FontWeight.bold),
                  ),
                  verticalSize(20),
                  TextFieldWidget(
                    controller: widget.fullNameController,
                    labelText: "Full name",
                    hintText: "Full name",
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else if (value.length < 6) {
                        return "Full name must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSize(20),
                  GestureDetector(
                    onTap: _submitFullName,
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

  void _submitFullName() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      widget.onTap?.call();
    }
  }

}
