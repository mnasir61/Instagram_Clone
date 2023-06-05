import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/features/app/main_page/presentation/pages/main_page.dart';
import 'package:instagram_clone/features/global/circular_progress_indicator_widget.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/credentials/credential_cubit.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/container_button.dart';
import 'package:instagram_clone/features/user/presentation/pages/widgets/text_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSigningIn = false;
  static const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  bool _containsSpecialCharacter(String value) {
    final specialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacters.hasMatch(value);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColorWhite,
        body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialLoaded) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (credentialState is CredentialFailure) {
              print("wrong email");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialLoading) {
              return CircularProgressIndicatorWidget();
            }
            if (credentialState is CredentialLoaded) {
              return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainPage(uid: authState.uid,);
                } else {
                  return _bodyWidget();
                }
              });
            }
            return _bodyWidget();
          },
        ));
  }

  _bodyWidget() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(top: 60, right: 15, left: 15, bottom: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text("English (US)"),
                      verticalSize(50),
                      _instagramLogo(),
                      verticalSize(50),
                      TextFieldWidget(
                        controller: _emailController,
                        hintText: "Username, email or mobile number",
                        labelText: "Username, email or mobile number",
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (RegExp(emailRegex).hasMatch(value!)) {
                            return null; // Return null if email is correctly formatted
                          } else if (value.isEmpty) {
                            return "field cannot be empty";
                          } else {
                            return "Email is not correctly formatted";
                          }
                        },
                      ),
                      verticalSize(10),
                      TextFieldWidget(
                        isPasswordField: true,
                        controller: _passwordController,
                        hintText: "Password",
                        labelText: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field cannot be empty";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      verticalSize(10),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                            return _signInUser();
                          } else {
                            return null;
                          }
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, PageConsts.mainPage, (route) => false);
                        },
                        child: ContainerButton(
                          text: "Log in",
                          fillColor: colorBlue,
                          textStyle: Styles.titleLine1,
                        ),
                      ),
                      verticalSize(20),
                      Text(
                        "Forget password?",
                        style: Styles.titleLine2
                            .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, PageConsts.signUpPage, (route) => false);
                  },
                  child: ContainerButton(
                    text: "Create new account",
                    isBorder: true,
                    borderWidth: 1,
                    borderColor: colorBlue,
                    textStyle:
                        Styles.titleLine1.copyWith(color: colorBlue, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _instagramLogo() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Color(0xFF405DE6),
            Color(0xFF5851DB),
            Color(0xFF833AB4),
            Color(0xFFC13584),
            Color(0xFFE1306C),
            Color(0xFFFF6D00),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ).createShader(bounds);
      },
      child: SvgPicture.asset(
        'assets/main/insta_logo_outline.svg',
        height: 60,
        color: Colors.white,
      ),
    );
  }

  void _signInUser() {
    setState(() {
      _isSigningIn = true;
    });
    BlocProvider.of<CredentialCubit>(context).signInUser(
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSigningIn  = false;
    });
  }
}
