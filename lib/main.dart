import 'package:daily_excersises/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'pages/home.dart';
import 'pages/gratitude.dart';
import 'pages/notes.dart';
import 'pages/todo.dart';
import 'pages/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TimeManagementScreen(),
      getPages: [
        GetPage(name: "/", page: () => HomePage(),transition: Transition.fadeIn),
        GetPage(name: "/notes", page: () => NotesView(),transition: Transition.fadeIn),
        GetPage(name: "/gratitude", page: () => Gratitude(),transition: Transition.fadeIn),
        GetPage(name: "/todo", page: () => TodoView(),transition: Transition.fadeIn),
        GetPage(name: "/calendar", page: () => Calendar(),transition: Transition.fadeIn),
      ],
    );
  }
}

