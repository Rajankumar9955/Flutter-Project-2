// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'package:pro1/3rd%20day/product_detail_page.dart';
// import 'package:pro1/Task/LoginSection/Login_Page.dart';
// import 'package:pro1/Task/Intro_Page/model/IntroPageModel.dart';

// class TaskBySir extends StatefulWidget {
//      ///////////
//   const TaskBySir({super.key,
//            //////////
//   });

//   @override
//   State<TaskBySir> createState() => _EcommerceState();
// }

// class _EcommerceState extends State<TaskBySir> {
//   PageController pageController = PageController();
//   int currentPage = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//                     child: Text(
//                       " ${currentPage+1}/3",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: const Color.fromARGB(255, 3, 3, 2),
//                         fontFamily: 'Montserrat',
//                         fontSize: 18,
                        
//                       ),
//                     ),
//                     // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   ),
//                   Container(
//                     //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//                     child: 
//                     InkWell (
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
//                       },child: Text(
//                       "Skip",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: const Color.fromARGB(255, 3, 3, 2),
//                         fontFamily: 'Montserrat',
//                         fontSize: 18,
//                       ),
//                       )
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: PageView.builder(
//                   controller: pageController,
//                   onPageChanged: (value) {
//                     currentPage = value;
//                     setState(() {
//                       currentPage = value;
//                     });
//                   },
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     return CustomSliderWidget(
//                       product: products[index],
//                     );
//                   },
//                 ),
//               ),
//               Row(
//                 children: [
//                   if (currentPage > 0) InkWell(
//                     onTap: (){
//                       setState(() {
//                         currentPage--;
//                         pageController.previousPage(duration: Duration(microseconds: 300), curve: Curves.bounceIn);
//                       });
//                     },
//                     child: Text("Prev")),

//                   Expanded(
//                     // decoration: BoxDecoration(border: Border.all(color: Colors.black)),

//                     // margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         3,
//                         (index) => Container(
//                           margin: EdgeInsets.only(left: 5),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: const Color.fromARGB(255, 16, 15, 15),
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.black,
//                           ),
//                           height: 12,
//                           width: currentPage == index ? 30 : 10,
//                         ),
//                       ),
//                     ),
                    
//                   ),
                  

//                   InkWell(
//                     onTap:
//                         currentPage < products.length-1
//                             ? () {
//                               setState(() {
//                                 currentPage++;
//                                 pageController.nextPage(
//                                   duration: Duration(milliseconds: 300),
//                                   curve: Curves.bounceIn,
//                                 );
//                               });
//                             }
//                             : () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
//                             },
//                     child: Text(
//                       currentPage == 2 ? "Get Started" : "Next",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.red,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
                  
//                 ],
                
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   List<ProDetailsModel>products=[
//     ProDetailsModel(Image:"assets/fash.png", Name: "Choose Products", Description: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",),
//     ProDetailsModel(Image: "assets/fash1.png", Name: "Make Payment", Description: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."),
//     ProDetailsModel(Image: "assets/fash2.png", Name: "Get Your Order", Description: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."),
//   ];
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro2/Task/Intro_Page/controller/Intro_Controller.dart';
import 'package:pro2/Task/Intro_Page/model/IntroPageModel.dart';
import 'package:pro2/Task/LoginSection/Login_Page.dart';

class TaskBySir extends StatelessWidget {
  final controller = Get.put(IntroController());

  final List<ProDetailsModel> products = [
    ProDetailsModel(
      Image: "assets/fash.png",
      Name: "Choose Products",
      Description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    ),
    ProDetailsModel(
      Image: "assets/fash1.png",
      Name: "Make Payment",
      Description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    ),
    ProDetailsModel(
      Image: "assets/fash2.png",
      Name: "Get Your Order",
      Description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 16),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                           RichText(
                             text: TextSpan(
                               children: [
                                 TextSpan(
                                   text: '${controller.currentPage.value + 1}',
                                   style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black,
                                   ),
                                 ),
                                 TextSpan(
                                   text: '/',
                                   style: TextStyle(
                                     fontSize: 18,
                                     color: Colors.grey[600],
                                   ),
                                 ),
                                 TextSpan(
                                   text: '3',
                                   style: TextStyle(
                                     fontSize: 18,
                                     color: Colors.grey,
                                     fontFamily: 'assets/font/Montserrat-Regular.ttf',
                                   ),
                                 ),
                               ],
                             ),
                           ),
                      InkWell(
                        onTap: controller.skip,
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (value) {
                    controller.currentPage.value = value;
                  },
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return CustomSliderWidget(product: products[index]);
                  },
                ),
              ),
              Obx(() => Row(
                    children: [
                      if (controller.currentPage.value > 0)
                        InkWell(
                            onTap: controller.prevPage, child: Text("Prev")),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Container(
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xff17223B33)),
                                borderRadius: BorderRadius.circular(10),
                                color: controller.currentPage.value == index
                                    ? Colors.black
                                    : Color(0xff17223B33),
                              ),
                              height: 12,
                              width: controller.currentPage.value == index
                                  ? 30
                                  : 10,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: controller.nextPage,
                        child: Text(
                          controller.currentPage.value == 2
                              ? "Get Started"
                              : "Next",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliderWidget extends StatelessWidget {
    final ProDetailsModel product;
  const CustomSliderWidget({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(product.Image),
        Text(
          product.Name,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            // fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(product.Description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color.fromARGB(26, 33, 29, 29),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
    
  }
}
