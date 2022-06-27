// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_taskmanagement/Login.dart';
import 'package:my_taskmanagement/data_provider.dart';
import 'main.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
  
}

class _SignUpState extends State<SignUp> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _obscureText = true;

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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width*0.6,
              child: Center(
                child: Container(
                  // color: Colors.red,
                  // height: MediaQuery.of(context).size.height*0.5,
                  height: 450,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: Column(
                    children: [
                      Text("HELLO!" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.all(8)),

                      Text("Crate account" , style: TextStyle(fontWeight: FontWeight.bold)),
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
                                  child: Icon(Icons.email , color: Color.fromARGB(255, 44, 148, 161,)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.2,
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration.collapsed(
                                      hintText: "E-mail",
                                      
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
                          child: Text("Sign up"),
                          color: const Color.fromARGB(255, 57, 226, 248),
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ),
                          onPressed: (){
                            DataProvider.createAccount(usernameController.value.text, passwordController.value.text, emailController.value.text).then((value) {
                              print(value["msg"]);
                              if(value["msg"] == "This username already exists"){
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
                              if (value["msg"] == "This email already exists"){
                                showDialog(context: context,
                                 builder: (BuildContext context) {
                                   return AlertDialog(
                                     backgroundColor: Colors.lightBlue[50],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                      content: Text("This email already exists" , style: TextStyle(color: Colors.red),),
                                   );
                                 });
                              }
                              if (value["msg"] == "Fill all the filds"){
                                showDialog(context: context,
                                 builder: (BuildContext context) {
                                   return AlertDialog(
                                     backgroundColor: Colors.lightBlue[50],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                      content: Text("Fill all the filds" , style: TextStyle(color: Colors.red),),
                                   );
                                 });
                              }
                              else if (value["msg"] == "newperson added to database") {
                                var pk = value["pk"] ;
                                Navigator.push(context,  MaterialPageRoute(builder: (context)=> SidebarPage(pk: pk)));
                              }
                            });
                          },

                          ),
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          InkWell(
                            onTap: (() {
                              Navigator.push(context,  MaterialPageRoute(builder: (context)=> const Login()));
                            }),
                            child: Text("Login" , style: TextStyle(fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 44, 148, 161,)),),
                          )
                        ],
                      )
                
                    ],
                  ),
                ),
              ),
            ),
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
                      child: Image.asset("assets/project-manager-inlea-scaled.jpg",fit: BoxFit.cover,)),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width*0.2,
                      child: Text("Don't be fooled by the calendar. There are only as many days in the year as you make use of. One man gets only a week's value out of a year while another man gets a full year's value out of a week. -- Charles Richards" ,
                                  style: TextStyle(fontWeight: FontWeight.bold ),))
                  ],
                ) ),
            )
          ],
        ),
      )
    );
  }
}