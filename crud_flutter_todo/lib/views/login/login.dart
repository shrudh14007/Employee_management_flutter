import 'package:crud_flutter_todo/views/home/home_page.dart';
import 'package:crud_flutter_todo/views/pages/AddDelEmployees.dart';
import 'package:crud_flutter_todo/views/widgets/BottomNavigationBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: Image.asset(
                    'Assets/Logos/icon.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          controller: emailController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Enter Email Address'),
                                
                            EmailValidator(
                                errorText:
                                    'Please correct email filled'),
                                    
                          ]).call,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            errorStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter Password'),
                            MinLengthValidator(
                              8,
                              errorText:
                                  'Password must be at least 8 characters',
                            ),
                            PatternValidator(
                              r'(?=.*?[#!@$%^&*-])',
                              errorText:
                                  'Psw must have at least one special character',
                            )
                          ]).call,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.blueAccent,
                            ),
                            errorStyle:
                                TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                          ),
                        ),

                        
                      ),
                      Container(margin: EdgeInsets.fromLTRB(200,0, 0, 0),
                        child: Text('Forget Password'),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(28),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed:() async{
                            if(_formkey.currentState!.validate()){
                              await login();
                            }
                           },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white
                          ),
                            child: Text('Login',
                            style: TextStyle(
                            color: Colors.white,fontSize: 22
                           ),
                            ),
                           ),


                        ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top: 50),
                            child: Text(
                              'Sign Up' ,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.lightBlueAccent

                              ),
                            ),
                            
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void>login() async{
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/login'),
      headers: {
        'Content-Type':'application/Json',
      },
      body: jsonEncode({
        'email':emailController.text,
        'password':passwordController.text
      }),
    );
    if(response.statusCode==200){
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context)=> const BottomNavigationPage()));
    }
    else{
      print('login failed');
    }


  }
}