import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Импортируем provider
import 'cart_manager.dart'; // Импортируем CartManager

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина', style: TextStyle(fontWeight: FontWeight.normal)),
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Consumer<CartManager>(
        builder: (context, cartManager, child) {
          if (cartManager.items.isEmpty) {
            return Center(
              child: Text(
                'Ваша корзина пуста',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: cartManager.items.length,
                  itemBuilder: (context, index) {
                    final item = cartManager.items[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          item.imagePath,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/images/no_image.png',
                              width: 60,
                              height: 80,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₽',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFF86A2E),
                            ),
                          ),
                          SizedBox(width: 2.0),
                          Text(
                            '${item.price.toInt()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartManager.removeItem(item);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Сумма заказа:',
                          style: TextStyle(fontSize: 18, color: Color(0xFF8C8E98)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₽',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFF86A2E),
                              ),
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              '${cartManager.totalPrice.toInt()}',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 18.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Оплатить', style: TextStyle(fontSize: 18, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          backgroundColor: Color(0xFFF86A2E),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.0),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
