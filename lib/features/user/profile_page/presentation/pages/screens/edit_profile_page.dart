import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/error_message.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/storage/domain/usecases/upload_profile_image_usecase.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _currentUserBioController = TextEditingController();
  TextEditingController _currentUserProfessionController = TextEditingController();
  bool _isUpdating = false;
  File? image;

  Future getImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentUser.fullName);
    _usernameController = TextEditingController(text: widget.currentUser.username);
    _currentUserBioController = TextEditingController(text: widget.currentUser.currentUserBio);
    _currentUserProfessionController =
        TextEditingController(text: widget.currentUser.currentUserProfession);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Styles.colorWhite,
        title: Text(
          "Edit profile",
          style: Styles.headLine.copyWith(color: Styles.colorBlack),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(FontAwesomeIcons.times, color: Styles.colorBlack)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: _updateUserProfileData,
                child: _isUpdating == true
                    ? Center(
                        child: Container(height: 30, width: 30, child: CircularProgressIndicator()))
                    : Icon(FontAwesomeIcons.check, color: colorBlue)),
          ),
        ],
      ),
      backgroundColor: Styles.colorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileWidget(image: image, imageUrl: widget.currentUser.profileUrl),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: getImage,
                    child: Text(
                      "Edit Picture",
                      style: Styles.titleLine1
                          .copyWith(fontSize: 16, color: colorBlue, fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 30),
                _formFieldWidget(
                  hintText: "Name",
                  labelText: "Name",
                  maxLines: 1,
                  controller: _nameController,
                ),
                SizedBox(height: 10),
                _formFieldWidget(
                  hintText: "Username",
                  labelText: "Username",
                  maxLines: 1,
                  controller: _usernameController,
                  validator: _validateUsername,
                ),
                SizedBox(height: 10),
                _formFieldWidget(
                  hintText: "Category",
                  labelText: "Category",
                  maxLines: 1,
                  controller: _currentUserProfessionController,
                ),
                SizedBox(height: 10),
                _formFieldWidget(
                  hintText: "Bio",
                  labelText: "Bio",
                  maxLines: null,
                  controller: _currentUserBioController,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _formFieldWidget({
    TextEditingController? controller,
    int? maxLines,
    String? hintText,
    String? labelText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: "$hintText",
        labelText: "$labelText",
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
      ),
      validator: validator,
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "Username can only contain letters, numbers, and underscores";
    } else if (value.length < 4 || value.length > 20) {
      return "Username must be between 4 and 20 characters";
    } else if (_isUsernameAlreadyUsed(value)) {
      return "Username is already used by another user";
    }
    return null;
  }

  bool _isUsernameAlreadyUsed(String username) {
    final usersState = context.read<GetUsersCubit>().state;
    if (usersState is GetUsersLoaded) {
      final users = usersState.users;
      for (final user in users) {
        if (user.username?.toLowerCase() == username.toLowerCase() &&
            user.uid != widget.currentUser.uid) {
          return true;
        }
      }
    }
    return false;
  }

  _updateUserProfileData() {
    if (!_isUpdating) {
      if (_usernameController.text.trim() != widget.currentUser.username &&
          _isUsernameAlreadyUsed(_usernameController.text.trim())) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Username already used"),
            content:
                Text("Username is already used by another user. Please choose a different username."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
        return;
      }

      setState(() => _isUpdating = true);
      if (image == null) {
        _updateUserProfile("");
      } else {
        di
            .sl<UploadProfileImageUseCase>()
            .call(file: image!)
            .then((profileUrl) => _updateUserProfile(profileUrl));
      }
    }
  }

  _updateUserProfile(String profileUrl) {
    final updatedUser = UserEntity(
      uid: widget.currentUser.uid,
      username: _usernameController.text.trim(),
      fullName: _nameController.text.trim(),
      currentUserProfession: _currentUserProfessionController.text.trim(),
      currentUserBio: _currentUserBioController.text.trim(),
      profileUrl: profileUrl,
    );

    BlocProvider.of<GetUsersCubit>(context).updateUser(user: updatedUser).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _usernameController.clear();
      _nameController.clear();
      _currentUserProfessionController.clear();
      _currentUserBioController.clear();
    });
    Navigator.pop(context);
  }
}
