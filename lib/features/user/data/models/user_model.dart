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
  final num? totalFollowers;
  final num? totalFollowings;
  final List? followers;
  final List? followings;
  final String? currentUserBio;
  final String? currentUserProfession;
  final String? lastActivity;
  final num? totalShares;

  UserModel(
      {this.totalShares,
        this.uid,
      this.likes,
      this.currentUserProfession,
      this.currentUserBio,
      this.totalFollowers,
      this.followings,
      this.followers,
      this.totalLikes,
      this.totalPosts,
      this.totalFollowings,
      this.username,
      this.email,
      this.profileUrl,
      this.dateOfBirth,
      this.token,
      this.isOnline,
      this.totalNotifications,
      this.fullName,
      this.accountType,
      this.lastActivity})
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
            currentUserProfession: currentUserProfession,
            likes: likes,
            totalLikes: totalLikes,
            totalPosts: totalPosts,
            followers: followers,
            followings: followings,
            totalFollowers: totalFollowers,
            totalFollowings: totalFollowings,
  lastActivity:lastActivity,
  totalShares: totalShares);

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
      totalFollowers: snapshot['totalFollowers'],
      totalFollowings: snapshot['totalFollowings'],
      currentUserProfession: snapshot['currentUserProfession'],
      currentUserBio: snapshot['currentUserBio'],
      lastActivity: snapshot['lastActivity'],
      totalShares: snapshot['totalShares'],
      followers: List.from(snap.get("followers")),
      followings: List.from(snap.get("followings")),
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
      "totalFollowers": totalFollowers,
      "totalFollowings": totalFollowings,
      "currentUserProfession": currentUserProfession,
      "currentUserBio": currentUserBio,
      "followers": followers,
      "followings": followings,
      "lastActivity": lastActivity,
      "totalShares": totalShares,
    };
  }
}


