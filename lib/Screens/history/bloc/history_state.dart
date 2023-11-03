part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

class StartHistoryState extends HistoryState {
  final historyItem;
  final historyItemLength;
  final userInfo;
  const StartHistoryState(
      this.historyItem, this.userInfo, this.historyItemLength);
  // @override
  // List<Object> get props => [];
}

class HistoryLoadingState extends HistoryState {
  const HistoryLoadingState();
  // @override
  // List<Object> get props => [];
}
