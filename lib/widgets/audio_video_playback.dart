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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Audio Recording",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Color(0XFF5951FF),
                  size: 28,
                ),
                onPressed: () {
                  context.read<OnboardingBloc>().add(DeleteAudio());
                },
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          IconButton(
            icon: Icon(
              _isPlaying
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded,
              color: const Color(0XFF5951FF),
              size: 50,
            ),
            onPressed: _playPause,
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
        _controller.setLooping(false); 
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
      _controller.setLooping(false); 
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Video Recording",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Color(0XFF5951FF),
                  size: 28,
                ),
                onPressed: () {
                  context.read<OnboardingBloc>().add(DeleteVideo());
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          AspectRatio(
            aspectRatio: 10 / 16,
            child: VideoPlayer(_controller),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_fill_rounded,
                  size: 50,
                  color: const Color(0XFF5951FF),
                ),
                onPressed: _playPause,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
