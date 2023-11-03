import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

part 'emergency_service_event.dart';
part 'emergency_service_state.dart';

class EmergencyServiceBloc
    extends Bloc<EmergencyServiceEvent, EmergencyServiceState> {
  EmergencyServiceBloc() : super(EmergencyServiceInitial()) {
    on<MedicalButtonPressedEvent>((event, emit) async {
      if (event.btn_count_medi <= 25) {
        event.btn_count_medi = event.btn_count_medi + 1;
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.none) {
          emit(OfflineButtonPressedState());
        } else {
          emit(MedicalButtonPressedState());
        }
      }
    });
    on<GroceryButtonPressedEvent>((event, emit) async {
      if (event.btn_count_grocery <= 25) {
        event.btn_count_grocery = event.btn_count_grocery + 1;
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.none) {
          emit(OfflineButtonPressedState());
        } else {
          emit(GroceryButtonPressedState());
        }
      }
    });

    on<SecurityButtonPressedEvent>((event, emit) async {
      if (event.btn_count_secur <= 25) {
        event..btn_count_secur = event.btn_count_secur + 1;
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.none) {
          emit(OfflineButtonPressedState());
        } else {
          emit(SecurityButtonPressedState());
        }
      }
    });
  }
}
