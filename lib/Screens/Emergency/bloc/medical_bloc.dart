import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'medical_event.dart';
part 'medical_state.dart';

class MedicalBloc extends Bloc<MedicalEvent, MedicalState> {
  MedicalBloc() : super(MedicalInitial()) {
    on<StartMedicalEvent>((event, emit) async {
      emit(const loadingMedicalState());
      final dataMedical = await FirebaseFirestore.instance
          .collection("consultation")
          .orderBy('date', descending: true)
          .limit(30)
          .get();

      final medicalDocs = dataMedical.docs;
      final idList = [];
      List<dynamic> dataList = [];

      medicalDocs.forEach((element) {
        idList.add(element.id);
        dataList.add(element.data());
      });

      print(" Medical Data Length   ${medicalDocs.length}");
      print(" Medical ID Length   ${idList.length}");

      print(" Data List Length   ${dataList.length}");
      SharedPreferences sharedprefs = await SharedPreferences.getInstance();

      var userinfo = json.decode(sharedprefs.getString('userinfo') as String);

      emit(StartMedicalState(dataList, userinfo, idList));
    });
  }
}
