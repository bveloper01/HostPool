import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final String answer;
  final bool audioRecorded;
  final String? audioPath;
  final bool videoRecorded;
  final String? videoPath;
  final bool isNextEnabled;

  const OnboardingState({
    this.answer = '',
    this.audioRecorded = false,
    this.audioPath,
    this.videoRecorded = false,
    this.videoPath,
    this.isNextEnabled = false,
  });

  OnboardingState copyWith({
    String? answer,
    bool? audioRecorded,
    String? audioPath,
    bool? videoRecorded,
    String? videoPath,
    bool? isNextEnabled,
  }) {
    return OnboardingState(
      answer: answer ?? this.answer,
      audioRecorded: audioRecorded ?? this.audioRecorded,
      audioPath: audioPath ?? this.audioPath,
      videoRecorded: videoRecorded ?? this.videoRecorded,
      videoPath: videoPath ?? this.videoPath,
      isNextEnabled: isNextEnabled ?? this.isNextEnabled,
    );
  }

  @override
  List<Object?> get props => [answer, audioRecorded, audioPath, videoRecorded, videoPath, isNextEnabled];
}