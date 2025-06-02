import 'package:flutter/material.dart';
import 'package:pro1/Task/Check-Out/Personal_Information.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pro1/data/session_manager.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Rajan Kumar"),
            accountEmail: Text("Krajan92946@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/MyImage.jpg",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("assets/Backgrnd.avif"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.medical_information),
            title: Text(
              'Your Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () {
              Get.to(PersonalInformation());
            } ,
            trailing: ClipOval(
              child: Container(
                child: Icon(Icons.add),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(
              'Friends',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(
              'Share',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
              'Request',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                height: 20,
                width: 20,
                child: Center(
                  child: Text(
                    '18',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(
              'Policies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () => null,
          ),
          Divider(),
          SizedBox(height: 26),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            onTap: () async {
              SessionManager.logOut();
              // You may also want to navigate to login screen here
            },
          ),
          SizedBox(
            height: 150,
            child: Center(
              child: Column(
                children: [
                  Text("Welcome Home"),
                  TextButton(
                    onPressed: () async {
                      final prefs = await _prefs;
                      print(prefs.getString('token'));
                    },
                    child: Text("Print Token"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
