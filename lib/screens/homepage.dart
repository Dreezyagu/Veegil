import 'dart:convert';
import 'dart:ui';
import 'package:Veegil/screens/homepage.dart';
import 'package:Veegil/screens/withdrawal.dart';
import 'package:Veegil/utils/constants.dart';
import 'package:Veegil/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'deposit.dart';

class Homepage extends StatelessWidget {
  final String number;
  Homepage(this.number);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var balance = context.watch<Providers>().userdata;

    void dropdown1() {
      showDialog(
        context: context,
        builder: (context) => Deposit(),
      );
    }

    void dropdown2() {
      showDialog(
        context: context,
        builder: (context) => Withdrawal(),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: primary,
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .04, vertical: height * .02),
                        color: primary,
                        height: height * .25,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: width * .07,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Icon(Icons.add_a_photo)),
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Text("Welcome, ${balance["phoneNumber"]}",
                                style: TextStyle(
                                  fontSize: width * .06,
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        color: white,
                        height: height * .4,
                        width: double.infinity,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .04),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * .1,
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "What do you want to do today?",
                                    style: TextStyle(
                                        color: primary, fontSize: width * .04),
                                  )),
                              SizedBox(
                                height: height * .02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        dropdown1();
                                      },
                                      child: Container(
                                        height: height * .2,
                                        padding: EdgeInsets.all(width * .04),
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFEAE9),
                                            borderRadius: BorderRadius.circular(
                                                width * .02)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: CircleAvatar(
                                                backgroundColor: white,
                                                radius: width * .07,
                                                child: Image.asset(
                                                  'assets/donation.png',
                                                  height: width * .1,
                                                  color: Color(0xffFFEAE9),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Deposit",
                                              style: TextStyle(
                                                  fontSize: width * .05,
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .05,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        dropdown2();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(width * .02),
                                        decoration: BoxDecoration(
                                            color: Color(0xffEDE4FF),
                                            borderRadius: BorderRadius.circular(
                                                width * .02)),
                                        height: height * .2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: CircleAvatar(
                                                backgroundColor: white,
                                                radius: width * .07,
                                                child: Image.asset(
                                                  'assets/transfer.png',
                                                  height: width * .1,
                                                  color: Color(0xffEDE4FF),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Send Money",
                                              style: TextStyle(
                                                  fontSize: width * .05,
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: height * .175,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * .02),
                      width: width,
                      height: height * .15,
                      child: Card(
                        elevation: 15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              "Your Balance".toUpperCase(),
                              style: TextStyle(
                                  fontSize: width * .07,
                                  color: accent,
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              height: height * .01,
                            ),
                            Center(
                                child: Text(
                              "ngn${balance["balance"] ?? 0}".toUpperCase(),
                              style: TextStyle(
                                  fontSize: width * .06,
                                  color: accent,
                                  fontWeight: FontWeight.w500),
                            )),
                            SizedBox(
                              height: height * .02,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * .04),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Activity".toUpperCase(),
                        style: TextStyle(
                            fontSize: width * .05, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
