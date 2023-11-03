import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<StartHistoryEvent>((event, emit) async {
      SharedPreferences sharedprefs = await SharedPreferences.getInstance();
      emit(const HistoryLoadingState());

      var userinfo = json.decode(sharedprefs.getString('userinfo') as String);
      final myListData = [userinfo["uid"]];

      final dataHistory = await FirebaseFirestore.instance
          .collection("UserButtonRequest")
          .limit(30)
          //  .where("uid", isEqualTo: myListData[0])
          .get();
      //.snapshots(includeMetadataChanges: true);

      // final historyDocs = dataHistory.docs.toList();
      final historyLength = dataHistory.docs.length;
      print(" DATA HISTORY ONE Length  ${historyLength}");

      final sortedDocs = dataHistory.docs.toList()
        ..sort((a, b) {
          final timestampA = a['pressedTime'].toDate() as DateTime;
          final timestampB = b['pressedTime'].toDate() as DateTime;
          return timestampB.compareTo(timestampA); // Sort in descending order
        });
      print(" TIME STAMP   ${sortedDocs[0].data()['pressedTime'].toString()}");
      // print(" DATA HISTORY  ${sortedDocs}");
      print(" DATA HISTORY Length  ${sortedDocs.length}");

      emit(StartHistoryState(sortedDocs, userinfo, historyLength));
    });
  }
}
