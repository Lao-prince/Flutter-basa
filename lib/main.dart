import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'package:provider/provider.dart';
import 'cart_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartManager(),
      child: MaterialApp(
        title: 'Ресторан Заимка',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white, // Устанавливаем белый фон по умолчанию
        ),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Устанавливаем фон для всего Scaffold
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ), // Убедитесь, что это не null
      bottomNavigationBar: Container(
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavItem(
                icon: 'assets/images/menu_icon.svg',
                label: 'Меню',
                index: 0,
              ),
              _buildNavItem(
                icon: 'assets/images/cart_icon.svg',
                label: 'Корзина',
                index: 1,
                withBadge: true,
              ),
              _buildNavItem(
                icon: 'assets/images/profile_icon.svg',
                label: 'Профиль',
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required String label, required int index, bool withBadge = false}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                icon,
                width: 32.0,
                height: 32.0,
                color: _selectedIndex == index ? Color(0xFFF86A2E) : Colors.grey,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.0,
                  color: _selectedIndex == index ? Color(0xFFF86A2E) : Colors.grey,
                ),
              ),
            ],
          ),
          if (withBadge)
            Positioned(
              right: 0,
              top: 0,
              child: Consumer<CartManager>(
                builder: (context, cartManager, child) {
                  if (cartManager.itemCount > 0) {
                    return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${cartManager.itemCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
        ],
      ),
    );
  }
}

