import 'package:flutter/material.dart';
import 'package:test1/custom_scaffold.dart';

class Food extends StatelessWidget {
  const Food({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of food items
    final List<CardItem> topPicks = [
      CardItem(
        title: 'Delmonico Steak',
        image: 'images/s2.png',
        pricing: 80,
      ),
      CardItem(
        title: 'Crispy Fried Chicken',
        image: 'images/s3.png',
        pricing: 50,
      ),
      CardItem(
        title: 'Classic Spaghetti',
        image: 'images/s4.png',
        pricing: 30,
      ),
      CardItem(
        title: 'Margherita Pizza',
        image: 'images/s5.png',
        pricing: 100,
      ),
      CardItem(
        title: 'Garden Fresh Salad',
        image: 'images/s1.png',
        pricing: 20,
      ),
      CardItem(
        title: 'Healthy Salmon Plate',
        image: 'images/s7.png',
        pricing: 200,
      ),
    ];

    return CustomScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Top Picks',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: topPicks.length,
                itemBuilder: (context, index) {
                  final item = topPicks[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          item.image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Price: \$${item.pricing}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem {
  final String title;
  final String image;
  final double pricing;

  CardItem({
    required this.title,
    required this.image,
    required this.pricing,
  });
}
