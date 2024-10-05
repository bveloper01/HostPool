import 'package:equatable/equatable.dart';
import 'package:hostpool/models/experience_model.dart';

class ExperienceState extends Equatable {
  final List<Experience> experiences;
  final List<Experience> selectedExperiences;
  final String description;
  final bool isLoading;
  final String? error;

  const ExperienceState({
    this.experiences = const [],
    this.selectedExperiences = const [],
    this.description = '',
    this.isLoading = false,
    this.error,
  });

  ExperienceState copyWith({
    List<Experience>? experiences,
    List<Experience>? selectedExperiences,
    String? description,
    bool? isLoading,
    String? error,
  }) {
    return ExperienceState(
      experiences: experiences ?? this.experiences,
      selectedExperiences: selectedExperiences ?? this.selectedExperiences,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [experiences, selectedExperiences, description, isLoading, error];
}