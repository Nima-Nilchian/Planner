import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCategory extends StatelessWidget {
  String pic;
  String title;

  String pressed;

  CardCategory(this.pic, this.title, this.pressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(1, 5),
                spreadRadius: 1),
          ]
      ),
      child: InkWell(
        onTap: () => Get.toNamed(pressed),
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              "assets/images/$pic",
              height: 140,
            ),
            Spacer(),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
