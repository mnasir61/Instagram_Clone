import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? email;
  final String? profileUrl;
  final String? token;

  final bool? isOnline;
  final String? dateOfBirth;
  final String? accountType;
  final String? fullName;

  final num? totalNotifications;
  final num? likes;
  final num? totalLikes;
  final num? totalPosts;
  final num? followers;
  final num? followings;
  final String? currentUserBio;
  final String? currentUserProfession;

  final String? password;
  final String? confirmPassword;
  final String? otherUid;

  UserEntity(
      {this.confirmPassword,
      this.likes,
      this.currentUserBio,
      this.currentUserProfession,
      this.totalLikes,
      this.totalPosts,
      this.followers,
      this.followings,
      this.uid,
      this.username,
      this.password,
      this.email,
      this.profileUrl,
      this.dateOfBirth,
      this.isOnline,
      this.otherUid,
      this.token,
      this.totalNotifications,
      this.fullName,
      this.accountType});

  @override
  List<Object?> get props => [
        username,
        password,
        email,
        uid,
        confirmPassword,
        profileUrl,
        dateOfBirth,
        isOnline,
        otherUid,
        token,
        totalNotifications,
        accountType,
        fullName,
        likes,
        totalLikes,
        totalPosts,
        followers,
        followers,
        currentUserBio,
        currentUserProfession
      ];
}
