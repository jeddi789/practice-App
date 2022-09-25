import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home:
        // Login()
        SplashScreen()
    );
  }
}



// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();

      var token = pref.getString('token');
      print("Token: $token");

      if (token == null || token == 'null'  ) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyHomePage(title: "title")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlutterLogo(),
      ),
    );
  }
}







//Login Screen
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  login() async {
    try {
      final responce = await http.post(
          Uri.parse('http://adeegmarket.zamindarestate.com/api/v1/login'),
          headers: {
            'Content-Type': "application/json",
          },
          body: jsonEncode(
              {'email': 'customer@example.com', 'password': '123456'}));

      print(responce.statusCode);

      if (responce.statusCode == 200) {
        print("Body: ${responce.body}");
        var data = jsonDecode(responce.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', data['token'].toString());
        log("Data Save");

        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyHomePage(title: "Home")));
      }
    } catch (e) {
      print("Catch Error________________");
      print(e.toString());
    }
  }

  saveData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text("Login Button")),
      ),
    );
  }
}









//Home Page
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<univeristyModel> universityList = [];
  bool loading = false;

  getData() async {
    setState(() {
      loading = true;
    });
    final responce = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=pakistan'));
    log(responce.statusCode.toString());
    if (responce.statusCode == 200) {
      List data = jsonDecode(responce.body).toList();

      for (int i = 0; i < data.length; i++) {
        univeristyModel uniModel = univeristyModel(
          countryName: data[i]['country'].toString(),
          countryCode: data[i]['alpha_two_code'].toString(),
          provinceName: data[i]['state-province'].toString(),
          universityName: data[i]['name'].toString(),
        );
        universityList.add(uniModel);
      }
      setState(() {
        loading = false;
      });
    }
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      var token = pref.getString('token');
      print("Token: $token");
      final responce = await http.post(
        Uri.parse('http://adeegmarket.zamindarestate.com/api/v1/logout'),
        headers: {
          'Content-Type': "application/json",
          'Authorization': "Bearer $token"
        },
      );

      print(responce.statusCode);
      print("Body: ${responce.body}");

      pref.setString('token', "null");
      Navigator.of(context).pushAndRemoveUntil((MaterialPageRoute(builder: (context) => Login())), (route) => false);
    } catch (e) {
      print("Catch Error________________");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              loading == true
                  ? Text("Loading...")
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: universityList.length,
                itemBuilder: (context, i) {
                  return Text(universityList[i].provinceName.toString());
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          logout();
          // getData();
        },
        tooltip: 'Increment',
        label: Text("Logout"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}














// Model
class univeristyModel {
  String countryCode = '';
  String countryName = '';
  String universityName = '';
  String provinceName = '';

  univeristyModel({
    required this.countryName,
    required this.countryCode,
    required this.provinceName,
    required this.universityName,
  });
}
