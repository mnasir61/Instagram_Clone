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
  final num? totalFollowers;
  final num? totalFollowings;
  final List? followers;
  final List? followings;
  final String? currentUserBio;
  final String? currentUserProfession;
  final String? lastActivity;

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
        this.followings,
        this.followers,
      this.totalFollowers,
      this.totalFollowings,
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
      this.accountType,
        this.lastActivity, });

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
        totalFollowers,
        totalFollowers,
    followers,
    followings,
        currentUserBio,
        currentUserProfession,
    lastActivity
      ];
}
