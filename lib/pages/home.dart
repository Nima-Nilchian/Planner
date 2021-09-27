import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = Get.size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height * .5,
              decoration: BoxDecoration(
                color: Color(0xFF05ce91),
              ),
            ),
            Positioned(
              top: -30,
              left: 50,
              width: 250,
              height: 250,
              child: Image.asset("assets/images/time_management.png"),
            ),
            Positioned(
              top: 190,
              left: size.width/2 - 170,
              child: Text(
                """         “Before anything else
preparation is the key to success.”""",
                style: Theme.of(context)
                    .textTheme
                    .overline!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18.5),
              ),
            ),
            Padding(
              padding:EdgeInsets.only(top:size.height * .4, left: 10, right: 10),
              child: GridView.count(
                childAspectRatio: .95,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                children: [
                  CardCategory("notebook.jpg", "Notes", "/notes"),
                  CardCategory("todo.jpg", "To Do", "/todo"),
                  CardCategory("calendar.jpg", "Calendar", "/calendar"),
                  CardCategory("namaste.jpg", "Gratitude", "/gratitude"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}