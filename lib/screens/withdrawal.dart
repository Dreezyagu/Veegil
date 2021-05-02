import 'dart:convert';

import 'package:Veegil/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class Withdrawal extends StatefulWidget {
  @override
  _WithdrawalState createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  bool loading = false;
  final key = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      elevation: 5,
      title: Text("Send Money"),
      content: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide value';
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Account number",
                            hintStyle: TextStyle(fontSize: width * .035),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .04))),
                      ),
                      SizedBox(
                        height: height * .015,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: amount,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide value';
                          } else
                            return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Amount",
                            hintStyle: TextStyle(fontSize: width * .035),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .04))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                RaisedButton(
                  color: primary,
                  onPressed: () {
                    if (key.currentState.validate()) {
                      if (!loading) {
                        setState(() {
                          loading = true;
                        });
                        withdrawwal();
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: white,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500),
                      ),
                      Visibility(
                        visible: loading,
                        child: SizedBox(
                          width: width * .02,
                        ),
                      ),
                      Visibility(
                          visible: loading,
                          child: Container(
                            height: width * .03,
                            width: width * .03,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              backgroundColor: primary,
                              valueColor: AlwaysStoppedAnimation(white),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  withdrawwal() async {
    FocusScope.of(context).requestFocus(FocusNode());

    String url = "$baseUrl/accounts/withdraw";
    Map data = {"phoneNumber": number.text, "password": amount.text};

    var response = await http.post(url, body: data);
    print(response.body);
    print(response.statusCode);
    setState(() {
      loading = false;
    });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "${jsonDecode(response.body)["message"]}");
    } else {
      Fluttertoast.showToast(msg: "${jsonDecode(response.body)["message"]}");
    }
  }
}
