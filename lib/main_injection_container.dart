




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart'as http;
import 'package:instagram_clone/features/home_page/presentation/post_injection_container.dart';
import 'package:instagram_clone/features/user/presentation/user_injection_container.dart';

final sl = GetIt.instance;

Future<void> init()async{
  final http.Client httpClient = http.Client();
  final fireStore= FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  sl.registerLazySingleton<http.Client>(() => httpClient);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => googleSignIn);


  await userInjectionContainer();
  await postInjectionContainer();

}