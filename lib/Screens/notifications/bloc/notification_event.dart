part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class StartNotiifcationEvent extends NotificationEvent {
  const StartNotiifcationEvent();
  // @override
  // List<Object> get props => [];
}
