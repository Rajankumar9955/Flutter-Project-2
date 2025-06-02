import 'package:flutter/material.dart';
import 'package:pro2/Task/Category/CategoryProducts/Category_products.dart';
import 'package:pro2/Task/Category/Controller/Categories_controller.dart';
import 'package:pro2/Task/Category/Model/Cotegories_Model.dart';
import 'package:pro2/Task/Home_/DealOfTheDay/DealOfTheDay_page.dart';
import 'package:pro2/Task/Home_/Home_content/Controller/HomeContent.dart';
import 'package:pro2/Task/Home_/ProductSliders/HomeProductSlider_page.dart';
import 'package:pro2/Task/Models/Categories.dart';
import 'package:pro2/Task/Models/PromoBanner_Model.dart';
import 'package:get/get.dart';
import 'package:pro2/core/constants/api_network.dart';

class HomeContent_page extends StatefulWidget {
  const HomeContent_page({super.key});

  @override
  State<HomeContent_page> createState() => _HomeContent_pageState();
}

class _HomeContent_pageState extends State<HomeContent_page> {
 
final HomeContentController homeContentController = Get.put(HomeContentController());
final CategoriesController _categoriesController= Get.put(CategoriesController());

  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                                   
                          decoration: InputDecoration(
                            hintText: "Search any Product..",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.mic, color: Colors.grey),
                    ],
                  ),
                ),
                SizedBox(height: 20),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Featured",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
            
                    Row(
                      children: [
                        _actionButton("Sort", Icons.swap_vert),
                        SizedBox(width: 10),
                        _actionButton("Filter", Icons.filter_alt),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),

               Obx(
                 () {
                   return _categoriesController.isLoading.value? Center(child: CircularProgressIndicator()) : SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                 List.generate(_categoriesController.Categories.length, (index) {
                                  CategoriesModel category = _categoriesController.Categories[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              ApiNetwork.imgUrl+category.categoryImage!
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                 Get.to(CategoryProducts(ID:category.id!));
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            category.categoryName.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } ,)
                            ),
                          ),
                        );
                 }
               ),

               
                //promoBanner
                SizedBox(
                height: 189,
                child: PageView.builder(
                  onPageChanged: (val) {
                    homeContentController.currentPage(val);
                  },
                  itemBuilder: (context, index) => promoBanner(),
                  itemCount: 3,
                ),
              ),
              
              SizedBox(height: 9),
              
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    height: 11,
                    width: 11,
                    margin: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDEDBDB)),
                      borderRadius: BorderRadius.circular(10),
                      color: homeContentController.currentPage.value == index
                          ? const Color(0xFFFFA3B3)
                          : const Color(0xFFDEDBDB),
                    ),
                  ),
                ),
              )),

                SizedBox(height: 9),
                dealOfTheDayCard(context),
                SizedBox(height: 20),
                ProductSlider(),
                SizedBox(height: 13,),
                SpecialOfferCard(),
                SizedBox(height: 13,),
                FlatAndHeelsCard(),
                SizedBox(height: 18,),
                trendingProducts(context),
                SizedBox(height: 12,),
                ProductSlider(),
                SizedBox(height: 12,),
                SummerSaleHome(),
                SizedBox(height:22),
                ShoeAdCard(),

              ],
            ),
          ),
            
        )
      ),
    );
  }
}

Widget _actionButton(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(width: 4),
        Icon(icon, size: 18),
      ],
    ),
  );
}


class Category {
  final String name;
  final String imagePath;
  Category(this.name, this.imagePath);
}
class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(category.imagePath),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

Widget promoBanner() {
  return Container(
    width: double.infinity,
    height: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(
        image: AssetImage("assets/ProBanner1.png"), // image
        fit: BoxFit.cover,
      ),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "50-40% OFF",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Now in (product)",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        Text(
          "All colours",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Shop Now", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget dealOfTheDayCard(BuildContext context) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: 1),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Color(0xFF3B88FD),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Deal of the Day",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "22h 55m 20s remaining",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.white),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>DealOfTheDayProducts()));
          },
          child: Row(
            children: [
              Text("View all"),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ],
    ),
  );
}








// Special Offers

class SpecialOfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 208, 222, 248)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/offer.png',
            width: 60,
            height: 60,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Special Offers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text('😱'),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'We make sure you get the\noffer you need at best prices',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}




class FlatAndHeelsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(24),
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset('assets/Group 33732 (1).png'),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orangeAccent, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              // Shoe image
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 30),
                child: Image.asset(
                  'assets/sandle.png',
                  height: 108,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          // Text and Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flat and Heels',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Stand a chance to get rewarded',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // Button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Visit now'),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget trendingProducts(BuildContext context) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: 1),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Color(0xFFFD6E87),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trending Products",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_month_outlined, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Last Day 29/02/22",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.white),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>DealOfTheDayProducts()));
          },
          child: Row(
            children: [
              Text("View all"),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ],
    ),
  );
}



class SummerSaleHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:

 Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/SummerSale.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "New Arrivals",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Text(
                      "Summer’ 25 Collections",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF3366),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          'View all',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}




class ShoeAdCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sponserd',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        'assets/sponserd.png',
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            'UP TO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            '50% OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 2,
                            width: 80,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'up to 50% Off',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          print("Tapped Sponsored Button");
                        },
                        child: Container(
                          child: Icon(Icons.arrow_forward_ios, size: 16,),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}