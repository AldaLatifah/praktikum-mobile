import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemo_auth/auth_service.dart';
import 'package:pemo_auth/login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff8E9BDE), Color(0xff5365D0)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Create your account ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Color(0xff5265ce),
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff969697)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5265ce)),
                        ),
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Color(0xff5265ce),
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff969697)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5265ce)),
                        ),
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5265ce)),
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: RaisedButton(
                    onPressed: () async {
                      if (emailController.text == '' ||
                          passwordController.text == '') {
                        Get.snackbar(
                          "",
                          "",
                          backgroundColor: Colors.red,
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          titleText: Text(
                            "Register Failed",
                          ),
                          messageText: Text(
                            "Please Fill All Field In Form",
                          ),
                        );
                      } else {
                        SignInSignUpResult? result =
                            await AuthService.registerUsingEmailPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        if (result?.user != null) {
                          Get.offAll(LoginPage());
                          Get.snackbar(
                            "",
                            "",
                            backgroundColor: Colors.blueAccent,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            titleText: const Text(
                              "Register Success",
                            ),
                            messageText: const Text(
                              'Welcome Back!',
                            ),
                          );
                        } else {
                          Get.snackbar(
                            "",
                            "",
                            backgroundColor: Colors.red,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            titleText: const Text("Register Failed"),
                            messageText: Text(
                              result!.message.toString(),
                            ),
                          );
                        }
                      }
                      ;
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Color(0xff5265ce),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 60,
                        height: 1,
                        color: Color(0xff969697),
                      ),
                      const Text(
                        'or',
                        style: TextStyle(
                          color: Color(0xff969697),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 60,
                        height: 1,
                        color: Color(0xff969697),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: RaisedButton(
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Color(0xff969697),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
