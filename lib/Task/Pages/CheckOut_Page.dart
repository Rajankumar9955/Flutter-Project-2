
import 'package:flutter/material.dart';

class Checkout_page extends StatefulWidget {
  const Checkout_page({super.key});

  @override
  State<Checkout_page> createState() => _Checkout_pageState();
}

class _Checkout_pageState extends State<Checkout_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(title: Text("Checkout_out_Page"),),
    );
  }
}