import 'package:flutter/material.dart';

class Exercise5 extends StatelessWidget {
  const Exercise5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tiêu đề hiển thị giống trong ảnh
        title: const Text('Exercise 5 – Common U...'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần tiêu đề nội dung
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // LỖI THƯỜNG GẶP: ListView đặt trực tiếp trong Column sẽ gây crash
          // (do Column không giới hạn chiều cao cho ListView).
          // GIẢI PHÁP: Bọc ListView trong widget Expanded.
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.movie, size: 30),
                  title: Text('Movie A', style: TextStyle(fontSize: 16)),
                ),
                ListTile(
                  leading: Icon(Icons.movie, size: 30),
                  title: Text('Movie B', style: TextStyle(fontSize: 16)),
                ),
                ListTile(
                  leading: Icon(Icons.movie, size: 30),
                  title: Text('Movie C', style: TextStyle(fontSize: 16)),
                ),
                ListTile(
                  leading: Icon(Icons.movie, size: 30),
                  title: Text('Movie D', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}