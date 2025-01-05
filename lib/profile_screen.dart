import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(fontWeight: FontWeight.normal)),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60.0, // Размер аватара
              backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
            ),
            SizedBox(height: 45.0), // Пространство под аватаром
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Имя пользователя',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191D31),
                ),
              ),
            ),
            SizedBox(height: 8.0), // Пространство между заголовком и рамкой
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Color(0xFFF3F3F3), width: 1.5),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person, color: Color(0xFFF86A2E)), // Иконка профиля
                  SizedBox(width: 17.0), // Пространство между иконкой и текстом
                  Text(
                    'Райан Гослинг',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF191D31),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0), // Пробел перед следующим блоком
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email или номер телефона',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191D31),
                ),
              ),
            ),
            SizedBox(height: 8.0), // Пространство между заголовком и рамкой
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Color(0xFFF3F3F3), width: 1.5),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.email, color: Color(0xFFF86A2E)), // Иконка email
                  SizedBox(width: 17.0), // Пространство между иконкой и текстом
                  Text(
                    'vglavnihrolah@mail.com',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF191D31),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
