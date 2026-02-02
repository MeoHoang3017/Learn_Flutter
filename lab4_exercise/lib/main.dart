import 'package:flutter/material.dart';

// Import 5 file bài tập (Đảm bảo bạn đã tạo 5 file này trong thư mục lib/)
import 'exercise1.dart';
import 'exercise2.dart';
import 'exercise3.dart';
import 'exercise4.dart';
import 'exercise5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 1. Quản lý trạng thái Theme toàn cục (Dùng cho Exercise 4)
  ThemeMode _themeMode = ThemeMode.light;

  // 2. Hàm cập nhật Theme (Sử dụng Switch để bật/tắt liên tục)
  void _updateTheme(bool isDark) {
    setState(() {
      // Biến này điều khiển themeMode của MaterialApp
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode, // Quan trọng: Quyết định màu toàn app
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: MainMenu(
          onThemeChanged: _updateTheme,
          isDarkMode: _themeMode == ThemeMode.dark
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const MainMenu({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 5 Exercises'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Danh sách bài tập:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _menuItem(
                    context,
                    title: 'Bài 1: Core Widgets',
                    subtitle: 'Text, Icon, Image, Card, ListTile',
                    icon: Icons.widgets_outlined,
                    page: const Exercise1(),
                  ),
                  _menuItem(
                    context,
                    title: 'Bài 2: Input Widgets',
                    subtitle: 'Slider, Switch, Radio, DatePicker',
                    icon: Icons.input_rounded,
                    page: const Exercise2(),
                  ),
                  _menuItem(
                    context,
                    title: 'Bài 3: Layout Basics',
                    subtitle: 'Column, Row, ListView (Movie Cards)',
                    icon: Icons.layers_outlined,
                    page: const Exercise3(),
                  ),
                  _menuItem(
                    context,
                    title: 'Bài 4: App Structure & Theme',
                    subtitle: 'Scaffold, FAB, Switch Dark Mode',
                    icon: Icons.settings_suggest_outlined,
                    // Truyền tiếp callback đổi theme vào Exercise 4
                    page: Exercise4(
                      onThemeChanged: onThemeChanged,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  _menuItem(
                    context,
                    title: 'Bài 5: Debug & Fix Errors',
                    subtitle: 'Fix Overflow & State issues',
                    icon: Icons.bug_report_outlined,
                    page: const Exercise5(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper tạo các nút chọn bài tập dạng Card
  Widget _menuItem(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Widget page,
      }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}