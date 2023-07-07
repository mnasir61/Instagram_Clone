import 'package:equatable/equatable.dart';

class MusicEntity extends Equatable {
  final String? musicId;
  final String? musicTitle;
  final String? musicArtist;
  final String? genre;
  final Duration? musicDuration;
  final String? albumCover;
  final String? musicUrl;

  MusicEntity(
      {this.musicId,
      this.musicTitle,
      this.musicArtist,
      this.genre,
      this.musicDuration,
      this.albumCover,
      this.musicUrl});

  @override
  List<Object?> get props =>
      [musicId, musicTitle, musicArtist, genre, musicDuration, albumCover, musicUrl];
}
