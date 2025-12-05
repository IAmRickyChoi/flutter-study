import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: PhotoPage()));
}

class Photo {
  final int id;
  final String title;
  final String thumbnailUrl; // 이미지 주소

  Photo({required this.id, required this.title, required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
       // 힌트: json['id'] ...
       id : json['id'],
       title : json['title'],
       thumbnailUrl : json['thumbnailUrl']       
    );
  }
}

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<Photo> photoList = [];
  bool isLoading = false;

  Future<void> fetchPhotos() async {
    setState(() => isLoading = true);

    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      setState(() {
        photoList = body.map((item) => Photo.fromJson(item)).toList();        
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사진첩')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: photoList.length,
              itemBuilder: (context, index) {
                Photo photo = photoList[index];

                return Card(
                  child: ListTile(
                    // 힌트: Image.network(...) 사용
                    leading: Image.network(photo.thumbnailUrl),
                    
                    title: Text(photo.title),
                  ),
                );
              },
            ),
    );
  }
}
