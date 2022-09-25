import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:login/signup.dart';
import 'package:lottie/lottie.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xff19202a),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Color(0xff9da8b5),
                            ),
                          ),
                          style: TextStyle(
                            color: Color(0xff9da8b5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 5, color: Color(0xff9da8b5)),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Color(0xff9da8b5),
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xff9da8b5),
                    ),
                  ),
                  Divider(height: 5, color: Color(0xff9da8b5)),
                  Row(
                    children: [
                      // Switch(
                      //   activeColor: Colors.yellow,
                      //   onChanged: toggleSwitch,
                      //   value: isSwitched,
                      // ),
                      Text(
                        "remember me",
                        style: TextStyle(
                          color: Color(0xff9da8b5),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "forgot password?",
                        style: TextStyle(
                          color: Color(0xff9da8b5),
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      login(emailController.text.toString(),
                          passwordController.text.toString());
                    },
                    child: loading
                        ? Container(
                      height: 20,

                      child: Lottie.asset('assets/images/loder.json'),
                    )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.yellow,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don\'t have an account?",
                            style: TextStyle(
                              color: Color(0xff9da8b5),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => signup()));
                            },
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(
                                color: Color(0xff9da8b5),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(String email, String password) async {
    try {
      setState(() {
        loading = true;
      });
      final resp = await http.post(
          Uri.parse("http://adeegmarket.zamindarestate.com/api/v1/login"),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          }));

      var resultBody = jsonDecode(resp.body);
      print('Body: $resultBody');

      var bodyStatus = resultBody['status'];
      print(bodyStatus);

      if (bodyStatus == 200) {
        print('Login Success');
      } else {
        print('Login Fail');
      }
      setState(() {
        loading = false;
      });

      print(resp.body);
    } catch (error) {
      setState(() {
        loading = false;
      });
      print('$error');
    }
  }
}
