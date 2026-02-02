import 'package:flutter/material.dart';

class Exercise1 extends StatelessWidget {
  const Exercise1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. App Structure (AppBar)
      appBar: AppBar(
        title: const Text('Flutter Core Widgets'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Phần Headline (Chứa Text và Icon) ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.menu_book_outlined, // Yêu cầu: Icon
                  size: 28,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 8),
                Text(
                  'Profile Of Cat #256', // Yêu cầu: Text Headline
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- Phần Card chứa ListTile (Yêu cầu: Card, ListTile, Image) ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  radius: 30,
                  // Yêu cầu: Image.network
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/c8/55/d4/c855d483487141fb31271acfa5da5974.jpg',
                  ),
                ),
                title: Text(
                  'Just A Cat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Flutter Developer'),
                trailing: Icon(Icons.verified, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 24),

            // --- Phần danh sách Skills (Minh họa thêm ListView) ---
            const Text(
              'Skills',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: const [
                  SkillItem(title: 'Dart', icon: Icons.code),
                  SkillItem(title: 'Flutter', icon: Icons.flutter_dash),
                  SkillItem(title: 'Firebase', icon: Icons.storage),
                  SkillItem(title: 'UI/UX Design', icon: Icons.palette),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget phụ cho danh sách skill để code sạch hơn
class SkillItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const SkillItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
      ),
    );
  }
}