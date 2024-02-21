//video_state.dart
part of 'video_bloc.dart';

sealed class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

final class VideoInitialState extends VideoState {}

final class VideoLoadedState extends VideoState {
  final VideoModel videoModel;

  const VideoLoadedState({required this.videoModel});

  @override
  List<Object> get props => [videoModel];
}

final class VideoErrorState extends VideoState {
  final String errorMessage;

  const VideoErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
