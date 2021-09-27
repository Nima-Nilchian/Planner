import 'package:daily_excersises/controller/gratitude_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Gratitude extends StatelessWidget {
  var size = Get.size;

  static final text1 = TextEditingController();
  static final text2 = TextEditingController();
  static final text3 = TextEditingController();

  final gratitudeController = Get.put(GratitudeController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text("Gratitude")),),
        backgroundColor: Color.fromARGB(255, 197, 224, 243),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .33,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.fill,
                    )),
                  ),
                  Positioned(
                    top: 35,
                    child: Image.asset(
                      "assets/images/gratitude.png",
                      width: size.width,
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 10,
                    child: Text(
                      """     Write down 3 things 
    you are grateful today""",
                      style: TextStyle(
                        wordSpacing: 4,
                        color: Colors.black,
                        fontSize: 25,
                        backgroundColor: Color(100),
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.blue,
                            blurRadius: 10.0,
                            offset: Offset(5.0, 5.0),
                          ),
                          Shadow(
                            color: Colors.green,
                            blurRadius: 10.0,
                            offset: Offset(-5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextFieldWidget(text1, Colors.black),
              TextFieldWidget(text2, Colors.purple),
              TextFieldWidget(text3, Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {

  const TextFieldWidget(this.text1, this.boxColor);

  final TextEditingController text1;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {

    // text1.text = dd;

    return Container(
      padding: EdgeInsets.only(left: 15, top: 15),
      margin:
          EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: boxColor,
              blurRadius: 7,
              spreadRadius: 3,
            ),
          ]),
      child: TextField(
        onEditingComplete: () {
          // dd = text1.text;
        },
        controller: text1,
        maxLines: 5,
        style: TextStyle(fontStyle: FontStyle.italic),
        decoration: InputDecoration.collapsed(
            hintText: "I'm Grateful For..."),
      ),
    );
  }
}
