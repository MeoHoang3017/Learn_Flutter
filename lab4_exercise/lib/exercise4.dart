import 'package:flutter/material.dart';

class Exercise4 extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const Exercise4({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<Exercise4> createState() => _Exercise4State();
}

class _Exercise4State extends State<Exercise4> {
  // Biến trạng thái cục bộ để Switch phản hồi tức thì
  late bool _localDarkMode;

  @override
  void initState() {
    super.initState();
    _localDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 – App Str...'),
        actions: [
          Row(
            children: [
              const Text('Dark'),
              Switch(
                value: _localDarkMode,
                onChanged: (bool value) {
                  // 1. Cập nhật giao diện tại màn hình này ngay lập tức
                  setState(() {
                    _localDarkMode = value;
                  });
                  // 2. Gọi hàm ở main.dart để đổi theme cho toàn bộ App
                  widget.onThemeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const Center(
        child: Text(
          'This is a simple screen with theme toggle.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
      // Bổ sung FAB theo yêu cầu gốc của Exercise 4
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}