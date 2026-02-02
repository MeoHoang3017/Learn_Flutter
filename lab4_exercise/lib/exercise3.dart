import 'package:flutter/material.dart';

class Exercise3 extends StatelessWidget {
  const Exercise3({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu danh sách phim kèm ảnh
    final List<Map<String, String>> movies = [
      {'title': 'Spider-man: No Way Home', 'year': '2021', 'img': 'https://picsum.photos/id/1/200/200'},
      {'title': 'The Dark Knight', 'year': '2008', 'img': 'https://picsum.photos/id/10/200/200'},
      {'title': 'Inception', 'year': '2010', 'img': 'https://picsum.photos/id/20/200/200'},
      {'title': 'Interstellar', 'year': '2014', 'img': 'https://picsum.photos/id/30/200/200'},
      {'title': 'Avengers: Endgame', 'year': '2019', 'img': 'https://picsum.photos/id/40/200/200'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Movie List (Layout Basics)')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Featured Movies', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    // Ảnh ở đầu (Yêu cầu của bạn)
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movies[index]['img']!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(movies[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Release Year: ${movies[index]['year']}'),
                    trailing: const Icon(Icons.play_circle_fill, color: Colors.red, size: 30),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}