import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostpool/blocs/onboarding_event.dart';
import 'package:hostpool/blocs/onboarding_state.dart';
import 'package:hostpool/blocs/onboarding_bloc.dart';
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
                icon:const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions:const  [
                IconButton(
                  icon:const Icon(Icons.close, color: Colors.white),
                  onPressed:null
                ),
              ],
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
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
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      children: [
                        TextField(
                          maxLines: 9,
                          maxLength: 600,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'SpaceGrotesk'),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: '/ Start typing here',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            filled: true,
                            fillColor: Colors.grey[900],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0XFF9196FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            context
                                .read<OnboardingBloc>()
                                .add(UpdateAnswer(value));
                          },
                        ),
                        const SizedBox(height: 16),
                        if (state.audioRecorded)
                          AudioPlayerWidget(audioPath: state.audioPath!)
                        else if (!state.videoRecorded)
                          const AudioRecorderWidget(),
                        if (state.videoRecorded)
                          VideoPlayerWidget(videoPath: state.videoPath!)
                        else if (!state.audioRecorded)
                          const VideoRecorderWidget(),
                      ],
                    ),
                  ),
                  state.isNextEnabled
                      ? Container(
                          margin: const EdgeInsets.all(16),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.black,
                              ],
                              stops: const [0.0, 1.0],
                              center: Alignment.center,
                              radius: 4,
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(
                                  color: Colors.white54,
                                  width: 1.0,
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: null,
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(width: 8.0),
                                Icon(
                                  Icons.double_arrow,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white.withOpacity(0.1)),
                          child: ElevatedButton(
                            onPressed: null,
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
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white24, fontSize: 16),
                                ),
                                SizedBox(width: 8.0),
                                Icon(
                                  Icons.double_arrow,
                                  color: Colors.white24,
                                ),
                              ],
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
