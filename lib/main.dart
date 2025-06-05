import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/Task/App_First_Screen/app_first_screen.dart';
import 'package:pro2/Task/Category/Bloc/category_bloc.dart';
import 'package:pro2/Task/Home/Bloc/product_bloc.dart';
import 'package:pro2/Task/User_Auth/Bloc/user_bloc.dart';
import 'package:pro2/Task/User_Auth/User_Login/user_login.dart';
import 'package:pro2/Task/Wishlist/Bloc/wishlist_bloc.dart';
import 'package:pro2/data/session_manager.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SessionManager().init();
  } catch (e, stack) {
    print('SessionManager.init() failed: $e\n$stack');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context)=>SignUpBloc()),
        BlocProvider(create: (context)=>ProductBloc()),
        BlocProvider(create: (context)=>WishProductBloc()),
        BlocProvider(create: (context)=>CategoryBloc()),
      ],
      child: GetMaterialApp(
        title: 'Stylish',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),

        // home:HomePage(),
        //  home: ProductPage(),
        home: SessionManager.getToken() != null ? AppFirstScreen() : LoginPage(),

        // home: TaskBySir(),
        // home: ProdctScreen(),   //GetX state management
        // :NavbarSlider(),
      ),
    );
  }
}
