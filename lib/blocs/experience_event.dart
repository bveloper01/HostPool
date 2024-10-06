import 'package:equatable/equatable.dart';
import 'package:hostpool/models/experience_model.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class FetchExperiences extends ExperienceEvent {}

class SelectExperience extends ExperienceEvent {
  final Experience experience;

  const SelectExperience(this.experience);

  @override
  List<Object> get props => [experience];
}

class DeselectExperience extends ExperienceEvent {
  final Experience experience;

  const DeselectExperience(this.experience);

  @override
  List<Object> get props => [experience];
}

class UpdateDescription extends ExperienceEvent {
  final String description;

  const UpdateDescription(this.description);

  @override
  List<Object> get props => [description];
}
