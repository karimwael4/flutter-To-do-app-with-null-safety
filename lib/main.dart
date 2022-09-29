import 'package:flutter/material.dart';
import 'package:todoapp/shared/constants/constants.dart';
import 'layout/todoapp/todo_layout.dart';


void main()
{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      theme: ThemeData(
        primarySwatch:Colors.teal,
        dividerColor:firstColor ,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showSelectedLabels: true,
            selectedLabelStyle: TextStyle(
                decorationColor: firstColor,
              color: firstColor
                          ),
          selectedIconTheme: IconThemeData(
            color: firstColor
          )
        ),
        appBarTheme: const AppBarTheme(
          color: firstColor
        ),
       floatingActionButtonTheme:const  FloatingActionButtonThemeData(
         foregroundColor:Colors.white,
         backgroundColor:firstColor
       ),
        primaryColor: Colors.red,


      ),
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}

