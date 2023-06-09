import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/app/main_page/presentation/pages/main_page.dart';
import 'package:instagram_clone/features/global/circular_progress_indicator_widget.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/credentials/credential_cubit.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page_widgets/agree_trems_and_conditions_page_widget.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page_widgets/create_full_name_page_widget.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page_widgets/create_password_page_widget.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page_widgets/create_username_page_widget.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page_widgets/date_of_birth_page_widget.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page_widgets/email_page_widget.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page_widgets/save_your_login_info_page_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  bool _isSigningUp = false;
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.bgColorWhite,
          elevation: 0,
          leading: GestureDetector(
            onTap: onBackPressed,
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Styles.colorBlack,
              size: 18,
            ),
          ),
        ),
        backgroundColor: Styles.bgColorWhite,
        body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialLoaded) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (credentialState is CredentialFailure) {
              print("Something went wrong");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialLoading) {
              return CircularProgressIndicatorWidget();
            }
            if (credentialState is CredentialLoaded) {
              return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainPage(
                    uid: authState.uid,
                  );
                } else {
                  return _switchPage(_currentPageIndex);
                }
              });
            }
            return _switchPage(_currentPageIndex);
          },
        ));
  }

  _switchPage(int index) {
    switch (index) {
      case 0:
        {
          return EmailPageWidget(
            emailController: _emailController,
            onTap: () {
              setState(() {
                _currentPageIndex = 1;
              });
            },
          );
        }
      case 1:
        {
          return CreateFullNamePageWidget(
            fullNameController: _fullNameController,
            onTap: () {
              setState(() {
                _currentPageIndex = 2;
              });
            },
          );
        }
      case 2:
        {
          return CreatePasswordPageWidget(
            passwordController: _passwordController,
            onTap: () {
              setState(() {
                _currentPageIndex = 3;
              });
            },
          );
        }
      case 3:
        {
          return SaveYourLoginInfoPageWidget(
            onTap: () {
              setState(() {
                _currentPageIndex = 4;
              });
            },
          );
        }
      case 4:
        {
          return DateOfBirthPageWidget(
            dobController: _dobController,
            onTap: () {
              setState(() {
                _currentPageIndex = 5;
              });
            },
          );
        }
      case 5:
        {
          return CreateUsernamePageWidget(
            usernameController: _usernameController,
            onTap: () {
              setState(() {
                _currentPageIndex = 6;
              });
            },
          );
        }
      case 6:
        {
          return AgreeTermsAndConditionsPageWidget(
            onTap: _signUpUser,
          );
        }
    }
  }

  Future<bool> onBackPressed() async {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
      });
      return false;
    } else if (_currentPageIndex == 0) {
      Navigator.pushNamedAndRemoveUntil(context, PageConsts.signInPage, (route) => false);
    }
    return true;
  }

  void _signUpUser() async {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
            user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          fullName: _fullNameController.text,
          profileUrl: "",
          dateOfBirth: _dobController.text,
          isOnline: false,
          token: "",
          totalFollowings: 0,
          followings: [],
          followers: [],
          totalFollowers: 0,
          totalNotifications: 0,
          accountType: "member",
          totalPosts: 0,
          totalLikes: 0,
          likes: 0,
          currentUserBio: "",
          currentUserProfession: "",
        ))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _fullNameController.clear();
      _dobController.clear();
      _isSigningUp = false;
    });
  }
}
