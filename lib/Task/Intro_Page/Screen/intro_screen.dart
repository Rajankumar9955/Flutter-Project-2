import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/Task/Intro_Page/Bloc/pageSlider_bloc.dart';
import 'package:pro2/Task/Intro_Page/Bloc/pageSlider_state.dart';
import 'package:pro2/Task/Intro_Page/Bloc/pageslider_event.dart';
import 'package:pro2/Task/Intro_Page/Model/model.dart';
import 'package:pro2/Task/User_Auth/User_Login/user_login.dart';

class TaskBySir extends StatefulWidget {
  @override
  State<TaskBySir> createState() => _TaskBySirState();
}

class _TaskBySirState extends State<TaskBySir> {
  final PageController _pageController = PageController();

  final PageSliderBloc _pageSliderBloc = PageSliderBloc(totalIndex: 3);

  final List<IntroPageModel> products = [
    IntroPageModel(
      Image: "assets/fash.png",
      Name: "Choose Products",
      Description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    ),
    IntroPageModel(
      Image: "assets/fash1.png",
      Name: "Make Payment",
      Description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    ),
    IntroPageModel(
      Image: "assets/fash2.png",
      Name: "Get Your Order",
      Description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageSliderBloc(totalIndex: products.length),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<PageSliderBloc, PageSliderState>(
              bloc: _pageSliderBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${state.currentPage + 1}/${products.length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged:
                            (index) =>
                                _pageSliderBloc.add(PageChangedEvent(index)),
                        itemCount: products.length,
                        itemBuilder:
                            (context, index) =>
                                CustomSliderWidget(product: products[index]),
                      ),
                    ),
                    Row(
                      children: [
                        if (state.currentPage > 0)
                          InkWell(
                            onTap: () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                              _pageSliderBloc.add(PrevPageEvent());
                            },
                            child: Text("Prev"),
                          ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              products.length,
                              (index) => Container(
                                margin: EdgeInsets.only(left: 5),
                                height: 12,
                                width: state.currentPage == index ? 30 : 10,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff17223B33),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      state.currentPage == index
                                          ? Colors.black
                                          : Color(0xff17223B33),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("currentIndex ${state.currentPage}");
                            if (state.currentPage == products.length - 1) {
                              // Navigate to next screen
                            } else {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                              _pageSliderBloc.add(NextPageEvent());
                            }
                          },
                          child: Text(
                            state.currentPage == products.length - 1
                                ? "Get Started"
                                : "Next",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSliderWidget extends StatelessWidget {
  final IntroPageModel product;
  const CustomSliderWidget({super.key, required this.product});

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
        Text(
          product.Description,
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