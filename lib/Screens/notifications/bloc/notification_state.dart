part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

class StartNotificationState extends NotificationState {
  final notificationItem;
  // final historyItemLength;
  // final userInfo;
  const StartNotificationState(this.notificationItem
      // , this.userInfo, this.historyItemLength
      );
  // @override
  // List<Object> get props => [];
}

class NotificationLoadingState extends NotificationState {
  const NotificationLoadingState();
  // @override
  // List<Object> get props => [];
}
