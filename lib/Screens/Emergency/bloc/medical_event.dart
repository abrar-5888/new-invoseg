part of 'medical_bloc.dart';

sealed class MedicalEvent extends Equatable {
  const MedicalEvent();

  @override
  List<Object> get props => [];
}

class StartMedicalEvent extends MedicalEvent {
  const StartMedicalEvent();
  // @override
  // List<Object> get props => [];
}
