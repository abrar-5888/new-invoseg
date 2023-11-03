part of 'emergency_service_bloc.dart';

sealed class EmergencyServiceState

//extends Equatable

{
  const EmergencyServiceState();

  // @override
  // List<Object> get props => [];
}

final class EmergencyServiceInitial extends EmergencyServiceState {}

class MedicalButtonPressedState extends EmergencyServiceState {
  const MedicalButtonPressedState();
  // @override
  // List<Object> get props => [];
}

class GroceryButtonPressedState extends EmergencyServiceState {
  const GroceryButtonPressedState();
  // @override
  // List<Object> get props => [];
}

class SecurityButtonPressedState extends EmergencyServiceState {
  const SecurityButtonPressedState();
  // @override
  // List<Object> get props => [];
}

class OfflineButtonPressedState extends EmergencyServiceState {
  const OfflineButtonPressedState();
  // @override
  // List<Object> get props => [];
}
