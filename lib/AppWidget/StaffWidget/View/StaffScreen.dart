import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:m8/AppWidget/CommonWidget/Utils.dart';

import '../../DashboardWidget/View/DashboardPage.dart';
import '../../CommonWidget/Colors.dart' as cus_color;

class StaffScreen extends StatefulWidget {
  StaffScreen({Key? key}) : super(key: key);

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final LocalStorage storage = new LocalStorage('local_store');
  var type;

  var prescriptionImages = [];
  String base64image = "";
  XFile? select_img;
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  void getImage() async {
    imageFile = await _picker.pickImage(source: ImageSource.gallery);
    var imageBytes = File(imageFile!.path).readAsBytesSync();
    base64image = base64Encode(imageBytes);
    print("image string: $base64image");
    // prescriptionImages.add(imageFile);
    setState(() {
      select_img = imageFile;
    });
  }

  TextEditingController name = TextEditingController();
  TextEditingController id_num = TextEditingController();
  TextEditingController p_num = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    initlize();
  }

  initlize() {
    var staff = storage.getItem('select_staff');
    var result_type = storage.getItem('type');

    if (result_type == 'edit') {
      setState(() {
        name.text = staff['name'];
        id_num.text = staff['id_card'];
        email.text = staff['email_address'];
        p_num.text = staff['phone_number'];
        type = result_type;
      });
    } else {
      setState(() {
        name.text = '';
        id_num.text = '';
        email.text = '';
        p_num.text = '';
        type = result_type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 50;
    return new WillPopScope(
      onWillPop: () async {
        // exit(0);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            title: type == 'create'
                ? Text(
                    'Create Staff',
                    style: TextStyle(
                        color: cus_color.btn_text, fontWeight: FontWeight.bold),
                  )
                : Text(''),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  // iconSize: 200,
                  icon: Image.asset('assets/back_btn.png'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()));
                    // Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // Container(
                  //   width: screenWidth * 0.25,
                  //   child: Image.asset('assets/user_logo.png'),
                  // ),
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                    
                        CircleAvatar(
                          backgroundColor: Colors.white,

                          radius: 30,
                          child:   Helper().isvalidElement(select_img)? ClipOval(child: Image.file(File(select_img!.path,),width: 100, height: 150,)):
                          Image.asset('assets/user_logo.png'),

                          // backgroundImage: prescriptionImages.length > 0
                          //     ?
                          //     Image.file(File(prescriptionImages[0]!.path))
                          //     // AssetImage("assets/user_logo.png")
                          //     : AssetImage("assets/user_logo.png"),
                        ),
                        Positioned(
                            bottom: 0,
                            right: -25,
                            child: RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor: cus_color.app_color,
                              child: SizedBox(
                                height: 40,
                                child: IconButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              shape: CircleBorder(),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            color: cus_color.btn_text,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.07,
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
                          controller: name,
                          onChanged: (text) {
                            print(text);

                            this.setState(() {});
                          },
                          decoration: new InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: 'Enter a Staff Name',
                              hintStyle: TextStyle(color: cus_color.border)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('ID Num',
                          style: TextStyle(
                              color: cus_color.btn_text,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.07,
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
                          controller: id_num,
                          onChanged: (text) {
                            print(text);

                            this.setState(() {});
                          },
                          decoration: new InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: 'Enter Staff ID Number',
                              hintStyle: TextStyle(color: cus_color.border)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Phone Number',
                          style: TextStyle(
                              color: cus_color.btn_text,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.07,
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
                          controller: p_num,
                          onChanged: (text) {
                            print(text);

                            this.setState(() {});
                          },
                          decoration: new InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: 'Enter mobile number',
                              hintStyle: TextStyle(color: cus_color.border)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Email Address(Optional)',
                          style: TextStyle(
                              color: cus_color.btn_text,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.07,
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
                          controller: email,
                          onChanged: (text) {
                            print(text);

                            this.setState(() {});
                          },
                          decoration: new InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: 'Enter Staff Email Id',
                              hintStyle: TextStyle(color: cus_color.border)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('User Role',
                          style: TextStyle(
                              color: cus_color.btn_text,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.07,
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
                          controller: name,
                          onChanged: (text) {
                            print(text);

                            this.setState(() {});
                          },
                          decoration: new InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: 'Enter a Staff Name',
                              hintStyle: TextStyle(color: cus_color.border)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      gradient: Helper().GradientColor('select'),
                      border: Border.all(color: cus_color.border),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: type == 'create'
                          ? Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
