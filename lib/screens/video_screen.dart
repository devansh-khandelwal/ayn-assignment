import 'package:ayna_assignment_2/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screen2.dart';
import 'package:hive/hive.dart';
import '../blocs/video_bloc/video_bloc.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void _navigateToScreen2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Screen2()),
    );
  }

  Future<void> _saveMediaToLocalDB(dynamic mediaData) async {
    final box = await Hive.openBox('media');
    await box.add(mediaData);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen1'),
        centerTitle: true,
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoInitialState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is VideoLoadedState) {
            print(state.videoModel.url);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.videoModel.url.toString().endsWith('.mp4')
                    ? SizedBox(
                      height: MediaQuery.of(context).size.height /
                      2,
                        child: VideoWidget(
                            videoUrl: state.videoModel.url.toString()),
                      )
                    : Image.network(
                  state.videoModel.url!,
                  height:
                  MediaQuery.of(context).size.height / 2,
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        _saveMediaToLocalDB(state.videoModel.url);
                        _navigateToScreen2();
                      },
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is VideoErrorState) {
            return Text(state.errorMessage);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
