part of 'emergency_service_bloc.dart';

sealed class EmergencyServiceEvent

//extends Equatable

{
  const EmergencyServiceEvent();

  // @override
  // List<Object> get props => [];
}

class GroceryButtonPressedEvent extends EmergencyServiceEvent {
  int btn_count_grocery = 1;
  GroceryButtonPressedEvent(this.btn_count_grocery);
  // @override
  // List<Object> get props => [btn_count_grocery];
}

class MedicalButtonPressedEvent extends EmergencyServiceEvent {
  int btn_count_medi = 1;

  MedicalButtonPressedEvent(this.btn_count_medi);
  // @override
  // List<Object> get props => [btn_count_medi];
}

class SecurityButtonPressedEvent extends EmergencyServiceEvent {
  int btn_count_secur = 1;

  SecurityButtonPressedEvent(this.btn_count_secur);
  // @override
  // List<Object> get props => [btn_count_medi];
}
