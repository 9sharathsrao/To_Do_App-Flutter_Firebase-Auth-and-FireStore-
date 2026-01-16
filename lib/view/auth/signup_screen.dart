import 'package:flutter/material.dart';
import 'package:todo/controller/auth_helper.dart';
import 'package:todo/view/auth/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email'),),
            TextField(obscureText: true, controller: passwordController, decoration: InputDecoration(labelText: 'Password'),),
            if(errorText.isNotEmpty) Text(errorText, style: TextStyle(color: Colors.red) ,),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AuthHelper().signUp(emailController.text.trim(), passwordController.text.trim(),context).then((returnValue){
                if(returnValue == "success"){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }
                else{
                  
                  setState(() {
                    errorText = returnValue;
                  });                  
                }
              });
            }, child: Text("Sign Up")),
            TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }, child: Text("Already have an account?"))
            
          ],
        ),
      ),
    );
  }
}