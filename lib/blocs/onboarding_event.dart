import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class UpdateAnswer extends OnboardingEvent {
  final String answer;

  const UpdateAnswer(this.answer);

  @override
  List<Object> get props => [answer];
}

class RecordAudio extends OnboardingEvent {}

class StopAudioRecording extends OnboardingEvent {
  final String path;

  const StopAudioRecording(this.path);

  @override
  List<Object> get props => [path];
}

class DeleteAudio extends OnboardingEvent {}

class RecordVideo extends OnboardingEvent {}

class StopVideoRecording extends OnboardingEvent {
  final String path;

  const StopVideoRecording(this.path);

  @override
  List<Object> get props => [path];
}

class DeleteVideo extends OnboardingEvent {}
