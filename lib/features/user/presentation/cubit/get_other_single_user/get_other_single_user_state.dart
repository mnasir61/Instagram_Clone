part of 'get_other_single_user_cubit.dart';

abstract class GetOtherSingleUserState extends Equatable {
  const GetOtherSingleUserState();
}

class GetOtherSingleUserInitial extends GetOtherSingleUserState {
  @override
  List<Object> get props => [];
}

class GetOtherSingleUserLoaded extends GetOtherSingleUserState {
  final UserEntity otherUser;

  GetOtherSingleUserLoaded({required this.otherUser});

  @override
  List<Object> get props => [otherUser];
}

class GetOtherSingleUserLoading extends GetOtherSingleUserState {
  @override
  List<Object> get props => [];
}

class GetOtherSingleUserFailure extends GetOtherSingleUserState {
  @override
  List<Object> get props => [];
}