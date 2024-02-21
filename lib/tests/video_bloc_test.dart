import 'package:bloc_test/bloc_test.dart';
import 'package:ayna_assignment_2/blocs/video_bloc/video_bloc.dart';
import 'package:ayna_assignment_2/models/video_model.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late VideoBloc videoBloc;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    videoBloc = VideoBloc();
  });

  tearDown(() {
    videoBloc.close();
  });

  group('VideoBloc', () {
    final mockVideoModel = VideoModel(url: 'https://example.com/video.mp4');

    blocTest<VideoBloc, VideoState>(
      'emits [VideoInitialState, VideoLoadedState] when VideoLoadedEvent is added',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => Response(
          data: {'url': mockVideoModel.url},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));
        return videoBloc;
      },
      act: (bloc) => bloc.add(VideoLoadedEvent(videoModel: mockVideoModel)),
      expect: () => [
        VideoInitialState(),
        VideoLoadedState(videoModel: mockVideoModel),
      ],
    );

    blocTest<VideoBloc, VideoState>(
      'emits [VideoInitialState, VideoErrorState] when Dio throws an exception',
      build: () {
        when(() => mockDio.get(any())).thenThrow(Exception('Error fetching video'));
        return videoBloc;
      },
      act: (bloc) => bloc.add(VideoLoadedEvent(videoModel: mockVideoModel)),
      expect: () => [
        VideoInitialState(),
        VideoErrorState(errorMessage: 'Exception: Error fetching video'),
      ],
    );
  });
}
