import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/core/error_message.dart';
import 'package:instagram_clone/features/app/consts/app_consts.dart';
import 'package:instagram_clone/features/user/data/models/user_model.dart';
import 'package:instagram_clone/features/user/data/remote_data_sources/firebase_remote_data_source.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseStorage,
      required this.googleSignIn,
      required this.fireStore,
      required this.firebaseAuth});

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      print("Error resetting password: $error");
      throw error;
    }
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        username: user.username,
        email: user.email,
        profileUrl: user.profileUrl,
        token: user.token,
        accountType: user.accountType,
        isOnline: user.isOnline,
        fullName: user.fullName,
        totalNotifications: user.totalNotifications,
        likes: user.likes,
        currentUserProfession: user.currentUserProfession,
        currentUserBio: user.currentUserBio,
        totalLikes: user.totalLikes,
        totalPosts: user.totalPosts,
        followings: user.followings,
        followers: user.followers,
        totalFollowings: user.totalFollowings,
        totalFollowers: user.totalFollowers,
        dateOfBirth: user.dateOfBirth,
      ).toDocument();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
        return;
      } else {
        toast("User already exist");
        return;
      }
    }).catchError((error) {
      toast("some error occurred $error");
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection =
        fireStore.collection(FirebaseCollectionConst.users).where("uid", isEqualTo: uid).limit(1);

    return userCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = fireStore.collection(FirebaseCollectionConst.users);

    return userCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      } else {}
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("User not found");
      } else if (e.code == "wrong-password") {
        toast("Wrong password");
      }
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await account!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final information = (await firebaseAuth.signInWithCredential(credential)).user;
      final newUser = UserModel(
        email: information?.email,
        uid: information?.uid,
        username: information?.displayName,
        isOnline: false,
        token: "",
        dateOfBirth: "",
        totalNotifications: 0,
        currentUserBio: "",
        currentUserProfession: "",
        fullName: "",
        followers: [],
        followings: [],
        likes: 0,
        totalLikes: 0,
        totalPosts: 0,
        profileUrl: "",
        accountType: "member",
      );
      await getCreateCurrentUser(newUser);
    } catch (e) {
      print("some error occur while google sign in $e");
    }
  }

  @override
  Future<void> signOut() async => await firebaseAuth.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: user.email!, password: user.password!)
          .then((currentUser) async {
        if (currentUser.user?.uid != null) {
          getCreateCurrentUser(user);
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("email is already used");
      } else {
        toast("something went wrong");
      }
    } catch (_) {
      print("some error occur");
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = fireStore.collection(FirebaseCollectionConst.users);

    Map<String, dynamic> userInfo = Map();

    if (user.profileUrl != "" && user.profileUrl != null) userInfo['profileUrl'] = user.profileUrl;
    if (user.username != "" && user.username != null) userInfo['username'] = user.username;
    if (user.fullName != "" && user.fullName != null) userInfo['fullName'] = user.fullName;
    if (user.currentUserProfession != "" && user.currentUserProfession != null)
      userInfo['currentUserProfession'] = user.currentUserProfession;
    if (user.currentUserBio != "" && user.currentUserBio != null)
      userInfo['currentUserBio'] = user.currentUserBio;

    userCollection.doc(user.uid).update(userInfo);
  }

  @override
  Future<void> verifyEmail(String? emailPinCode) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    try {
      await uploadTask;
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  @override
  Future<void> followUnfollowUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");

    final myDocRef = await userCollection.doc(user.uid).get();
    final otherUserDocRef = await userCollection.doc(user.otherUid).get();

    if (myDocRef.exists && otherUserDocRef.exists) {
      List myFollowingList = myDocRef.get("followings");
      List otherUserFollowingList = otherUserDocRef.get("Followers");

      //My Following List
      if (myFollowingList.contains(user.otherUid)) {
        userCollection.doc(user.uid).update({
          "followings": FieldValue.arrayRemove([user.otherUid])
        }).then((value) {
          final userCollection = fireStore.collection("users").doc(user.uid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowing = value.get('totalFollowings');
              userCollection.update({"totalFollowings": totalFollowing - 1});
              return;
            }
          });
        });
      } else {
        userCollection.doc(user.uid).update({
          "followings": FieldValue.arrayUnion([user.otherUid])
        }).then((value) {
          final userCollection = fireStore.collection("users").doc(user.uid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowing = value.get('totalFollowings');
              userCollection.update({"totalFollowings": totalFollowing + 1});
              return;
            }
          });
        });
      }

      // Other User Following List
      if (otherUserFollowingList.contains(user.uid)) {
        userCollection.doc(user.otherUid).update({
          "followers": FieldValue.arrayRemove([user.uid])
        }).then((value) {
          final userCollection = fireStore.collection("users").doc(user.otherUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowers = value.get('totalFollowers');
              userCollection.update({"totalFollowers": totalFollowers - 1});
              return;
            }
          });
        });
      } else {
        userCollection.doc(user.otherUid).update({
          "followers": FieldValue.arrayUnion([user.uid])
        }).then((value) {
          final userCollection = fireStore.collection("users").doc(user.otherUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowers = value.get('totalFollowers');
              userCollection.update({"totalFollowers": totalFollowers + 1});
              return;
            }
          });
        });
      }
    }
  }

  @override
  Stream<List<UserEntity>> getOtherSingleUser(String otherUid) {
    final userCollection = fireStore.collection("users").where("uid",isEqualTo:otherUid ).limit(1);

    return userCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }
}
