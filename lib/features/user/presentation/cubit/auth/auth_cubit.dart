import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/is_sign_in_usecase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/sign_out_usecase.dart';
part '../auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  AuthCubit({
    required this.getCurrentUidUseCase,
    required this.isSignInUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());


  Future<void> appStarted()async{
    try{
      bool isSignIn=await isSignInUseCase.call();

      if (isSignIn==true){
        final uid=await getCurrentUidUseCase.call();

        emit(Authenticated(uid:uid));
      }else
        emit(UnAuthenticated());

    }catch(_){
      emit(UnAuthenticated());
    }
  }
  Future<void> loggedIn()async{
    try{
      final uid=await getCurrentUidUseCase.call();

      emit(Authenticated(uid: uid));
    }catch(_){

      emit(UnAuthenticated());
    }
  }
  Future<void> loggedOut()async{
    try{
      await signOutUseCase.call();
      emit(UnAuthenticated());
    }catch(_){
      emit(UnAuthenticated());
    }
  }




}