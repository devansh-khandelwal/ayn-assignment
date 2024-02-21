part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class VideoLoadedEvent extends Equatable {
  final VideoModel videoModel;

  const VideoLoadedEvent({required this.videoModel});

  @override
  List<Object?> get props => [videoModel];
}
