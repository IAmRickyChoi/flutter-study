import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _videoSelected = false;
  late VideoPlayerController controller;
  XFile? _video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('復習'),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
              _videoSelected = false;
              _video = null;
              });
            }, 
            icon: Icon(Icons.home)
          )
        ],
      ),
      body: _videoSelected ? _VideoPlayer(controller: controller,) : _SelectVideo(selectVideo: _selectVideo),
    );
  }

  _selectVideo()async{
    var video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    controller = VideoPlayerController.file(File(video!.path));


    controller.initialize();
    controller.addListener(() {
      setState(() {
        _video = video;
        _videoSelected = true;
      });
    },);
  }
}

class _SelectVideo extends StatelessWidget {
  final VoidCallback selectVideo;
  const _SelectVideo({super.key,required this.selectVideo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: selectVideo, 
        child: Text('Select Video'),
        

      ),
    );
  }
}

class _VideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;
  const _VideoPlayer({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(
              controller
            ),
            Align(alignment:Alignment.center,child:  IconButton(onPressed: (){controller.play();}, icon:Icon(Icons.play_arrow,color: Colors.white,), ))
          ]
        ),
      ),
    );
  }
}
