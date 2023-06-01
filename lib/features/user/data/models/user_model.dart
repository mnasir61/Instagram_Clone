import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? username;
  final String? fullName;
  final String? email;
  final String? profileUrl;

  final String? token;
  final num? totalNotifications;
  final bool? isOnline;
  final String? dateOfBirth;
  final String? accountType;

  final num? likes;
  final num? totalLikes;
  final num? totalPosts;
  final num? followers;
  final num? followings;
  final String? currentUserBio;
  final String? currentUserProfession;

  UserModel(
      {this.uid,
      this.likes,
        this.currentUserProfession,
        this.currentUserBio,
      this.followers,
      this.totalLikes,
      this.totalPosts,
      this.followings,
      this.username,
      this.email,
      this.profileUrl,
      this.dateOfBirth,
      this.token,
      this.isOnline,
      this.totalNotifications,
      this.fullName,
      this.accountType})
      : super(
            email: email,
            username: username,
            uid: uid,
            profileUrl: profileUrl,
            dateOfBirth: dateOfBirth,
            isOnline: isOnline,
            token: token,
            totalNotifications: totalNotifications,
            fullName: fullName,
            accountType: accountType,
            currentUserBio: currentUserBio,
            currentUserProfession: currentUserProfession ,
            likes: likes,
            totalLikes: totalLikes,
            totalPosts: totalPosts,
            followers: followers,
            followings: followings);

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      profileUrl: snapshot['profileUrl'],
      dateOfBirth: snapshot['dateOfBirth'],
      isOnline: snapshot['isOnline'],
      token: snapshot['token'],
      totalNotifications: snapshot['totalNotifications'],
      accountType: snapshot['accountType'],
      fullName: snapshot['fullName'],
      likes: snapshot['likes'],
      totalLikes: snapshot['totalLikes'],
      totalPosts: snapshot['totalPosts'],
      followers: snapshot['followers'],
      followings: snapshot['followings'],
      currentUserProfession: snapshot['currentUserProfession'],
      currentUserBio: snapshot['currentUserBio'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "username": username,
      "email": email,
      "uid": uid,
      "profileUrl": profileUrl,
      "dateOfBirth": dateOfBirth,
      "isOnline": isOnline,
      "token": token,
      "totalNotifications": totalNotifications,
      "accountType": accountType,
      "fullName": fullName,
      "likes": likes,
      "totalLikes": totalLikes,
      "totalPosts": totalPosts,
      "followers": followers,
      "followings": followings,
      "currentUserProfession": currentUserProfession,
      "currentUserBio": currentUserBio,
    };
  }
}
