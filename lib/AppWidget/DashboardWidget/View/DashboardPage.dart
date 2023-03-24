import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m8/AppWidget/Api/Api.dart';
import 'package:m8/AppWidget/CommonWidget/Loader.dart';
import 'package:m8/AppWidget/CommonWidget/Utils.dart';
import 'package:m8/AppWidget/DashboardWidget/View/AppMenubar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:m8/AppWidget/StaffWidget/View/StaffScreen.dart';
import '../../CommonWidget/Colors.dart' as cus_color;

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController searchText = TextEditingController();

  var select_btn = 'All';
  var staffList;
  var s_staff;
  var searchList;
  var staffList1;
  var check = 3;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    setState(() {
      isLoading = true;
    });
    var result = await Api().getStaffList(context);
    this.setState(() {
      staffList = result['data']['results'];
      isLoading = false;
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 50;

    staffList1 =
        Helper().isvalidElement(searchList) && searchText.text.isNotEmpty
            ? searchList
            : staffList;
    return new WillPopScope(
      onWillPop: () async {
        exit(0);
        // return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Staff List',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 1, bottom: 1),
                    child: Image.asset('assets/notification.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset('assets/user_logo.png'),
                  )
                ],
              ),
            ],
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset('assets/menu.png'),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ),
        drawer: SafeArea(
            child: Drawer(
          elevation: 50,
          child: MenubarScreen(),
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StaffScreen()));

              storage.setItem('type', 'create');
            },
            child: Container(
              width: 60,
              height: 60,
              child: Icon(
                Icons.person_add_alt_1,
                size: 30,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: Helper().GradientColor('select')),
            )),
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: cus_color.border),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        //  width: screenWidth * 0.65,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth * 0.5,
                            child: TextField(
                              controller: searchText,
                              onChanged: (text) {
                                print(text);

                                this.setState(() {});

                                searchList = staffList.where((element) {
                                  var List =
                                      element['name'].toString().toLowerCase();
                                  return List.contains(text.toLowerCase());
                                  // return true;
                                }).toList();
                              },
                              decoration: new InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              gradient: select_btn == 'All'
                                  ? Helper().GradientColor('select')
                                  : Helper().GradientColor(''),
                              border: Border.all(color: cus_color.border),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Text(
                                'All Staff',
                                style: TextStyle(
                                    color: select_btn == 'All'
                                        ? Colors.white
                                        : cus_color.btn_text),
                              ),
                              onPressed: () {
                                setState(() {
                                  select_btn = 'All';
                                  check = 3;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              gradient: select_btn == 'As'
                                  ? Helper().GradientColor('select')
                                  : Helper().GradientColor(''),
                              border: Border.all(color: cus_color.border),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Text(
                                'Active Staff',
                                style: TextStyle(
                                    color: select_btn == 'As'
                                        ? Colors.white
                                        : cus_color.btn_text),
                              ),
                              onPressed: () {
                                setState(() {
                                  select_btn = 'As';
                                  check = 1;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              gradient: select_btn == 'Ds'
                                  ? Helper().GradientColor('select')
                                  : Helper().GradientColor(''),
                              border: Border.all(color: cus_color.border),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Text(
                                'Deactive Staff',
                                style: TextStyle(
                                  color: select_btn == 'Ds'
                                      ? Colors.white
                                      : cus_color.btn_text,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  select_btn = 'Ds';
                                  check = 0;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      !isLoading
                          ? Helper().isvalidElement(staffList1) &&
                                  staffList1.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: PageScrollPhysics(),
                                  itemCount: staffList1.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = staffList1[index];
                                    return check == 3
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                s_staff = data;
                                                storage.setItem(
                                                    'select_staff', data);
                                              });
                                              showModal();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: screenWidth * 0.06,
                                                      height:
                                                          screenHeight * 0.1,
                                                      decoration: BoxDecoration(
                                                          color: cus_color
                                                              .light_color,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Center(
                                                        child: RotatedBox(
                                                          quarterTurns: 3,
                                                          child: Text(
                                                            '${data['role']}',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        width:
                                                            screenWidth * 0.83,
                                                        height:
                                                            screenHeight * 0.1,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: cus_color
                                                                    .border),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              // Text('dfsadfsa'),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                    child:
                                                                        SizedBox(
                                                                      child: Image
                                                                          .asset(
                                                                              'assets/user_logo.png'),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                                child: Text(
                                                                              '${data['name']}',
                                                                              style: TextStyle(color: cus_color.text_bold, fontSize: 14),
                                                                            )),
                                                                            Container(
                                                                                child: data['status'] == '1'
                                                                                    ? Icon(
                                                                                        Icons.check_circle,
                                                                                        color: Colors.green,
                                                                                        size: 15,
                                                                                      )
                                                                                    : Icon(
                                                                                        Icons.close,
                                                                                        color: Colors.red,
                                                                                        size: 15,
                                                                                      ))
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          '${data['id_card']}',
                                                                          style: TextStyle(
                                                                              color: cus_color.btn_text,
                                                                              fontSize: 12),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: cus_color
                                                                    .border,
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : data['status'] == check.toString()
                                            ? InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    s_staff = data;
                                                    storage.setItem(
                                                        'select_staff', data);
                                                  });
                                                  showModal();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: screenWidth *
                                                              0.06,
                                                          height: screenHeight *
                                                              0.1,
                                                          decoration: BoxDecoration(
                                                              color: cus_color
                                                                  .light_color,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Center(
                                                            child: RotatedBox(
                                                              quarterTurns: 3,
                                                              child: Text(
                                                                '${data['role']}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.83,
                                                            height:
                                                                screenHeight *
                                                                    0.1,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: cus_color
                                                                        .border),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15))),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  // Text('dfsadfsa'),
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10),
                                                                        child:
                                                                            SizedBox(
                                                                          child:
                                                                              Image.asset('assets/user_logo.png'),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 15),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Container(child: Text('${data['name']}')),
                                                                                Container(
                                                                                    child: data['status'] == '1'
                                                                                        ? Icon(
                                                                                            Icons.check_circle,
                                                                                            color: Colors.green,
                                                                                            size: 15,
                                                                                          )
                                                                                        : Icon(
                                                                                            Icons.close,
                                                                                            color: Colors.red,
                                                                                            size: 15,
                                                                                          ))
                                                                              ],
                                                                            ),
                                                                            Text(
                                                                              '${data['id_card']}',
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),

                                                                  Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color: cus_color
                                                                        .border,
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container();
                                  })
                              : Container(
                                  child: Text(
                                  'No Data Found',
                                  textAlign: TextAlign.center,
                                ))
                          : SpinLoader()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showModal() {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Container(
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '______',
                    style: TextStyle(color: cus_color.border, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Icon(
                      //   Icons.more_vert,
                      //   color: cus_color.app_color,
                      // ),
                      PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: cus_color.app_color,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          initialValue: 0,
                          itemBuilder: (context) {
                            return <PopupMenuEntry<int>>[
                              PopupMenuItem(
                                  child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient:
                                          Helper().GradientColor('select'),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () {
                                        setState(() {
                                          storage.setItem('type', 'edit');
                                          storage.setItem(
                                              'select_staff', s_staff);
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StaffScreen()));
                                      },
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              )),
                              PopupMenuItem(child: Text('Deactivate')),
                            ];
                          })
                    ],
                  ),
                  SizedBox(
                      width: 100,
                      // height: 100,
                      child: Image.asset('assets/user_logo.png')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${s_staff['name']}',
                        style:
                            TextStyle(fontSize: 18, color: cus_color.text_bold),
                      ),
                      Container(
                          child: s_staff['status'] == '1'
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 15,
                                )
                              : Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 15,
                                ))
                    ],
                  ),
                  Text(
                    '${s_staff['id_card']}',
                    style: TextStyle(fontSize: 14, color: cus_color.btn_text),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: cus_color.light_color,
                          borderRadius: BorderRadius.circular(20)),
                      // color: Colors.black,
                      height: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Role',
                                style: TextStyle(
                                    color: cus_color.border, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                '${s_staff['role']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: cus_color.text_bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Phone Number',
                                style: TextStyle(
                                    color: cus_color.border, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('${s_staff['phone_number']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: cus_color.text_bold,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Email Id',
                                style: TextStyle(
                                    color: cus_color.border, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('${s_staff['email_address']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: cus_color.text_bold,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
