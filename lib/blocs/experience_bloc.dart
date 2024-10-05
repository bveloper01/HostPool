import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostpool/models/experience_model.dart';
import 'package:hostpool/services/experience_api_service.dart';
import 'package:hostpool/blocs/experience_event.dart';
import 'package:hostpool/blocs/experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final ExperienceApi _api;

  ExperienceBloc(this._api) : super(ExperienceState()) {
    on<FetchExperiences>(_onFetchExperiences);
    on<SelectExperience>(_onSelectExperience);
    on<DeselectExperience>(_onDeselectExperience);
    on<UpdateDescription>(_onUpdateDescription);
  }

  Future<void> _onFetchExperiences(FetchExperiences event, Emitter<ExperienceState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final experiences = await _api.fetchExperiences();
      emit(state.copyWith(experiences: experiences, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _onSelectExperience(SelectExperience event, Emitter<ExperienceState> emit) {
    final updatedSelected = List<Experience>.from(state.selectedExperiences)..add(event.experience);
    emit(state.copyWith(selectedExperiences: updatedSelected));
  }

  void _onDeselectExperience(DeselectExperience event, Emitter<ExperienceState> emit) {
    final updatedSelected = List<Experience>.from(state.selectedExperiences)..remove(event.experience);
    emit(state.copyWith(selectedExperiences: updatedSelected));
  }

  void _onUpdateDescription(UpdateDescription event, Emitter<ExperienceState> emit) {
    emit(state.copyWith(description: event.description));
  }
}