// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:the_kntag/colors.dart';
import 'package:the_kntag/creattag/post_editing.dart';
import 'package:the_kntag/massege/Chat/chat_firebase.dart';
//import 'package:the_kntag/creattag/post_setting.dart';
//import 'package:the_kntag/creattag/post_editing.dart';
//import 'package:the_kntag/test.dart';

//import '../map/street_map.dart';

class CreatTagview extends StatefulWidget {
  const CreatTagview({Key? key}) : super(key: key);

  @override
  State<CreatTagview> createState() => _CreatTagviewState();
}

class _CreatTagviewState extends State<CreatTagview> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    dateController.text = '';
    timeController.text = '';
  }

  // DateTime startDate = DateTime.now();

  // Future<void> _startDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: startDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != startDate) {
  //     setState(() {
  //       startDate = picked;
  //     });
  //   }
  // }

  // DateTime endDate = DateTime.now();

  // Future<void> _endDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: endDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != endDate) {
  //     setState(() {
  //       endDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(uid: '')));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: black,
              )),
          title: const Text(
            'Create Tag',
            style: TextStyle(color: black),
          ),
          centerTitle: true,
          //  actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(
          //         builder: (context) =>
          //         );
          //     },
          //     icon:const Icon(
          //       Icons.more_vert,
          //       color: black,
          //     ))
          // ],
          actions: [
            PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: black,
                ),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text(
                        "My Account",
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        "Settings",
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout"),
                    ),
                  ];
                },
                onSelected: (value) {
                  // if(value == 0){
                  //     print("My account menu is selected.");
                  // }else if(value == 1){
                  //     print("Settings menu is selected.");
                  // }else if(value == 2){
                  //     print("Logout menu is selected.");
                  // }
                }),
          ],
        ),
        body: ListView(children: [
          Padding(
            padding:
                EdgeInsets.only(bottom: 1.w, top: 2.w, left: 5.w, right: 5.w),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Tag Name',
                  hintStyle: TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none)),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 1.w, bottom: 1.w, left: 5.w, right: 5.w),
            child: TextField(
              maxLines: 3,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  helperMaxLines: 6,
                  hintText: 'Tag Description',
                  hintStyle: TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(6))),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 1.w, bottom: 1.w, right: 5.w, left: 5.w),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Place',
                  hintStyle: TextStyle(fontSize: 14.sp),
                  // focusColor: blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none)),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 4.w, bottom: 2.w, left: 3.w),
                      child: Text(
                        'Start',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 1.w, bottom: 1.w, left: 4.w, right: 1.w),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(6)),
                              width: 21.w,
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'date',
                                ),
                                controller: dateController,
                                readOnly: true,
                                onTap: () async {
                                  var pickeDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));

                                  if (pickeDate != null) {
                                    // print(pickeDate);
                                    String formatedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickeDate);
                                    //  print(formatedDate);
                                    setState(() {
                                      dateController.text = formatedDate;
                                    });
                                  } else {
                                    print('date is not selected');
                                  }
                                },
                                style: const TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 1.w, top: 1.w, right: 1.w, left: 1.w),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(6)),

                              width: 21.w,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Time',
                                  hintStyle: TextStyle(fontSize: 11.sp),
                                  filled: true,
                                  fillColor: white,
                                ),
                                onTap: () {},
                              ),

                              //  onPressed: () {}
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4.w, bottom: 2.w, left: 2),
                      child: Text(
                        'End',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 1.w, bottom: 1.w, right: 1.w, left: 1.w),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              width: 21.w,
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'date',
                                ),
                                controller: dateController,
                                readOnly: true,
                                onTap: () async {
                                  var pickeDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));

                                  if (pickeDate != null) {
                                    // print(pickeDate);
                                    String formatedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickeDate);
                                    //  print(formatedDate);
                                    setState(() {
                                      dateController.text = formatedDate;
                                    });
                                  } else {
                                    print('date is not selected');
                                  }
                                },
                                style: const TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 1.w, bottom: 1.w, left: 1.w, right: 2.w),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              width: 21.w,
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Time',
                                ),
                                controller: timeController,
                                readOnly: true,
                                onTap: () async {
                                  var pickeTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickeTime != null) {
                                    setState(() {
                                      timeController.text =
                                          pickeTime.format(context);
                                    });
                                  } else {
                                    print('time is not selected');
                                  }
                                },
                                style: const TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 25.w,
              // width: 30.w,
              child: Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: ListView.builder(
                      // shrinkWrap: false,

                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 3.5.w, right: 0.8.w),
                          child: Container(
                            height: 5.w,
                            width: 27.w,
                            padding: const EdgeInsets.only(
                                top: 1, bottom: 1, right: 2, left: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: white),
                            child: Center(
                                child: Text(
                              '#Image',
                              style: TextStyle(fontSize: 11.sp),
                            )),
                          ),
                        );
                      })),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3.w),
            child: ButtonTheme(
              minWidth: 90.w,
              height: 14.w,
              child: RaisedButton(
                color: blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const PostEditingPage())));
                },
                child: const Text(
                  "next",
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ),
        ]));
  }
}
