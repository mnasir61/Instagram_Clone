import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/forgot_password_usecase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/sign_in_usercase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/sign_in_wih_google_use_case.dart';
import 'package:instagram_clone/features/user/domain/use_cases/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
   final SignInWithGoogleUseCase signInWithGoogleUseCase;
  CredentialCubit({required this.signInWithGoogleUseCase,required this.forgotPasswordUseCase,required this.signUpUseCase, required this.signInUseCase}) : super(CredentialInitial());

  Future<void> forgotPassword({required String email}) async {
    try {
      await forgotPasswordUseCase.call(email);
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signInUser({required String email, required String password}) async {
      emit(CredentialLoading());
    try {
      await signInUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialLoaded());
    } on SocketException catch(_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }


  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.call(user);
      emit(CredentialLoaded());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signInWithGoogle()async{
    emit(CredentialLoading());
    try{
      await signInWithGoogleUseCase.call();
      emit(CredentialLoaded());
    }on SocketException catch(_){
      emit(CredentialFailure());
    }catch(_){
      emit(CredentialFailure());
    }
  }

}