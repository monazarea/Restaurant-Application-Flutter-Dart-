import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/home_screen.dart';
import 'package:test1/sign_in.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {

    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmpasswordController = TextEditingController();

    return GestureDetector(
      onTap: (){
        FocusScopeNode CurrentFocus= FocusScope.of(context);
        if(!CurrentFocus.hasPrimaryFocus && CurrentFocus.focusedChild!=null){
          CurrentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(onPressed:()=>Navigator.of(context).pop(),
                icon:Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
            ),
        ),
        body: SafeArea(child: SingleChildScrollView(
          child:Padding(
              padding:EdgeInsets.fromLTRB(20, 110, 20, 110),
              child: Column(
                children: [
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40,),
                TextFields(label: 'FULL NAME',
                  icon: Icon(Icons.person_2_outlined),
                  controller: _nameController,
                ),
                SizedBox(height: 10,),
                TextFields(label: 'EMAIL',
                  icon: Icon(Icons.email_outlined),
                  controller: _emailController,
                ),
                SizedBox(height: 10,),
                TextFields(label: 'PASSWORD',
                  icon: Icon(Icons.lock_outlined),
                  controller: _passwordController,
                secureText: true,
                ),
                SizedBox(height: 10,),
                TextFields(label: 'CONFIRM PASSWORD',
                  icon: Icon(Icons.lock_outlined),
                  controller: _confirmpasswordController,
                  secureText: true,
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(height: 50,
                    child: ElevatedButton(onPressed: (){
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                          .then((value)=>{
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder:(context)=>HomeScreen()),
                            ),
                      });
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 241, 180, 120),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text('SIGN UP',style: TextStyle(color: Colors.white),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward,size: 24.0,color: Colors.white,),

                        ],)),
                  ),
                )
              ],),))),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have a account?',style: TextStyle(fontFamily: 'SFUIDisplay',color: Colors.black,fontSize: 15 ),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignIn()));},
                  child:Text(
                    'Sign In',
                     style: TextStyle(
                       fontSize: 15,
                       color: Colors.blue,
                       fontFamily: 'SFUIDisplay',
                     ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final Icon icon;
  final String label;
  TextEditingController controller;
  bool secureText;


  TextFields({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.secureText=false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: secureText,
        style: TextStyle(
          color: Colors.black,fontFamily: 'SFUIDisplay',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          prefixIcon: icon,
          labelStyle: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
