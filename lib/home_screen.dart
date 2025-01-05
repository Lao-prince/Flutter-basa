import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'menu_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<MenuItem> _allItems; // Все загруженные элементы
  late List<MenuItem> _filteredItems; // Фильтрованные элементы для отображения
  late Future<void> _initialLoad;
  List<String>? _foodTypes; // Типы продуктов
  String _selectedType = 'Всё';

  @override
  void initState() {
    super.initState();
    // Загружаем все данные при инициализации
    _initialLoad = _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      _allItems = await fetchMenuItems();
      _filteredItems = List.from(_allItems); // Изначально показываем все элементы
      _foodTypes = await fetchFoodTypes(); // Загружаем типы продуктов
    } catch (e) {
      throw Exception('Failed to load initial data: $e');
    }
  }

  Future<List<MenuItem>> fetchMenuItems() async {
    final String url = 'https://valentin-smirnov-zaimka-back-v2-4ce7.twc1.net/api/food/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<MenuItem> menuItems = jsonResponse.map((data) => MenuItem.fromJson(data)).toList();
      return menuItems;
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  Future<List<String>> fetchFoodTypes() async {
    final response = await http.get(Uri.parse('https://valentin-smirnov-zaimka-back-v2-4ce7.twc1.net/api/food_types/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<String> foodTypes = jsonResponse.map((data) => utf8.decode(data['name'].toString().codeUnits)).toList();
      foodTypes.insert(0, 'Всё');
      return foodTypes;
    } else {
      throw Exception('Failed to load food types');
    }
  }

  void _applyFilter(String type) {
    setState(() {
      _selectedType = type;
      if (type == 'Всё') {
        _filteredItems = List.from(_allItems);
      } else {
        _filteredItems = _allItems.where((item) => item.foodType == type).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.place, color: Color(0xFFF86A2E)),
                SizedBox(width: 8.0),
                Text(
                  'Ресторан Заимка',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Icon(Icons.notifications, color: Colors.black54),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<void>(
        future: _initialLoad,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (_foodTypes != null) // Проверяем, что типы продуктов уже загружены
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _foodTypes!.map((type) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                              label: Text(type),
                              selected: _selectedType == type, onSelected: (selected) {
                        _applyFilter(type);
                        },
                          selectedColor: Color(0xFFF86A2E),
                          backgroundColor: Color(0xFFF3F4F6),
                          labelStyle: TextStyle(
                            color: _selectedType == type ? Color(0xFFF5F5F5) : Color(0xFF6A6A6A),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: BorderSide.none,
                          elevation: _selectedType == type ? 10 : 0,
                          selectedShadowColor: Colors.black.withOpacity(0.75),
                          showCheckmark: false,
                        ),
                        );
                      }).toList(),
                    ),
                  ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: _filteredItems.map((item) => MenuItemWidget(menuItem: item)).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}