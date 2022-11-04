import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

final screenHeight = Get.height;
final screenWidth = Get.width;
final nos = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.'];

isnum(String n) {
  if (nos.contains(n)) {
    return true;
  }
  return false;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// final double width = MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//Button
  myButton(String number, double sizee) {
    return SizedBox(
      height: screenHeight / 11,
      width: screenWidth / 4,
      child: MaterialButton(
        onPressed: () {
          buttonPressed(number);
        },
        child: Text(
          number,
          style: GoogleFonts.quicksand(
              fontSize: sizee,
              color: (isnum(number) ? Colors.white : Colors.orange)),
        ),
      ),
    );
  }

  String output = "0";
  double num1 = 0;
  double num2 = 0;
  double total = 0;
  int num1size = 0;
  String ans = "";
  String operand = "";

  buttonPressed(String num) {
    if (num == "AC") {
      output = "0";
      num1 = 0;
      num2 = 0;
      total = 0;
    }
    //Operators
    else if (num == '+' ||
        num == '-' ||
        num == 'X' ||
        num == '/' ||
        num == '%') {
      num1 = double.parse(output);
      num1size = output.length;
      output = output + num;
      operand = num;
      num2 = 0;
    }
    //clear
    else if (num == '<-') {
      if (output.length > 1) {
        output = output.substring(0, output.length - 1);
      } else if (output.length == 1) {
        output = "0";
      }
    }
    //equals to
    else if (num == '=') {
      if (output != '0') {
        num2 = double.parse(output.substring(num1size + 1, output.length));
        if (operand == '+') {
          total = num1 + num2;
        } else if (operand == '-') {
          total = num1 - num2;
        } else if (operand == 'X') {
          total = num1 * num2;
        } else if (operand == '/') {
          total = num1 / num2;
        } else if (operand == '%') {
          total = num1 % num2;
        }

        output = total.toString();
        if (output.substring(
              output.length - 2,
            ) ==
            ".0") {
          output = output.substring(0, output.length - 2);
          total = double.parse(output);
        }
      }
    }
    //last else
    else {
      if (output == '0') {
        output = num;
      } else {
        output = output + num;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: Text("")),
            //output
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              //output
              child: Text(
                output,
                style: GoogleFonts.quicksand(fontSize: 45),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              //output
              child: Text(
                "= $total",
                style: GoogleFonts.quicksand(fontSize: 35),
              ),
            ),
            //Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Divider(),
                Row(
                  children: [
                    myButton("AC", 24),
                    myButton("<-", 24),
                    myButton("%", 24),
                    myButton("/", 24),
                  ],
                ),
                Row(
                  children: [
                    myButton("7", 30),
                    myButton("8", 30),
                    myButton("9", 30),
                    myButton("X", 24),
                  ],
                ),
                Row(
                  children: [
                    myButton("4", 30),
                    myButton("5", 30),
                    myButton("6", 30),
                    myButton("-", 24),
                  ],
                ),
                Row(
                  children: [
                    myButton("1", 30),
                    myButton("2", 30),
                    myButton("3", 30),
                    myButton("+", 24),
                  ],
                ),
                Row(
                  children: [
                    myButton("x", 24),
                    myButton("0", 30),
                    myButton(".", 30),
                    myButton("=", 24),
                  ],
                ),
                const Gap(20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
