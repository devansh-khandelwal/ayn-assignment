// screen2.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<dynamic> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final response = await Dio().get('http://jsonplaceholder.typicode.com/posts');
      setState(() {
        _posts = response.data;
        _isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      // Handle error gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data Fetching'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.separated(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 6.0, horizontal:  8.0), // Add margin to each tile on all sides
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD), // Set background color of tile
              borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius for rounded corners
            ),
            child: ListTile(
              title: Text(
                post['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make title bolder
                  fontSize: 18.0, // Make title slightly bigger
                ),
              ),
              subtitle: Text(
                post['body'],
                style: TextStyle(
                  color: Colors.black, // Set body text color to black
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
