
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_listile.dart';
import 'mytext.dart';



class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff26283F),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 10),

            // Custom Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xff26283F),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile & Logo
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rohit Kumar",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "+91 7820078200",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),

                      // Custom Badge (Logo)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.balance,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Drawer Menu Items
            CustomListTile(
              leadingIcon: Icons.account_balance_wallet,
              label: "Wallet",
              onTap: () {},
            ),
            CustomListTile(
              leadingIcon: Icons.history,
              label: "History",
              onTap: () {},
            ),
            CustomListTile(
              leadingIcon: Icons.compare_arrows,
              label: "Transaction History",
              onTap: () {},
            ),
            CustomListTile(
              leadingIcon: Icons.star_rate,
              label: "Rate us",
              onTap: () {},
            ),
            CustomListTile(
              leadingIcon: Icons.info,
              label: "About us",
              onTap: () {},
            ),
            CustomListTile(
              leadingIcon: Icons.privacy_tip,
              label: "Privacy Policy",
              onTap: () {},
            ),
            CustomListTile(
              leadingIcon: Icons.article,
              label: "Terms & Conditions",
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.exit_to_app_rounded, color: Colors.red),
              title: Text("Sign Out", style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),

            // Divider with "Connect With Us"
            Padding(
              padding: EdgeInsets.all( 12.w),
              child: Row(
                children: [
                  Expanded(child: Divider(color: Colors.white, thickness: 1)),
                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 8.0),
                    child: MyText(
                      label: 'Connect With Us',
                      fontWeight: FontWeight.w600,
                      fontColor: Colors.white,
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white, thickness: 1)),
                ],
              ),
            ),

            // Social Media Icons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.facebook, color: Colors.blue), onPressed: () {}),
                  IconButton(icon: Icon(Icons.cancel, color: Colors.black), onPressed: () {}),
                  IconButton(icon: Icon(Icons.play_circle_fill, color: Colors.red), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
