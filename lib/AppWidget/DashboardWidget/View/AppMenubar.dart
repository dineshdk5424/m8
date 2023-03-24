import 'package:flutter/material.dart';
import '../../CommonWidget//Colors.dart' as cus_color;

class MenubarScreen extends StatefulWidget {
  MenubarScreen({Key? key}) : super(key: key);

  @override
  State<MenubarScreen> createState() => _MenubarScreenState();
}

class _MenubarScreenState extends State<MenubarScreen> {
  var select_btn = 'home';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 50;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.06,
          ),
          Container(
            width: screenWidth * 0.3,
            child: Image.asset('assets/logo.png'),
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Container(
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
                color:
                    select_btn == 'home' ? cus_color.light_color : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: InkWell(
              onTap: () {
                setState(() {
                  select_btn = 'home';
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenHeight * 0.03,
                        color: cus_color.light_color,
                        child: select_btn == 'home'
                            ? Image.asset('assets/1.png')
                            : Image.asset('assets/6.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Home',
                      style: TextStyle(
                          color: cus_color.app_color,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
                color:
                    select_btn == 'Eh' ? cus_color.light_color : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: InkWell(
              onTap: () {
                setState(() {
                  select_btn = 'Eh';
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenHeight * 0.03,
                        color: cus_color.light_color,
                        child: select_btn == 'Eh'
                            ? Image.asset('assets/2.png')
                            : Image.asset('assets/7.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Exhibitors List',
                      style: TextStyle(
                          color: cus_color.app_color,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
                color: select_btn == 'report'
                    ? cus_color.light_color
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: InkWell(
              onTap: () {
                setState(() {
                  select_btn = 'report';
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenHeight * 0.03,
                        color: cus_color.light_color,
                        child: select_btn == 'report'
                            ? Image.asset('assets/3.png')
                            : Image.asset('assets/8.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Reports',
                      style: TextStyle(
                          color: cus_color.app_color,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
                color: select_btn == 'setting'
                    ? cus_color.light_color
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: InkWell(
              onTap: () {
                setState(() {
                  select_btn = 'setting';
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenHeight * 0.03,
                        color: cus_color.light_color,
                        child: select_btn == 'setting'
                            ? Image.asset('assets/4.png')
                            : Image.asset('assets/9.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          color: cus_color.app_color,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
                color: select_btn == 'logout'
                    ? cus_color.light_color
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: InkWell(
              onTap: () {
                setState(() {
                  select_btn = 'logout';
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenHeight * 0.03,
                        color: cus_color.light_color,
                        child: select_btn == 'logout'
                            ? Image.asset('assets/5.png')
                            : Image.asset('assets/10.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: cus_color.app_color,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
