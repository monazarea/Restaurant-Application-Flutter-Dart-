import 'package:flutter/material.dart';
import 'package:test1/bottom_nav_bar.dart';

import 'custom_scaffold.dart';
class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(
      body: SafeArea(
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color:Color.fromARGB(255, 234, 167, 102),),
                child: Padding(
                  padding:EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       'MyAccoun',
                        style: TextStyle(fontSize: 22,color: Colors.white),
                      ),
                      SizedBox(height: 8,),
                      Text('monazarea@gmail.com',
                      style: TextStyle(fontSize: 12,color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Image.asset('images/f3.png',
              height: 150,width: MediaQuery.of(context).size.width,fit: BoxFit.contain,),
              SizedBox(height: 10,),
              Padding(padding: EdgeInsets.all(10.0),
              child: Text('My Account',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
              ListOfOption(icon: Icon(Icons.person_2_outlined,color: Colors.blue,),
                  title:'Home' ),
              ListOfOption(icon: Icon(Icons.location_city_outlined,color: Colors.blue,),
                  title:'Addresses' ),
              ListOfOption(icon: Icon(Icons.payment_outlined,color: Colors.blue,),
                  title:'Payment' ),
              ListOfOption(icon: Icon(Icons.shopping_bag_outlined,color: Colors.blue,),
                  title:'Orders' ),
              SizedBox(height: 10,),
              Padding(padding: EdgeInsets.all(10.0),
                child: Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ),
              ListOfOption(icon: Icon(Icons.language_outlined,color: Colors.blue,),
                  title:'Language' ),
            ],
          ),)),
      showBottomNavBar: true,
      initialIndex: 2,
    );
  }
}
class ListOfOption extends StatelessWidget {
  final Icon icon;
  final String title;
  const ListOfOption({super.key,required this.icon,required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 16,),
      onTap: (){},

    );
  }
}

