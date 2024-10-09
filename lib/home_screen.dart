import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test1/bottom_nav_bar.dart';
import 'package:test1/product_detail.dart';

import 'custom_scaffold.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardItem>cardItems = [];
  String searchText ='';

  @override
  void initState(){
    super.initState();
    cardItems=[
      CardItem(title:'Steak',images:['images/s2.png','images/st21.png','images/st22.png']),
      CardItem(title:'Chicken',images:['images/s3.png','images/st31.png','images/st32.png']),
      CardItem(title:'Pasta',images:['images/s4.png','images/st41.png','images/st42.png']),
      CardItem(title:'Pizza',images:['images/s5.png','images/st51.png','images/st52.png']),
      CardItem(title:'Salad',images:['images/s1.png','images/st11.png','images/st12.png']),
      CardItem(title:'Burger',images:['images/s6.png','images/st61.png','images/st62.png']),
      CardItem(title:'Seafood',images:['images/s7.png','images/st71.png','images/st72.png']),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: CustomScaffold(
        body: SafeArea(
          child: SingleChildScrollView(  // Wrap with SingleChildScrollView
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 234, 167, 102)),
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search restaurants, cuisines & dishes',
                              hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                              border: InputBorder.none,
                              icon: Icon(Icons.search),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  physics: ClampingScrollPhysics(), // Allow the GridView to scroll
                  shrinkWrap: true, // Let GridView take the necessary space
                  children: cardItems
                      .where((cardItem) => cardItem.title.toLowerCase().contains(searchText.toLowerCase()))
                      .map((cardItem) {
                    return buildCard(cardItem);
                  })
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        showBottomNavBar: true,
        initialIndex: 0,
      ),
    );
  }

  Widget buildCard(CardItem cardItem){
    return GestureDetector(
      onTap: ()async{
        await Navigator.push(
            context,MaterialPageRoute(builder: (context)=>ProductDetail(
          title: cardItem.title,
          images: cardItem.images,
          currentIndex: cardItem.currentIndex,
          //pricing: cardItem.pricing,
        ),));
      },
      child: Card(
        child:Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/6,
              child: PageView.builder(
                itemCount: cardItem.images.length,
                  onPageChanged: (int index){
                  setState(() {
                     cardItem.currentIndex = index;
                  });
                  },
                  itemBuilder: (context,index){
                    return Image.asset(cardItem.images[index],
                    fit:BoxFit.cover,
                    );
                  },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                List<Widget>.generate(
                    cardItem.images.length,
                        (int circleIndex){
                      return Padding(
                          padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(radius: 4,backgroundColor: circleIndex==cardItem.currentIndex ? Color.fromARGB(255, 234, 167, 102):Colors.grey,),
                      );
                }),

            ),
              Text(
                cardItem.title,
                style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
              ),

          ],
        )

      ),
    );
  }
}
class CardItem{
  final String title;
  // final String pricing;
  final List<String> images;
  int currentIndex;
  CardItem({required this.title,required this.images,this.currentIndex=0,});
}
