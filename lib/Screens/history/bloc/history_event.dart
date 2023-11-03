part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class StartHistoryEvent extends HistoryEvent {
  const StartHistoryEvent();
  // @override
  // List<Object> get props => [];
}
