import 'package:equatable/equatable.dart';

class EngagedUserEntity extends Equatable {
  final String? uid;
  final String? otherUid;
  final String? channelId;

  EngagedUserEntity({this.uid, this.otherUid, this.channelId});

  @override
  List<Object?> get props => [uid, otherUid, channelId];
}
