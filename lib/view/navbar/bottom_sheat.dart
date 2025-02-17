
import 'package:astrosetu/view/navbar/test.dart';
import 'package:flutter/material.dart';

import 'home.dart';


class BottomNavigation extends StatefulWidget {
  BottomNavigation({
    super.key,
  });

  //  Future<String?> getUserId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('user_id');
  //
  // }


  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  String? userId;


  @override
  void initState() {
    super.initState();
    // _loadUserId();
  }


  List<Widget> pages = [
    HomeScreen(),
    // CartPage(),
    // AstrologersScreen(),
    DashboardScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  //   });
  // }

  int currentindex = 0;
  void _onTapnavigatescreen(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('User ID: $userId');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        children: pages,
        index: currentindex,
      ),
      bottomNavigationBar: Container(
        height: height * 0.10,
        width: width,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 3),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60),
            topLeft: Radius.circular(60),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentindex,
          onTap: _onTapnavigatescreen,
          selectedItemColor: const Color(0xff26283F),
          // backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(
                currentindex == 0 ? Icons.home : Icons.home_outlined,
                color:
                currentindex == 0 ? const Color(0xff26283F) : Colors.black,
                size: 35,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(
                currentindex == 1
                    ? Icons.star
                    : Icons.star_border_outlined,
                color: currentindex == 1
                    ? const Color(0xfff26283F)
                    : Colors.black,
                size: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: currentindex == 2
                  ? const Icon(
                Icons.account_circle,
                color: Color(0xff26283F),
                size: 35,
              )
                  : const Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
                size: 35,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: currentindex == 3
                  ? const Icon(Icons.notifications,
                  size: 35, color: Color(0xff26283F))

                  : const Icon(
                Icons.notifications_none,
                size: 35,
                color: Colors.black,
              ),
              label: "",
            ),
          ],
          elevation: 0,
        ),
      ),

    );
  }
}
