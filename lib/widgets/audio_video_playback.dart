import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:video_player/video_player.dart';
import 'package:hostpool/blocs/onboarding_bloc.dart';
import 'package:hostpool/blocs/onboarding_event.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;

  const AudioPlayerWidget({super.key, required this.audioPath});

  @override
  AudioPlayerWidgetState createState() => AudioPlayerWidgetState();
}

class AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  FlutterSoundPlayer? _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = FlutterSoundPlayer();
    _player!.openPlayer().then((value) {
      _player!.setSubscriptionDuration(const Duration(milliseconds: 10));
      _player!.startPlayer(
        fromURI: widget.audioPath,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
    });
  }

  @override
  void dispose() {
    _player!.closePlayer();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _player!.pausePlayer();
    } else {
      await _player!.startPlayer(
        fromURI: widget.audioPath,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white),
            onPressed: _playPause,
          ),
          Expanded(
            child:
                Text('Audio Recording', style: TextStyle(color: Colors.white)),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              context.read<OnboardingBloc>().add(DeleteAudio());
            },
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(_onVideoCompleted);
        _controller.setLooping(false); // Set looping to false
      });
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoCompleted);
    _controller.dispose();
    super.dispose();
  }

  void _onVideoCompleted() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _controller.pause();
    } else {
      await _controller.play();
      _controller.setLooping(false); // Set looping to false
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: VideoPlayer(_controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white),
                onPressed: _playPause,
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  context.read<OnboardingBloc>().add(DeleteVideo());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
