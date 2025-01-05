import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'cart_manager.dart';

class MenuItem {
  final int id;
  final String foodType;
  final String name;
  final String imagePath;
  final double price;
  final String description;

  MenuItem({
    required this.id,
    required this.foodType,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['picture'];
    if (!imageUrl.startsWith('http://') && !imageUrl.startsWith('https://')) {
      imageUrl = 'http://valentin-smirnov-zaimka-back-v2-4ce7.twc1.net/media$imageUrl';
    }

    return MenuItem(
      id: json['id'],
      name: utf8.decode(json['name'].toString().codeUnits),
      description: utf8.decode(json['description'].toString().codeUnits),
      price: json['price'].toDouble(),
      foodType: utf8.decode(json['food_type']['name'].toString().codeUnits),
      imagePath: imageUrl,
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem menuItem;

  MenuItemWidget({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Опционально, можно показать подробности при нажатии
        },
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        menuItem.imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/images/no_image.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menuItem.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            menuItem.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF191D31),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₽',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFF86A2E),
                              ),
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              '${menuItem.price.toInt()}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Tooltip(
                  message: 'Добавить в корзину',
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: IconButton(
                      icon: Icon(Icons.add, color: Color(0xFFF86A2E)),
                      onPressed: () {
                        Provider.of<CartManager>(context, listen: false).addItem(menuItem);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
