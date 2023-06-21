import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';

class EngagedUserModel extends EngagedUserEntity {
  final String? uid;
  final String? otherUid;
  final String? channelId;

  EngagedUserModel({
    this.uid,
    this.otherUid,
    this.channelId,
  }) : super(
          uid: uid,
          otherUid: otherUid,
          channelId: channelId,
        );

  factory EngagedUserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return EngagedUserModel(
      uid: snap["uid"],
      otherUid: snap["otherUid"],
      channelId: snap["channelId"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "uid": uid,
      "otherUid": otherUid,
      "channelId": channelId,
    };
  }
}
