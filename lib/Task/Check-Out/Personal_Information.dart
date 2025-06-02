


import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
       final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(        
        leading: BackButton(),
        title: Text("Personal Information", style: TextStyle(fontFamily: 'assets/font/Montserrat-Regular.ttf', fontSize: 20,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: AssetImage('assets/MyImage.jpg',),
                // child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 20),
              _sectionTitle("Personal Details"),
              _buildTextField("Email Address"),
              _buildTextField("Password", obscureText: true),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Change Password", style: TextStyle(color: Colors.pink)),
                ),
              ),
              _sectionTitle("Business Address Details"),
              _buildTextField("Pincode"),
              _buildTextField("Address"),
              _buildTextField("City"),
              _buildTextField("State"),
              _buildTextField("Country"),
              _sectionTitle("Bank Account Details"),
              _buildTextField("Bank Account Number"),
              _buildTextField("Account Holder's Name"),
              _buildTextField("IFSC Code"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}