import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostpool/blocs/onboarding_event.dart';
import 'package:hostpool/blocs/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState()) {
    on<UpdateAnswer>(_onUpdateAnswer);
    on<RecordAudio>(_onRecordAudio);
    on<StopAudioRecording>(_onStopAudioRecording);
    on<DeleteAudio>(_onDeleteAudio);
    on<RecordVideo>(_onRecordVideo);
    on<StopVideoRecording>(_onStopVideoRecording);
    on<DeleteVideo>(_onDeleteVideo);
  }

  void _onUpdateAnswer(UpdateAnswer event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      answer: event.answer,
      isNextEnabled: event.answer.isNotEmpty || state.audioRecorded || state.videoRecorded,
    ));
  }

  void _onRecordAudio(RecordAudio event, Emitter<OnboardingState> emit) {
    // Implement audio recording logic
  }

  void _onStopAudioRecording(StopAudioRecording event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      audioRecorded: true,
      audioPath: event.path,
      isNextEnabled: true,
    ));
  }

  void _onDeleteAudio(DeleteAudio event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      audioRecorded: false,
      audioPath: null,
      isNextEnabled: state.answer.isNotEmpty || state.videoRecorded,
    ));
  }

  void _onDeleteVideo(DeleteVideo event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      videoRecorded: false,
      videoPath: null,
      isNextEnabled: state.answer.isNotEmpty || state.audioRecorded,
    ));
  }


  void _onRecordVideo(RecordVideo event, Emitter<OnboardingState> emit) {
    // Implement video recording logic
  }

  void _onStopVideoRecording(StopVideoRecording event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      videoRecorded: true,
      videoPath: event.path,
      isNextEnabled: true,
    ));
  }

 
}