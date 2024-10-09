import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test1/forget_password.dart';
import 'package:test1/home_screen.dart';
import 'package:test1/sign_up.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _passwordAddressController = TextEditingController();

  handleGoogleSignIn() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // User cancelled the sign-in
      return;
    }

    GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    if (googleAuth == null) {
      // Authentication failed
      return;
    }

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())
          );
        }
      }
    } catch (e) {
      // Handle sign-in errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode CurrentFocus= FocusScope.of(context);
        if(!CurrentFocus.hasPrimaryFocus && CurrentFocus.focusedChild!=null){
          CurrentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20,110,20,110),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text('Please sign in to continue',
                style: TextStyle(fontSize: 20,color: Colors.grey),),
                SizedBox(height: 40,),
                TextFormField(
                  controller: _emailAddressController,
                  style: TextStyle(color: Colors.black,fontFamily: 'SFUIDisplay'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'EMAIL',
                    prefixIcon: Icon(Icons.email_outlined),
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _passwordAddressController,
                  obscureText: true,
                  style: TextStyle(color: Colors.black,fontFamily: 'SFUIDisplay'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'PASSWORD',
                    prefixIcon: Icon(Icons.lock_outlined),
                    suffixIcon: TextButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgetPassword()));
                      },
                      child: Text(
                        'FORGOT',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(height: 50,
                    child: ElevatedButton(onPressed:(){
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailAddressController.text,
                          password: _passwordAddressController.text)
                          .then((value)=>{
                         Navigator.of(context).push(MaterialPageRoute(
                           builder:(context)=>HomeScreen()
                         ))
                      });
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 241, 180, 120),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('  LOGIN',style: TextStyle(color: Colors.white),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward,size: 24.0,color: Colors.white,),
                        ],
                    )),
                  ),
                ),
                SizedBox(height: 30,),

                SizedBox(height: 50,
                  child: ElevatedButton.icon(
                    onPressed: (){
                      handleGoogleSignIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: BorderSide(color:Colors.grey)
                    ),
                    icon: Image.asset('images/google_logo.png'),
                    label: Text('Sign in with Google',
                      style: TextStyle(color: Colors.black,fontSize: 16.0),),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
        height: 60,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Don't have an account? ",
              style:TextStyle(fontFamily:'SFUIDisplay',color:Colors.black,fontSize: 15),
              ),
              TextButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                  child:Text('Sign Up',
                    style: TextStyle(fontFamily: 'SFuIDisplay',
                        color: Colors.blue,fontSize: 15),))
            ],),),
      ),
    );
  }
}
