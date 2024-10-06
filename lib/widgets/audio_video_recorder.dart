import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:camera/camera.dart';
import 'package:hostpool/blocs/onboarding_event.dart';
import 'package:hostpool/blocs/onboarding_bloc.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({super.key});
  @override
  AudioRecorderWidgetState createState() => AudioRecorderWidgetState();
}

class AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  final List<double> _waveformData = [];

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }

  Future<void> _startRecording() async {
    await _recorder!.startRecorder(toFile: 'audio.aac');
    setState(() {
      _isRecording = true;
      _waveformData.clear();
    });
    _updateWaveform();
  }

  Future<void> _stopRecording() async {
    final path = await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    context.read<OnboardingBloc>().add(StopAudioRecording(path!));
  }

  void _cancelRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
      _waveformData.clear();
    });
  }

  void _updateWaveform() {
    if (_isRecording) {
      setState(() {
        _waveformData.add(Random().nextDouble());
        if (_waveformData.length > 50) _waveformData.removeAt(0);
      });
      Future.delayed(const Duration(milliseconds: 100), _updateWaveform);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (_isRecording)
            ? Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recording Audio...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0XFF5951FF),
                          size: 40,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: AudioWaveform(waveformData: _waveformData)),
                        if (_isRecording)
                          TextButton(
                            onPressed: _cancelRecording,
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.red)),
                          ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
        _isRecording
            ? const SizedBox(
                height: 20,
              )
            : const SizedBox(
                height: 0,
              ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white.withOpacity(0.1)),
          height: 65,
          child: ElevatedButton(
            onPressed: _isRecording ? _stopRecording : _startRecording,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(
                  color: Colors.white24,
                  width: 1.0,
                ),
              ),
              elevation: 0,
            ),
            child: Icon(_isRecording ? Icons.stop : Icons.mic,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class AudioWaveform extends StatelessWidget {
  final List<double> waveformData;

  const AudioWaveform({super.key, required this.waveformData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: waveformData.map((height) => _buildBar(height)).toList(),
      ),
    );
  }

  Widget _buildBar(double height) {
    return Row(
      children: [
        Container(
          width: 2.3,
          height: 50 * height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(
          width: 2,
        )
      ],
    );
  }
}

class VideoRecorderWidget extends StatefulWidget {
  const VideoRecorderWidget({super.key});
  @override
  VideoRecorderWidgetState createState() => VideoRecorderWidgetState();
}

class VideoRecorderWidgetState extends State<VideoRecorderWidget> {
  CameraController? _controller;
  bool _isRecording = false;
  bool _showCameraPreview = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    await _controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startVideoRecording() async {
    await _controller!.startVideoRecording();
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopVideoRecording() async {
    final file = await _controller!.stopVideoRecording();
    setState(() {
      _isRecording = false;
    });
    context.read<OnboardingBloc>().add(StopVideoRecording(file.path));
  }

  void _cancelVideoRecording() async {
    await _controller!.stopVideoRecording();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showCameraPreview)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recording Video...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AspectRatio(
                      aspectRatio: 10 / 16,
                      child: CameraPreview(_controller!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0XFF5951FF),
                      size: 40,
                    ),
                    if (_isRecording)
                      TextButton(
                        onPressed: _cancelVideoRecording,
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white.withOpacity(0.1)),
          height: 65,
          child: ElevatedButton(
            onPressed: () {
              if (_isRecording) {
                _stopVideoRecording();
              } else {
                setState(() {
                  _showCameraPreview = true;
                });
                _startVideoRecording();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(
                  color: Colors.white24,
                  width: 1.0,
                ),
              ),
              elevation: 0,
            ),
            child: Icon(_isRecording ? Icons.stop : Icons.videocam,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}
