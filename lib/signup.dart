import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212832),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            width: 60,
                            height: 60,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.yellow,
                                ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Create an \nAccount",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.w500,
                              fontSize: 36,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xff19202a),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                      color: Color(0xff9da8b5),
                                    ),
                                  ),
                                ),
                                Divider(height: 5, color: Color(0xff9da8b5)),

                                TextFormField(

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      color: Color(0xff9da8b5),
                                    ),
                                  ),
                                ),
                                Divider(height: 5, color: Color(0xff9da8b5)),

                                TextField(
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: "Phone",
                                    hintStyle: TextStyle(
                                      color: Color(0xff9da8b5),
                                    ),
                                  ),
                                ),
                                Divider(height: 5, color: Color(0xff9da8b5)),
                                TextField(
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Color(0xff9da8b5),
                                    ),
                                  ),
                                ),
                                Divider(height: 5, color: Color(0xff9da8b5)),
                                TextField(
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: "Password_confirmation",
                                    hintStyle: TextStyle(
                                      color: Color(0xff9da8b5),
                                    ),
                                  ),
                                ),
                                Divider(height: 5, color: Color(0xff9da8b5)),

                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: Colors.yellow,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
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
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text:  TextSpan(
                                        text: "By continuing you agree to \nTerms & Condition and Privacy Policy",
                                        style: TextStyle(
                                          color: Color(0xff9da8b5),

                                        ),
                                      ),
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

                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
