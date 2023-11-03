import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Screens/Emergency/bloc/medical_bloc.dart';
import 'package:testapp/Screens/notifications/Notifications.dart';
import 'package:testapp/Screens/drawer.dart';
import 'package:testapp/Screens/history/bloc/history_bloc.dart';
import 'package:testapp/global.dart';
import 'dart:convert';

import '../LoginPage.dart';

class ButtonsHistory extends StatefulWidget {
  static final routename = 'history';
  const ButtonsHistory({Key? key}) : super(key: key);

  @override
  State<ButtonsHistory> createState() => _ButtonsHistoryState();
}

class _ButtonsHistoryState extends State<ButtonsHistory> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(const StartHistoryEvent());

    history_count = 0;
  }
  // @override
  // void initState() {

  // }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const DrawerWidg(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Image(
            image: AssetImage('assets/Images/rehman.png'),
            height: 60,
            width: 60,
          ),
        ),
        title: const Text(
          'History',
          style: TextStyle(
              color: Color(0xff212121),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
        actions: <Widget>[
          IconButton(
            icon: Stack(
              children: <Widget>[
                const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                if (notification_count >
                    0) // Show the badge only if there are unread notifications
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red, // You can customize the badge color
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child: Text(
                        notification_count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12, // You can customize the font size
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () async {
              // Handle tapping on the notifications icon
              await Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 700),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: Notifications(),
                ),
              );
              setState(() {
                notification_count = 0;
              });
            },
          ),
          //final GlobalKey<ScaffoldState> _key = GlobalKey();

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                _key.currentState!.openDrawer();
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: () => {},
          //   style: ButtonStyle(
          //     backgroundColor:
          //         MaterialStateProperty.all(Colors.greenAccent),
          //   ),
          //   child: FittedBox(
          //       fit: BoxFit.cover,
          //       child: Text(
          //         'Logout',
          //         style: TextStyle(
          //             color: Colors.teal[900],
          //             fontWeight: FontWeight.bold),
          //       )),
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                if (state is StartHistoryState) {
                  print(
                      state.historyItem[1]['pressedTime'].toDate().toString());
                  //return Text('data');

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.historyItemLength,
                    itemBuilder: (ctx, i) {
                      final doc = state.historyItem[i];

                      return Container(child: ButtonsHistoryBody(doc)

                          // Text(state.historyItem[1]['pressedTime']
                          //     .toDate()
                          //     .toString()),

                          // ButtonsHistoryBody(doc),
                          );
                    },
                  );
                }
                if (state is HistoryLoadingState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  );
                } else {
                  return Text('nothing');
                }
              },
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: FutureBuilder(
          //       future: SharedPreferences.getInstance(),
          //       builder: (context, AsyncSnapshot snapshot) {
          //         if (snapshot.connectionState == ConnectionState.done) {
          //           var userinfo = json.decode(
          //               snapshot.data.getString('userinfo') as String);
          //           final myListData = [
          //             userinfo["uid"],
          //           ];
          //           return StreamBuilder<QuerySnapshot>(
          //               stream: FirebaseFirestore.instance
          //                   .collection("UserButtonRequest")
          //                   .where("uid", isEqualTo: myListData[0])
          //                   .snapshots(includeMetadataChanges: true),
          //               builder: (context, snp) {
          //                 if (snp.hasError) {
          //                   print(snp);
          //                   return const Center(
          //                     child: Text("No Data is here"),
          //                   );
          //                 } else if (snp.hasData || snp.data != null) {
          //                   return snp.data!.docs.length < 1
          //                       ? Center(
          //                           child: Container(
          //                               child: const Text("No Record")))
          //                       : ListView.builder(
          //                           physics: const BouncingScrollPhysics(),
          //                           itemCount: snp.data!.docs.length,
          //                           itemBuilder: (ctx, i) {
          //                             // print(
          //                             //     " history data     ${snp.data!.docs.toList()}");
          //                             final sortedDocs =
          //                                 snp.data!.docs.toList()
          //                                   ..sort((a, b) {
          //                                     final timestampA =
          //                                         a['pressedTime'].toDate()
          //                                             as DateTime;
          //                                     final timestampB =
          //                                         b['pressedTime'].toDate()
          //                                             as DateTime;
          //                                     return timestampB.compareTo(
          //                                         timestampA); // Sort in descending order
          //                                   });

          //                             final doc = sortedDocs[i];
          //                             print(
          //                                 "data for history docs ${doc['pressedTime'].toDate().toString()}");
          //                             return Container(
          //                               // color: Colors.blue,
          //                               child: ButtonsHistoryBody(doc),
          //                             );
          //                           },
          //                         );
          //                 }
          //                 return const Center(
          //                   child: CircularProgressIndicator(
          //                     valueColor:
          //                         AlwaysStoppedAnimation<Color>(Colors.black),
          //                   ),
          //                 );
          //               });
          //         } else {
          //           return const Center(
          //             child: CircularProgressIndicator(
          //               valueColor:
          //                   AlwaysStoppedAnimation<Color>(Colors.black),
          //             ),
          //           );
          //         }
          //       }),
          // ),
        ],
      ),
    );
  }
}

class ButtonsHistoryBody extends StatefulWidget {
  final comp;
  ButtonsHistoryBody(this.comp);
  @override
  State<ButtonsHistoryBody> createState() => _ButtonsHistoryBodyState();
}

class _ButtonsHistoryBodyState extends State<ButtonsHistoryBody> {
  @override
  Widget build(BuildContext context) {
    String time = widget.comp.data()['pressedTime'].toDate().toString();
    return Container(
      //  color: Color.fromARGB(255, 112, 9, 9),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child:

              //  Material(
              //   color: Color.fromARGB(55, 255, 255, 255),
              //   // shadowColor: Color(0xffBDBDBD),
              //   //   elevation: 5,
              //   shape:
              //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //   child: Padding(
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              //       child:

              Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(236, 238, 240, 1),
              //  color: Color(0xffd9d9d9),
              //    border: Border.all(width: 1, color: Color(0xffd9d9d9))
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                //   tileColor: const Color.fromARGB(255, 59, 47, 47),
                leading: widget.comp.data()['type'] == 'button-one'
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffd9d9d9),

                            //    color: Color.fromARGB(255, 189, 183, 183),
                            border: Border.all(
                                width: 1, color: const Color(0xffd9d9d9))),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            //   Icons.local_grocery_store_sharp,
                            Icons.security,
                            color: Color(0xff2824e5),
                          ),
                        ),
                      )
                    : widget.comp.data()['type'] == 'button-two'
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffd9d9d9),

                                //    color: Color.fromARGB(255, 189, 183, 183),
                                border: Border.all(
                                    width: 1, color: const Color(0xffd9d9d9))),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.medical_services,
                                color: Color(0xff2824e5),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffd9d9d9),

                                //    color: Color.fromARGB(255, 189, 183, 183),
                                border: Border.all(
                                    width: 1, color: const Color(0xffd9d9d9))),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.local_grocery_store_sharp,
                                color: Color(0xff2824e5),
                              ),
                            ),
                          ),

                //           widget.comp.data()['type'] == 'button-two'
                //               ?  Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Color(0xffd9d9d9),

                //       //    color: Color.fromARGB(255, 189, 183, 183),
                //       border: Border.all(width: 1, color: Color(0xffd9d9d9))),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Icon(
                //       Icons.local_grocery_store_sharp,
                //       color: Color(0xff2824e5),
                //     ),
                //   ),
                // ):

                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Color(0xffd9d9d9),

                //       //    color: Color.fromARGB(255, 189, 183, 183),
                //       border: Border.all(width: 1, color: Color(0xffd9d9d9))),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Icon(
                //       Icons.local_grocery_store_sharp,
                //       color: Color(0xff2824e5),
                //     ),
                //   ),
                // ),
                //  ClipRRect(
                //     borderRadius: BorderRadius.circular(12),
                //     child: Image(
                //         width: 50,
                //         height: 50,
                //         fit: BoxFit.cover,
                //         image: widget.comp.data()['type'] == 'button-one'
                //             ? AssetImage('assets/Images/Security.jpg')
                //             : widget.comp.data()['type'] == 'button-two'
                //                 ? AssetImage('assets/Images/Doctor.jpg')
                //                 : AssetImage('assets/Images/Grocery.avif'))),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comp.data()['type'] == 'button-one'
                          ? 'SECURITY'
                          : widget.comp.data()['type'] == 'button-two'
                              ? 'EMERGENCY'
                              : 'GROCERY',
                      style: const TextStyle(
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      'You have purchased grocery item on monday at 16:02:12 ',
                      style: TextStyle(fontSize: 13, color: Color(0xff757272)),
                    )
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.comp.data()['pressedTime'].toDate().toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 11),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Color.fromARGB(255, 240, 134, 134),
                    //       border:
                    //           Border.all(width: 1, color: Color(0xffd9d9d9))),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Icon(
                    //       Icons.delete,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    // Text(
                    //   'data',
                    //   style: TextStyle(
                    //       color: Color(0xff757575),
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 12),
                    // ),
                  ],
                ),
              ),
            ),
          )

          //Material
          //       ),
          // ),

          ),
    );
  }
}

// ListTile(
//   //   tileColor: const Color.fromARGB(255, 59, 47, 47),
//   leading: ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Image(
//           width: 50,
//           height: 50,
//           fit: BoxFit.cover,
//           image: widget.comp.data()['type'] == 'button-one'
//               ? AssetImage('assets/Images/Security.jpg')
//               : widget.comp.data()['type'] == 'button-two'
//                   ? AssetImage('assets/Images/Doctor.jpg')
//                   : AssetImage('assets/Images/Grocery.avif'))),
//   title: Column(
//     children: [
//       Text(
//         widget.comp.data()['type'] == 'button-one'
//             ? 'SECURITY'
//             : widget.comp.data()['type'] == 'button-two'
//                 ? 'EMERGENCY'
//                 : 'GROCERY',
//         style: TextStyle(
//             color: Color(0xff212121),
//             fontWeight: FontWeight.w700),
//       ),
//     ],
//   ),
//   subtitle: Text(
//     widget.comp.data()['pressedTime'].toDate().toString(),
//     style: TextStyle(
//         color: Color(0xff757575),
//         fontWeight: FontWeight.w500,
//         fontSize: 12),
//   ),
// )
