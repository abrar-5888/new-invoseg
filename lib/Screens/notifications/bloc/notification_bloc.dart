import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<StartNotiifcationEvent>((event, emit) async {
      emit(const NotificationLoadingState());

      final dataNotification = await FirebaseFirestore.instance
          .collection('notifications')
          .limit(30)
          .get();
      final notifictionItem = dataNotification.docs;

      List<dynamic> notificationDataList = [];

      notifictionItem.forEach((element) {
        notificationDataList.add(element.data());
      });

      // print(" TIME STAMP   ${sortedDocs[0].data()['pressedTime'].toString()}");
      // print(" DATA HISTORY  ${sortedDocs}");
      print(" DATA Notiication Length  ${notificationDataList.length}");

      // print(" DATA Notiication    ${notificationDataList}");

      emit(StartNotificationState(notificationDataList));
    });
  }
}
