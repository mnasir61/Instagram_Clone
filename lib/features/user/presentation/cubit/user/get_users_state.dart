part of 'get_users_cubit.dart';

abstract class GetUsersState extends Equatable {
  const GetUsersState();
}

class GetUsersInitial extends GetUsersState {
  @override
  List<Object> get props => [];
}

class GetUsersLoading extends GetUsersState {
  @override
  List<Object> get props => [];
}


class GetUsersLoaded extends GetUsersState {
  final List<UserEntity> users;

  GetUsersLoaded({required this.users});
  @override
  List<Object> get props => [users];
}


class GetUsersFailure extends GetUsersState {
  @override
  List<Object> get props => [];
}

