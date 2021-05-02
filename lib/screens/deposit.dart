import 'dart:convert';

import 'package:Veegil/utils/constants.dart';
import 'package:Veegil/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
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
      title: Text("Deposit"),
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
                        deposit();
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

  deposit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    String url = "$baseUrl/accounts/transfer";
    Map data = {"phoneNumber": number.text, "password": amount.text};

    var response = await http
        .post(url, body: data, headers: {"Authorization": 'Bearer $token'});
    print(response.body);
    print(response.statusCode);
    setState(() {
      loading = false;
    });
    if (response.statusCode == 200) {
      String url2 = "$baseUrl/accounts/list";

      var response2 = await http.get(url2);
      var body2 = jsonDecode(response2.body);

      List bodies = body2["data"];
      var userData =
          bodies.indexWhere((element) => element["phoneNumber"] == number.text);
      print(bodies[userData]);

      context.read<Providers>().setMap(bodies[userData]);
      Fluttertoast.showToast(msg: "${jsonDecode(response.body)["message"]}");
    } else {
      Fluttertoast.showToast(msg: "${jsonDecode(response.body)["message"]}");
    }
  }
}
