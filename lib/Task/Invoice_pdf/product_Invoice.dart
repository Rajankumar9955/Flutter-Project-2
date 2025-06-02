import 'package:flutter/material.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final redColor = Colors.pinkAccent;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: redColor,
              padding: EdgeInsets.only(top: 60,left: 20,right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'INVOICE',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('9955236973', style: TextStyle(color: Colors.white)),
                          Text('krajan92946@gmail.com', style: TextStyle(color: Colors.white)),
                          Text('www.stylish.com', style: TextStyle(color: Colors.white)),
                          Text('Mp magar zone 1', style: TextStyle(color: Colors.white)),
                          Text('bhopal, Mp, India', style: TextStyle(color: Colors.white)),
                          Text('462023', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Invoice Info
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Billed to
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Billed To', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Rajan Kumar'),
                        Text('Bharti Niketan bhopal'),
                        Text('bhopal, mp, India'),
                        Text('462023'),
                      ],
                    ),
                  ),
                  // Invoice Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Invoice Number', style: TextStyle(color: Colors.grey)),
                        Text('15464347646835436', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Date of Issue', style: TextStyle(color: Colors.grey)),
                        Text('17/05/25', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Invoice Total', style: TextStyle(color: Colors.grey)),
                        Text('\₹4520.00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: redColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(thickness: 2, color: redColor),

            // Table header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(child: Text('Description', style: TextStyle(color: redColor, fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Unit Cost', style: TextStyle(color: redColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(child: Text('Qty / Hr Rate', style: TextStyle(color: redColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(child: Text('Amount', style: TextStyle(color: redColor, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
                ],
              ),
            ),

            Divider(),

            // Items
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your item Name'),
                          Text('Item description goes here', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(child: Text('\₹1020', textAlign: TextAlign.center)),
                    Expanded(child: Text('1', textAlign: TextAlign.center)),
                    Expanded(child: Text('1000', textAlign: TextAlign.right)),
                  ],
                ),
              );
            }),

            Divider(),

            // Totals
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Subtotal: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Text('\₹4000.00'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Tax: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Text('\₹520.00'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    ElevatedButton(onPressed: (){
                              ////////////////////////
                       ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                             content: Text("Your are print Your purchase items invoice"),
                             backgroundColor: Colors.red,
                        ),
                        );
                    }, child: Text("Print"))
                  ],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
