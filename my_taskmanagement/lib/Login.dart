// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_taskmanagement/Signup.dart';
import 'package:my_taskmanagement/data_provider.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool _obscureText = true;

  // String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              color: Color.fromARGB(255, 57, 226, 248),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width*0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: Image.asset("assets/projectManagement.png",fit: BoxFit.cover,)),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width*0.2,
                      child: Text("Tip : Dont forget to add your friends to boards!" , style: TextStyle(fontWeight:FontWeight.bold,)))
                  ],
                ) ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width*0.6,
              child: Center(
                child: Container(
                  // color: Colors.red,
                  height: MediaQuery.of(context).size.height*0.5,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: Column(
                    children: [
                      Text("HELLO!" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.all(8)),

                      Text("sign into your account" , style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(padding: EdgeInsets.all(8)),

                      // Container(
                      //   height: 60,
                      //   width: MediaQuery.of(context).size.width*0.35,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(30),
                      //     boxShadow:[ BoxShadow( 
                      //       color: Color.fromARGB(255, 57, 226, 248),
                      //       spreadRadius: 1,
                      //       blurRadius: 7,
                      //       // offset: Offset(0, 3), 
                      //       )
                      //       ]
                      //   ),
                        
                      //       child :Row(
                      //         children: [
                      //           // Padding(
                      //           //   padding: const EdgeInsets.only(left :15.0 , right: 8),
                      //           //   child: Icon(Icons.email , color: Color.fromARGB(255, 44, 148, 161,)),
                      //           // ),
                      //           // Container(
                      //           //   width: MediaQuery.of(context).size.width*0.2,
                      //           //   child: TextField(
                      //           //     decoration: InputDecoration.collapsed(
                      //           //       hintText: "E-mail",
                                      
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //         ],
                      //       )
                         
                      // ),
                      Padding(padding: EdgeInsets.all(8)),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width*0.35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow:[ BoxShadow( 
                            color: Color.fromARGB(255, 57, 226, 248),
                            spreadRadius: 1,
                            blurRadius: 7,
                            // offset: Offset(0, 3), 
                            )
                            ]
                        ),
                        child :Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left :15.0 , right: 8),
                                  child: Icon(Icons.person , color: Color.fromARGB(255, 44, 148, 161,)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.2,
                                  child: TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Username",
                                      
                                    ),
                                  ),
                                ),
                              ],
                            )
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width*0.35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow:[ BoxShadow( 
                            color: Color.fromARGB(255, 57, 226, 248),
                            spreadRadius: 1,
                            blurRadius: 7,
                            // offset: Offset(0, 3), 
                            )
                            ]
                        ),
                        child :Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left :15.0 , right: 8),
                                  child: Icon(Icons.lock , color: Color.fromARGB(255, 44, 148, 161,)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.2,
                                  child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Password",
                                      
                                    ),
                                    obscureText: _obscureText,
                                  ),
                                ),
                                FlatButton(
                                  onPressed: _toggle,
                                  child:  Text(_obscureText ? "Show" : "Hide" , style: TextStyle(color: const Color.fromARGB(255, 57, 226, 248) ),))
                              ],
                            )
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      Container(
                        width: MediaQuery.of(context).size.width*0.1,
                        child: RaisedButton(
                          child: Text("Login"),
                          color: const Color.fromARGB(255, 57, 226, 248),
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ),
                          onPressed: (){
                            // var msg = DataProvider.login(usernameController.value.text, passwordController.value.text);
                            // print("this is my msg");
                            // print(msg);
                            // FutureBuilder(
                            //   future: DataProvider.login(usernameController.value.text, passwordController.value.text),
                            //   builder: (BuildContext context, AsyncSnapshot snapshot){
                            //     print("in builder");
                            //     if (snapshot.hasData) {
                            //       print("this is snapshot");
                            //       print(snapshot);

                            //     }
                            //     if (snapshot.hasError) {
                            //       print("snapshot has error");
                            //     }
                            //     return  Text("loading ...");
                            //   });

                            DataProvider.login(usernameController.value.text, passwordController.value.text).then((value) {
                              if(value["msg"] == "fill all the fields"){
                                showDialog(context: context,
                                 builder: (BuildContext context) {
                                   return AlertDialog(
                                     backgroundColor: Colors.lightBlue[50],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                      content: Text("This username already exists" , style: TextStyle(color: Colors.red),),
                                   );
                                 });
                              }
                              if(value["msg"] == "wrong username"){
                                showDialog(context: context,
                                 builder: (BuildContext context) {
                                   return AlertDialog(
                                     backgroundColor: Colors.lightBlue[50],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                      content: Text("wrong username" , style: TextStyle(color: Colors.red),),
                                   );
                                 });
                              }
                              if(value["msg"] == "Wrong password"){
                                showDialog(context: context,
                                 builder: (BuildContext context) {
                                   return AlertDialog(
                                     backgroundColor: Colors.lightBlue[50],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                      content: Text("Wrong password" , style: TextStyle(color: Colors.red),),
                                   );
                                 });
                              }
                              if(value["msg"] == "successful"){
                                Navigator.push(context,  MaterialPageRoute(builder: (context)=> SidebarPage(pk : value["pk"])));
                              }
                            });
                          },

                          ),
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          InkWell(
                            onTap: (() {
                              Navigator.push(context,  MaterialPageRoute(builder: (context)=> const SignUp()));
                            }),
                            child: Text("Create" , style: TextStyle(fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 44, 148, 161,)),),
                          )
                        ],
                      )
                
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      )
    );
  }
}