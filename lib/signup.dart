/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedia/home.dart';
import 'package:pokedia/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedia/firebaseServices/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  Signup createState() => Signup();
}

class Signup extends State<SignUpPage> {
  final formKey =GlobalKey<FormState>();

  final TextEditingController nameController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final authServices= AuthService();

  void _signUpWithEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        await authServices.signup(
          emailController.text,
          passwordController.text,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } catch (e) {
        _showError(e.toString());
      }
    }
  }


  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:Form(
            key: formKey,
              child:SingleChildScrollView(
                padding: EdgeInsets.all(20),

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                          height: 250,
                          width: 300,
                          child: Lottie.asset('assets/Animation2.json'),
                        ),
                    ),
                    Text('Registration From',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:Colors.indigo)),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name' ,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))
                        ),

                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email' ,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))
                        ),

                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password' ,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                    ),
                  SizedBox(height: 30),
                  
                  ElevatedButton(onPressed: ()=>   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 90),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: Text('Sign Up',style: TextStyle(fontSize: 24, color: Colors.white,),),
                  ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have account ?',style: TextStyle(fontSize: 22),),
                        TextButton(onPressed: () =>
                            Navigator.push (context ,MaterialPageRoute(builder: (context) => LoginScreen()  ) )   , 
                            child: Text('Login',style: TextStyle(fontSize: 25),)
                        )
                      ],
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
}
*/


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedia/home.dart';
import 'package:pokedia/login_page.dart';
import 'package:pokedia/firebaseServices/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  Signup createState() => Signup();
}

class Signup extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authService = AuthService();

  void _signUpWithEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        await authService.signUp(
          emailController.text,
          passwordController.text,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } catch (e) {
        _showError(e.toString());
      }
    }
  }

  void _signInWithGoogle() async {
    try {
      await authService.signInWithGoogle();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/Animation2.json', height: 250),
                Text('Registration Form',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo)),
                SizedBox(height: 20),
                _buildTextField(nameController, 'Name'),
                SizedBox(height: 20),
                _buildTextField(emailController, 'Email'),
                SizedBox(height: 20),
                _buildTextField(passwordController, 'Password',
                    isPassword: true),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _signUpWithEmail,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 90),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text('Sign Up',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
                SizedBox(height: 10),
                OutlinedButton.icon(
                  icon: Icon(Icons.login),
                  onPressed: _signInWithGoogle,
                  label: Text('Sign in with Google'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account?', style: TextStyle(fontSize: 18)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text('Login', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: (value) =>
      value == null || value.isEmpty ? 'Enter $label' : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
