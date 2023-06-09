part of 'get_other_single_user_cubit.dart';

abstract class GetOtherSingleUserState extends Equatable {
  const GetOtherSingleUserState();
}

class GetSingleOtherUserInitial extends GetOtherSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserLoaded extends GetOtherSingleUserState {
  final UserEntity otherUser;

  GetSingleOtherUserLoaded({required this.otherUser});

  @override
  List<Object> get props => [otherUser];
}

class GetSingleOtherUserLoading extends GetOtherSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserFailure extends GetOtherSingleUserState {
  @override
  List<Object> get props => [];
}