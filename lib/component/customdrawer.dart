
import 'package:front/component/customlisttile.dart';
import 'package:front/component/drawer_icon.dart';
import '../theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import '';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 35, 85, 82),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 10),
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      "images/OIP.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Walaa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "email",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          child: SizedBox(
                            width: 110,
                            height: 40,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "editprofile");
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: const Color.fromARGB(255, 28, 79, 127),
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            DrawerIconItem(
              icon: Icons.home,
              text: "Home",
              onTap: () {},
          ),


            ListTile(
              leading: Icon(
                Icons.dark_mode,
                color: Color.fromARGB(255, 150, 148, 148),
              ),
              title: const Text(
                "Theme",
                style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: Consumer<Themeprovider>(
                builder: (context, themeProvider, child) {
                  return Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeTrackColor:
                      const Color.fromARGB(255, 28, 79, 127),
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  );
                },
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.notifications,
                color: Color.fromARGB(255, 150, 148, 148),
              ),
              title: const Text(
                "Notifications",
                style: TextStyle(fontSize: 17, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              trailing: Consumer<Themeprovider>(
                builder: (context, provider, child) {
                  return Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeTrackColor:
                      const Color.fromARGB(255, 240, 223, 111),
                      value: false,
                      onChanged: (_) {},
                    ),
                  );
                },
              ),
            ),
            
            //CustomIcon(icon: Icons.language, label: "Language"),
            DrawerIconItem(
            icon: Icons.location_on_rounded,
            text: "Location",
            onTap: () {},
),

            DrawerIconItem(
            icon: Icons.language,
            text: "Language",
            onTap: () {},
),

            DrawerIconItem(
            icon: Icons.accessibility,
            text: "Accessibility Tools",
            onTap: () {},
),

            DrawerIconItem(
            icon: Icons.feedback,
            text: "Feedback",
            onTap: () {},
),

            DrawerIconItem(
            icon: Icons.phone,
            text: "Contact Us",
            onTap: () {},
),

            ListTile(
              leading: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: const Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 233, 236, 90),
                ),
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 233, 236, 90),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
