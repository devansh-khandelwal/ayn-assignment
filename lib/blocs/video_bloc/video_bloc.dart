// video_bloc.dart
import 'dart:convert';
import 'package:ayna_assignment_2/models/video_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoLoadedEvent, VideoState> {
  VideoBloc() : super(VideoInitialState()) {
    on<VideoLoadedEvent>((event, emit) async {
      try {
        emit(VideoInitialState());
        var response = await Dio().get('https://random.dog/woof.json');
        if (response.statusCode == 200) {
          var data = videoModelFromJson(jsonEncode(response.data));
          emit(VideoLoadedState(videoModel: data));
        } else {
          throw Exception('Failed to laod videos');
        }
      } catch (e) {
        emit(VideoErrorState(errorMessage: e.toString()));
      }
    });
  }
}
