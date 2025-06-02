import 'package:flutter/material.dart';
import 'package:pro1/Task/Invoice_pdf/product_Invoice.dart';
import 'package:pro1/Task/LoginSection/CreateUser_page.dart';
import 'package:pro1/data/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class NavbarSlider extends StatelessWidget {
   NavbarSlider({super.key});

 final Future<SharedPreferences>_prefs=SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
                UserAccountsDrawerHeader(
                  accountName: Text("Rajan Kumar"), 
                  accountEmail: Text("Krajan92946@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset("assets/MyImage.jpg",height: 90,width: 90, fit: BoxFit.cover,),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: AssetImage("assets/Backgrnd.avif"),fit: BoxFit.cover),
                  ),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    onTap: () => null,
                  ),
                   ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Friends', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    onTap: () => null,
                  ),
                   ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    onTap: () => null,
                  ),
                   ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Request', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    onTap: () => null,
                    trailing: ClipOval(
                      child: Container(
                        color: Colors.red,
                        height: 20, 
                        width: 20,
                       child: Center(
                        child: Text(
                        '18', style: TextStyle(
                          color: Colors.white, fontSize: 12),),
                      ),
                      ),
                    ),
                  ),
                   Divider(),
                   ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    onTap: () => null,
                  ),
                  
                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text('Generate Invoice', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    onTap: (){
                   Navigator.of(context).push(
                           MaterialPageRoute(builder: (context) => InvoiceScreen()),
                        );
                    },
                  ),
                  Divider(),
                  SizedBox(height: 26,),
                  ListTile(
                    
                    leading: Icon(Icons.logout, color: Colors.red,),
                    title: Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.red),),
                    onTap: () async{
                         SessionManager.logOut();
                    },
                  ),
                  SizedBox(height: 150,
                  child: Center(
                    child: Column(
                      children: [
                        Text("welcome Home"),
                        TextButton(onPressed: ()async{
                           final SharedPreferences? prefs=await _prefs;
                           print(prefs?.get('token'));
                        }, child: Text("Print Token")),
                      ],
                    ),
                  ),
                  )
            ],
          ),
    );
  }
}