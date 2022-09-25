import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class quiz1 extends StatefulWidget {
  const quiz1({Key? key}) : super(key: key);

  @override
  State<quiz1> createState() => _quiz1State();
}
var responseBody;
var search;

var nameController=TextEditingController();
bool loading = true;
class _quiz1State extends State<quiz1> {
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Find Universities'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.08,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),

                      child: TextField(

                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter a search term',
                          errorText: _errorText(nameController.text.toString())
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Search'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {


                       nameController.text.isEmpty?null:  getuni(nameController.text.toString().trim());




                    },
                  ),
                ],
              ),
            ),
            responseBody==null ?const Text("No Data",style: TextStyle(
              color: Colors.white,
            ),):Expanded(
        child: ListView.builder(
            itemCount: responseBody.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(4),
                height: MediaQuery.of(context).size.height*0.14,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
               child: Row(
                 children: [

                   SizedBox(width: 20,),
                   Container(

                     margin: EdgeInsets.only(left: 10),

                     decoration: BoxDecoration(
                         color: Colors.blue,
                         borderRadius: BorderRadius.circular(30)
                     ),
                     height: 50,
                     width: 50,

                     child: Align(
                         alignment: Alignment.center,
                         child: Text(responseBody[index]['alpha_two_code'].toString(),style: TextStyle(
                           color: Colors.white,
                         ),)),
                   ),
                   SizedBox(width: 20,),
                   Expanded(
                     child: Column(
                       mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(responseBody[index]['name'].toString(),style: TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.w600
                         ),),
                         Row(
                           children: [
                             Spacer(),
                             Container(
                               decoration: BoxDecoration(
                                 border: Border.all(
                                   color: Colors.black,
                                 ),
                                 borderRadius: BorderRadius.circular(15.0),
                               ),
                               child: Center(
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                   child: Text(responseBody[index]['state-province'].toString()),
                                 ),
                               ),
                             ),
                           ],
                         )
                       ],
                     ),
                   ),
                   SizedBox(width: 20,),
                 ],
               ),
              );
            }),
      ),

          ],
        ),
      ),
    );
  }
  String?  _errorText(String text) {
    // at any time, we can get the text from _controller.value.text

    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text=="") {
      return 'Can\'t be empty';
    }

    // return null if the text is valid
    return null;
  }
  bool loading = true;


  getuni(String search) async {
    setState(() {
      loading = true;
    });
    print('api calling...............');
    var api =
        "http://universities.hipolabs.com/search?country=$search";
    var response = await http.get(
      Uri.parse(api),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        responseBody = jsonDecode(response.body);
        debugPrint('$responseBody');

      });

      debugPrint('data:  $responseBody');

    } else {
      print("Server error please try again later");
    }
    setState(() {
      loading = false;
    });
    print('Api ok....');
  }
}
