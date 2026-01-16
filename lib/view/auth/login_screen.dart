import 'package:flutter/material.dart';
import 'package:todo/controller/auth_helper.dart';
import 'package:todo/view/auth/signup_screen.dart';
import 'package:todo/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email'),),
            TextField(obscureText: true, controller: passwordController, decoration: InputDecoration(labelText: 'Password'),),
            if(errorText.isNotEmpty) Text(errorText, style: TextStyle(color: Colors.red) ,),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AuthHelper().login(emailController.text.trim(), passwordController.text.trim(),context).then((returnValue){
                if(returnValue == "success"){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                }
                else{
                  
                  setState(() {
                    errorText = returnValue;
                  });                  
                }
              });
            }, child: Text("Log In")),
            TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
            }, child: Text("Create a new account"))
            
          ],
        ),
      ),
    );
  }
}