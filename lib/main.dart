//main.dart
import 'package:ayna_assignment_2/blocs/video_bloc/video_bloc.dart';
import 'package:ayna_assignment_2/models/video_model.dart';
import 'package:ayna_assignment_2/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            VideoBloc()..add(VideoLoadedEvent(videoModel: VideoModel())),
        child: VideoScreen(),
      ),
    );
  }
}
