import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'sign_in.dart';
import 'sign_up.dart';
class loginScreen extends StatelessWidget{
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/log_screen.jpg')
            ,fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),BlendMode.darken
            ),
          )
        ),
        child: Column(children: [
          Padding(
              padding:EdgeInsets.fromLTRB(5, 120, 5, 20)
          ),
          SizedBox(height: 360,),
          Button(text: 'SIGN UP', onPressed:(){
            Navigator.of(context)
                .push((MaterialPageRoute(builder: (context)=>SignUp())));
          }),
          SizedBox(height: 20,),
          Button(text: 'SIGN IN', onPressed:(){
            Navigator.of(context)
                .push((MaterialPageRoute(builder: (context)=>SignIn())));
          }),
          Spacer(),
          Padding(
            padding:const EdgeInsets.only(bottom: 30,right: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed:(){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                  child:Text('Skip',style: TextStyle(
                      color: Color.fromARGB(255, 241, 180, 120),fontSize:20,
                  fontWeight: FontWeight.w400),)
              ),
            ),
          )
        ],),
      ),
    );
  }

}
class Button extends StatelessWidget{
  String text;
  final void Function() onPressed;
  Button({
    super.key,required this.text,required this.onPressed,
});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onPressed,
      child: Text(text,
        style: TextStyle(
          color: Color.fromARGB(255, 234, 167, 102),
          fontSize: 20,
        ),),
      // style: ElevatedButton.styleFrom(
      //     backgroundColor: Color(0xEF6AB3F1),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(30.0),
      //     )
      );

  }

}