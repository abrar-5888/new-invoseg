part of 'medical_bloc.dart';

sealed class MedicalState extends Equatable {
  const MedicalState();

  @override
  List<Object> get props => [];
}

final class MedicalInitial extends MedicalState {}

class StartMedicalState extends MedicalState {
  final medicalItem;
  final userInfo;
  final medicalId;
  const StartMedicalState(this.medicalItem, this.userInfo, this.medicalId);

  // @override
  // List<Object> get props => [];
}

class loadingMedicalState extends MedicalState {
  const loadingMedicalState();
  // @override
  // List<Object> get props => [];
}
