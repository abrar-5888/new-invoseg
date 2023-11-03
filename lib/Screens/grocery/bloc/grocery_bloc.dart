import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'grocery_event.dart';
part 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  GroceryBloc() : super(GroceryInitial()) {
    on<StartGroceryEvent>((event, emit) async {
      emit(const loadingState());
      var mapData;
      final dataGrocery = await FirebaseFirestore.instance
          .collection("grocery")
          .orderBy("date", descending: true)
          .limit(30)
          .get();

      final groceryDocs = dataGrocery.docs;
      final idList = [];
      // for (var i = 0; i < groceryDocs.length; i++) {
      //   print(groceryDocs[i].id);
      // }
      //final id =groceryDocs[]
      List<dynamic> dataList = [];

      groceryDocs.forEach((element) {
        // var mapDataa;
        // mapDataa = groceryDocs as Map<String, dynamic>;
        // print(" Firebase DATA 222222   ${mapDataa}");

        //  mapDataa[element].data() as Map<String, dynamic>;
        idList.add(element.id);
        dataList.add(element.data());
      });

      print(" Grocery Data Length   ${groceryDocs.length}");
      print(" Grocery ID Length   ${idList.length}");

      print(" Data List Length   ${dataList.length}");

      // print(
      //     ' helllo  helllo helllo helllo helllo helllo helllo helllo helllo helllo helllo helllo');

      // for (var i = 0; i < groceryDocs.length; i++) {
      //   mapData = groceryDocs[i].data() as Map<String, dynamic>;
      //   print(" Firebase DATA   ${mapData}");
      // }

      //print(" Grocery Data Length   ${groceryDocs.length}");

      // User? user = FirebaseAuth.instance.currentUser;
      // String uid = user!.uid;

      SharedPreferences sharedprefs = await SharedPreferences.getInstance();

      var userinfo = json.decode(sharedprefs.getString('userinfo') as String);

      emit(StartGroceryState(dataList, userinfo, idList));
    });
  }
}
