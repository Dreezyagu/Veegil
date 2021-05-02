import 'dart:convert';
import 'dart:ui';
import 'package:Veegil/screens/homepage.dart';
import 'package:Veegil/utils/constants.dart';
import 'package:Veegil/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool switches = false;
  bool loading = false;

  bool visibility = false;
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * .08, vertical: height * .05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(fontSize: width * .06, color: primary),
            ),
            SizedBox(
              height: height * .05,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: number,
              enabled: !loading,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      borderRadius: BorderRadius.circular(width * .04))),
            ),
            SizedBox(
              height: height * .025,
            ),
            TextFormField(
              obscureText: !visibility,
              controller: password,
              enabled: !loading,
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Password",
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  fillColor: Colors.grey[100],
                  hintStyle: TextStyle(fontSize: width * .035),
                  suffixIcon: IconButton(
                    icon: Icon(
                      visibility ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * .04))),
            ),
            SizedBox(
              height: height * .01,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password",
                    style: TextStyle(color: third),
                  )),
            ),
            SizedBox(
              height: height * .01,
            ),
            Row(
              children: [
                Expanded(
                    flex: !switches ? 4 : 2,
                    child: InkWell(
                      onTap: () {
                        if (!loading) {
                          if (!switches) {
                            setState(() {
                              loading = true;
                            });
                            login();
                          } else {
                            setState(() {
                              switches = !switches;
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * .02),
                        decoration: BoxDecoration(
                            color: !switches ? primary : Colors.grey[100],
                            borderRadius: BorderRadius.circular(width * .02)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: !switches ? white : Colors.black38,
                                  fontSize: width * .045,
                                  fontWeight: FontWeight.w500),
                            ),
                            Visibility(
                              visible: !switches && !loading,
                              child: SizedBox(
                                width: width * .01,
                              ),
                            ),
                            Visibility(
                              visible: !switches && !loading,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: white,
                                size: width * .02,
                              ),
                            ),
                            Visibility(
                              visible: !switches && loading,
                              child: SizedBox(
                                width: width * .01,
                              ),
                            ),
                            Visibility(
                                visible: !switches && loading,
                                child: Container(
                                  height: width * .02,
                                  width: width * .02,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    backgroundColor: primary,
                                    valueColor: AlwaysStoppedAnimation(white),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  width: width * .02,
                ),
                Expanded(
                    flex: switches ? 4 : 2,
                    child: InkWell(
                      onTap: () {
                        if (!loading) {
                          if (switches) {
                            setState(() {
                              loading = true;
                            });
                            register();
                          } else {
                            setState(() {
                              switches = !switches;
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * .02),
                        decoration: BoxDecoration(
                            color: switches ? primary : Colors.grey[100],
                            borderRadius: BorderRadius.circular(width * .02)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "REGISTER",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: switches ? white : Colors.black38,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500),
                            ),
                            Visibility(
                              visible: switches && !loading,
                              child: SizedBox(
                                width: width * .01,
                              ),
                            ),
                            Visibility(
                              visible: switches && !loading,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: white,
                                size: width * .02,
                              ),
                            ),
                            Visibility(
                              visible: switches && loading,
                              child: SizedBox(
                                width: width * .02,
                              ),
                            ),
                            Visibility(
                                visible: switches && loading,
                                child: Container(
                                  height: width * .02,
                                  width: width * .02,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    backgroundColor: primary,
                                    valueColor: AlwaysStoppedAnimation(white),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    String url = "$baseUrl/auth/login";
    Map data = {"phoneNumber": number.text, "password": password.text};
    var response = await http.post(url, body: data);

    var body = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', body["data"]["token"]);

      String url2 = "$baseUrl/accounts/list";

      var response2 = await http.get(url2);
      var body2 = jsonDecode(response2.body);

      List bodies = body2["data"];
      var userData =
          bodies.indexWhere((element) => element["phoneNumber"] == number.text);
      context.read<Providers>().setMap(bodies[userData]);
      setState(() {
        loading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(number.text),
          ));
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: body["message"]);
    }
  }

  register() async {
    FocusScope.of(context).requestFocus(FocusNode());

    String url = "$baseUrl/auth/signup";

    Map data = {"phoneNumber": number.text, "password": password.text};
    var response = await http.post(url, body: data);
    setState(() {
      loading = false;
    });

    if (response.statusCode == 409) {
      Fluttertoast.showToast(msg: "${jsonDecode(response.body)["message"]}");
      return;
    }
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "${jsonDecode(response.body)["message"]}");
      setState(() {
        switches = !switches;
      });
      number.clear();
      password.clear();
    } else {
      Fluttertoast.showToast(msg: "${jsonDecode(response.body)["message"]}");
    }
  }
}
