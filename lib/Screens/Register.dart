import 'package:flutter_auth/Screens/Login.dart';
import 'package:flutter/gestures.dart';
import '../Constant/const.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/responsive.dart';
import '../../components/background.dart';
import '../Screens/Signup/components/sign_up_top_image.dart';
import '../Screens/Signup/components/signup_form.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Ganti Base URL

  String baseurl =
      "http://localhost/vigenesia/"; // ganti dengan ip address kamu / tempat kamu menyimpan backend

  Future postRegister(
      String nama, String profesi, String email, String password) async {
    var dio = Dio();

    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password
    };

    try {
      final response = await dio.post("$baseurl/api/registrasi/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: 
                    SignUpScreenTopImage(),
                    ),
                  // Text(
                  //   "Register Your Account",
                  //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  // ),
                  SizedBox(height: defaultPadding),
                  FormBuilderTextField(
                  name: 'nama',
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Nama",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                  // FormBuilderTextField(
                  //   name: "name",
                  //   controller: nameController,
                  //   decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(left: 10),
                  //       border: OutlineInputBorder(),
                  //       labelText: "Nama"),
                  // ),
                  FormBuilderTextField(
                  name: 'profesi',
                  controller: profesiController,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Profesi",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.work),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                  FormBuilderTextField(
                  name: 'email',
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.email),
                    ),
                  ),
                ),
                  // FormBuilderTextField(
                  //   name: "email",
                  //   controller: emailController,
                  //   decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(left: 10),
                  //       border: OutlineInputBorder(),
                  //       labelText: "Email"),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                    obscureText: true,
                  name: 'password',
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
                  // FormBuilderTextField(
                  //   obscureText:
                  //       true, // <-- Buat bikin setiap inputan jadi bintang " * "
                  //   name: "password",
                  //   controller: passwordController,

                  //   decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(left: 10),
                  //       border: OutlineInputBorder(),
                  //       labelText: "Password"),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          await postRegister(
                                  nameController.text,
                                  profesiController.text,
                                  emailController.text,
                                  passwordController.text)
                              .then((value) => {
                                    if (value != null)
                                      {
                                        setState(() {
                                          Navigator.pop(context);
                                          Flushbar(
                                            message: "Berhasil Registrasi",
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.greenAccent,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                        })
                                      }
                                    else if (value == null)
                                      {
                                        Flushbar(
                                          message:
                                              "Check Your Field Before Register",
                                          duration: Duration(seconds: 5),
                                          backgroundColor: Colors.redAccent,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        ).show(context)
                                      }
                                  });
                        },
                        child:
                        Text("Sign Up"),
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Already Have an Account ?',
                        style: TextStyle(color: Colors.purple)),
                      
                      TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                        ..onTap=() {
                          Navigator.push(context, 
                          new MaterialPageRoute(builder: (BuildContext context)=>
                          new Login()));
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54
                        )
                        )
                ])
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ElevatedButton(
                  //       onPressed: ()  {Navigator.push(context,
                  //         MaterialPageRoute(
                  //           builder: (context) {
                  //             return Login();
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     child: Text("Sign In"),
                  //   )
                  //   )
              )],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
