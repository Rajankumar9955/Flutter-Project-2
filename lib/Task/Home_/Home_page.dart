import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro2/Task/AddToCart/Cart_page.dart';
import 'package:pro2/Task/Check-Out/Personal_Information.dart';
import 'package:pro2/Task/Home_/Home_content/HomeContent_page.dart';
import 'package:pro2/Task/Search_/Search_page.dart';
import 'package:pro2/Task/Settings_/Settings.dart';
import 'package:pro2/Task/WishList_/Wishlist.dart';
import 'package:pro2/Task/Pages/NavbarSlider_page.dart';
import 'package:get/get.dart';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  int _selecteIndex=0;
  DateTime timeBackPressed= DateTime.now();

static final List<Widget> _screen=[
  HomeContent_page(),
  WishList(),
  AddToCart(),
  Search_page(),
  Settings(),
];

  void _onItemTapped(int index){
     setState(() {
          _selecteIndex=index;
     });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavbarSlider(),
      appBar: AppBar(
        title: Text("Stylish", style: TextStyle(
          fontSize: 25, fontFamily: "monserrat",fontWeight: FontWeight.bold, color:Colors.cyan
        ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
                  Get.to(PersonalInformation());
          }, icon: Icon(Icons.admin_panel_settings)),
        ],
       ),

       body: DoubleBackToCloseApp( snackBar: const SnackBar(
            content: Text('Tap back again to Exit app'),
          ), child: _screen[_selecteIndex], ),
  
// //////////////////////////////////////////////////////
    bottomNavigationBar: BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarItem(CupertinoIcons.home, 'Home', 0),
          buildNavBarItem(CupertinoIcons.heart_solid, 'Wishlist', 1),
         const SizedBox(width: 20),
          buildNavBarItem(CupertinoIcons.search, 'Search', 3),
          buildNavBarItem(CupertinoIcons.settings, 'Settings', 4),
          ],
      ),
    ),
    floatingActionButton: FloatingActionButton(backgroundColor: Colors.white, 
                      shape:  CircleBorder(), 
                         child: Icon(CupertinoIcons.cart, color: _selecteIndex==2 ? Colors.red:Colors.black87,),
                            onPressed: (){
                              setState(() {
                                _selecteIndex=2;
                              });
                          }),
                          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  
  buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: ()=>  _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selecteIndex == index ? Colors.red: Colors.black87,
            ),
            Text(
              label,
              style: TextStyle(
                 color: _selecteIndex == index ? Colors.red: Colors.black87,
              ),
              ),
        ],
      ),
    );
  }
}


