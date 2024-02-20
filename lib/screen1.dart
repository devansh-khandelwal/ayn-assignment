import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './screen2.dart';
import './video_widget.dart';
import 'package:hive/hive.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  bool _loading = true;
  dynamic _mediaData;

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

  Future<void> _fetchMedia() async {
    setState(() {
      _loading = true;
    });
    try {
      final response = await Dio().get('https://random.dog/woof.json');
      final data = response.data;
      setState(() {
        _mediaData = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error: $e');
    }
  }

  Future<void> _saveMediaToLocalDB(dynamic mediaData) async {
    final box = await Hive.openBox('media');
    await box.add(mediaData);
  }

  void _navigateToScreen2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Screen2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : _mediaData != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_mediaData['url'].endsWith('.mp4'))
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: VideoWidget(videoUrl: _mediaData['url']),
              )
            else
              Image.network(
                _mediaData['url'],
                height: MediaQuery.of(context).size.height / 2,
              ),
            FloatingActionButton(
              onPressed: () {
                _saveMediaToLocalDB(_mediaData);
                _navigateToScreen2();
              },
              child: Icon(Icons.save),
            ),
          ],
        )
            : Text('Failed to load media'),
      ),
    );
  }
}
