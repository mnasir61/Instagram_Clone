




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart'as http;
import 'package:instagram_clone/features/bookmark/bookmark_injection_container.dart';
import 'package:instagram_clone/features/comment/comment_injection_container.dart';
import 'package:instagram_clone/features/post/post_injection_container.dart';
import 'package:instagram_clone/features/storage/storage_injection_container.dart';
import 'package:instagram_clone/features/user/presentation/user_injection_container.dart';

import 'features/reply/reply_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final http.Client httpClient = http.Client();
  final fireStore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton<http.Client>(() => httpClient);
  sl.registerLazySingleton<FirebaseFirestore>(() => fireStore);
  sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
  sl.registerLazySingleton<GoogleSignIn>(() => googleSignIn);
  sl.registerLazySingleton<FirebaseStorage>(() => firebaseStorage);

  await userInjectionContainer();
  await postInjectionContainer();
  await commentInjectionContainer();
  await replyInjectionContainer();
  await bookmarkInjectionContainer();
  await storageInjectionContainer();
}
