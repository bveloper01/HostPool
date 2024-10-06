import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostpool/blocs/onboarding_event.dart';
import 'package:hostpool/blocs/onboarding_state.dart';
import '../blocs/onboarding_bloc.dart';
import 'package:hostpool/widgets/audio_video_recorder.dart';
import 'package:hostpool/widgets/audio_video_playback.dart';

class OnboardingQuestionScreen extends StatelessWidget {
  const OnboardingQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    // Handle close action
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Why do you want to host with us?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tell us about your intent and what motivates you to create experiences.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          maxLines: 9,
                          maxLength: 600,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '/ Start typing here',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            context
                                .read<OnboardingBloc>()
                                .add(UpdateAnswer(value));
                          },
                        ),
                        SizedBox(height: 16),
                        if (state.audioRecorded)
                          AudioPlayerWidget(audioPath: state.audioPath!)
                        else if (!state.videoRecorded)
                          AudioRecorderWidget(),
                        SizedBox(height: 16),
                        if (state.videoRecorded)
                          VideoPlayerWidget(videoPath: state.videoPath!)
                        else if (!state.audioRecorded)
                          VideoRecorderWidget(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.isNextEnabled
                              ? Colors.white
                              : Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.isNextEnabled
                            ? () {
                                // Handle next action
                              }
                            : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: state.isNextEnabled
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: state.isNextEnabled
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
