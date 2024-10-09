import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String title;
  final List<String> images;
  final int currentIndex;

  ProductDetail({
    super.key,
    required this.title,
    required this.images,
    required this.currentIndex,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _currentSlide = 0;
  int selectedButton = 2;
  List<ImageItem>? specificImages;

  @override
  void initState() {
    super.initState();
    _currentSlide = widget.currentIndex; // Initialize _currentSlide with currentIndex
    specificImages = _getSpecificImages(widget.title);
  }

  List<ImageItem>? _getSpecificImages(String title) {
    switch (title) {
      case 'Steak':
        return [
          ImageItem(title: 'Delmonico Steak ', pricing: 80, image: 'images/s2.png',description:'A delicious plate featuring a savory Delmonico steak served with pepper steak and a variety of fresh vegetables as a garnish.' ),
          ImageItem(title: 'Mixed Grill Plate', pricing: 90, image: 'images/st21.png',description: 'A delicious plate featuring a variety of grilled meats, including pork steak, delmonico steak, carne asada, rib eye steak, sirloin steak, galbi, and venison, served with a side of vegetables.'),
          ImageItem(title: 'Mixed Grill Delight', pricing: 150, image: 'images/st22.png',description: 'A mouthwatering plate featuring a variety of succulent meats including pork steak, carne asada, delmonico steak, and more, perfectly cooked and garnished with fresh vegetables and spices.'),
        ];
      case 'Chicken':
        return [
          ImageItem(title: 'Crispy Fried Chicken', pricing: 50, image: 'images/s3.png',description: 'A delicious plate of golden-brown fried chicken served with a side of crispy fries. Perfect for a satisfying and indulgent meal.'),
          ImageItem(title: 'Savory Chicken', pricing: 80, image: 'images/st31.png',description: 'A delectable plate featuring a variety of chicken dishes, including karaage, tandoori chicken, and buffalo wings, served with a side of mixed vegetables. The different flavors and textures of the chicken dishes create a delightful culinary experience.'),
          ImageItem(title: 'Spicy Chicken Karaage', pricing: 60, image: 'images/st32.png',description: ' A delicious plate of spicy chicken karaage served with crispy pakora, fresh carrot sticks, and buffalo wings. The perfect blend of flavors for a satisfying meal.'),
        ];
      case 'Pasta':
        return [
          ImageItem(title: 'Classic Spaghetti', pricing: 30, image: 'images/s4.png',description: 'A plate of spaghetti topped with savory meatballs and rich marinara sauce, garnished with fresh basil.'),
          ImageItem(title: 'Spaghetti with Meat', pricing: 40, image: 'images/st41.png',description: 'A bowl of spaghetti featuring a robust meat sauce, elegantly presented with a touch of grated cheese.'),
          ImageItem(title: 'Hearty Spaghetti Dish', pricing: 45, image: 'images/st42.png',description: ' A vibrant plate of spaghetti covered in hearty meat sauce, complemented by a fork for easy enjoyment.'),
        ];
      case 'Salad':
        return [
          ImageItem(title: 'Grilled Chicken Salad', pricing: 10, image: 'images/s1.png',description: 'A fresh mix of greens topped with tender grilled chicken, feta, olives, and a scoop of hummus. Light, flavorful, and satisfying.'),
          ImageItem(title: 'Avocado Chicken Salad', pricing: 15, image: 'images/st11.png',description: 'Tender chicken, creamy avocado slices, and crisp greens with a touch of red pepper. A wholesome and flavorful choice.'),
          ImageItem(title: 'Garden Fresh Salad', pricing: 20, image: 'images/st12.png',description: 'Crisp lettuce, juicy tomatoes, and sweet corn topped with crunchy croutons. A simple and refreshing salad.'),
        ];
      case 'Pizza':
        return [
          ImageItem(title: ' Margherita Sushi pizza', pricing: 100, image: 'images/s5.png',description: 'A delicious pizza adorned with colorful vegetables and gooey cheese, presented on a striking black backdrop.'),
          ImageItem(title: 'Tomato&Cheese Pizza,', pricing: 90, image: 'images/st51.png',description: ' A vibrant pizza featuring juicy tomatoes and gooey cheese, set against a striking black backdrop.'),
          ImageItem(title: 'Garden Fresh Pizza', pricing: 95, image: 'images/st52.png',description: 'An elegant dish composed of fresh ingredients, artfully arranged to highlight its colors and textures, promising a delightful taste experience.'),
        ];
      case 'Burger':
        return [
          ImageItem(title: 'Veggie burger Chicken', pricing: 120, image: 'images/s6.png',description: 'A large hamburger topped with crispy bacon, fresh lettuce, and ripe tomato, showcasing a delicious meal.'),
          ImageItem(title: 'Bacon Cheeseburger', pricing: 80, image: 'images/st61.png',description: 'A mouthwatering hamburger featuring layers of bacon, cheese, and crisp lettuce.'),
          ImageItem(title: 'Classic Cheeseburger', pricing: 85, image: 'images/st62.png',description: 'A delicious hamburger topped with melted cheese, fresh lettuce, and ripe tomato.'),
        ];
      case 'Seafood':
        return [
          ImageItem(title: 'Healthy Salmon Plate', pricing: 200, image: 'images/s7.png',description: ' A vibrant plate featuring grilled salmon, fresh greens, and ripe tomatoes, showcasing a nutritious meal.'),
          ImageItem(title: 'Sushi Collection', pricing: 150, image: 'images/st71.png',description: ' A vibrant assortment of sushi rolls, perfect for culinary enthusiasts and food lovers.'),
          ImageItem(title: 'Flavorful Fish Dish', pricing:350, image: 'images/st72.png',description: 'A succulent fish served on a plate, complemented by an array of vegetables and a delectable sauce.'),
        ];
      default:
        return null;
    }
  }

  void addToCart() {
    if (specificImages != null && specificImages!.isNotEmpty) {
      ImageItem selectedItem = specificImages![_currentSlide];
      CartItem newItem = CartItem(
        name: widget.title,
        price: selectedItem.pricing,
        quantity: 1,
        image: selectedItem.image,
      );
      Provider.of<CartProvider>(context, listen: false).addToCart(newItem);
    }
  }

  void selectButton(int buttonIndex) {
    setState(() {
      selectedButton = buttonIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 250.0,
                enlargeCenterPage: true,
                initialPage: _currentSlide, // Start at the correct index
                onPageChanged: (index, _) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
              ),
              items: specificImages?.map((imageItem) {
                return Builder(
                  builder: (context) {
                    return Column(
                      children: [
                        Image.asset(
                          imageItem.image,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                        SizedBox(height: 10),
                        // Text(
                        //   'Price: \$${imageItem.pricing.toString()}',
                        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  specificImages![_currentSlide].title.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (specificImages != null && specificImages!.isNotEmpty)
                  Text(
                    'Price: \$${specificImages![_currentSlide].pricing.toString()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Description',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specificImages![_currentSlide].description,
                  style: TextStyle(fontSize: 16),
                ),
                // Add more description as needed
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      selectButton(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedButton == 1 ? Color.fromARGB(255, 234, 167, 102) : Colors.white,
                    ),
                    child: Text(
                      'RESELL',
                      style: TextStyle(
                          color: selectedButton == 1 ? Colors.white : Colors.black,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      selectButton(2);
                      addToCart();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedButton == 2 ?  Color.fromARGB(255, 234, 167, 102) : Colors.white,
                    ),
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                          color: selectedButton == 2 ? Colors.white : Colors.black,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageItem {
  final String title;
  final double pricing;
  final String image;
  int currentIndex;
  String description;

  ImageItem({
    required this.title,
    required this.pricing,
    required this.image,
    this.currentIndex = 0,
    required this.description,
  });
}
