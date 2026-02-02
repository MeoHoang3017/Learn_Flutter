import 'package:flutter/material.dart';

// ----------------------------------------------------------------
// STEP 2: DEFINE DATA MODEL
// ----------------------------------------------------------------

class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
    this.isFavorite = false,
  });
}

// SAMPLE DATA
final List<Movie> dummyMovies = [
  Movie(
    id: 1,
    title: "Interstellar",
    posterUrl: "https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=1000",
    overview: "When Earth becomes uninhabitable, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.",
    genres: ["Sci-Fi", "Drama", "Adventure"],
    rating: 8.7,
    trailers: ["Official Trailer 1", "Teaser Trailer", "Final Trailer"],
  ),
  Movie(
    id: 2,
    title: "Inception",
    posterUrl: "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=1000",
    overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
    genres: ["Action", "Sci-Fi", "Thriller"],
    rating: 8.8,
    trailers: ["Official Trailer", "Inception: Behind the Scenes"],
  ),
  Movie(
    id: 3,
    title: "The Dark Knight",
    posterUrl: "https://images.unsplash.com/photo-1478720568477-152d9b164e26?q=80&w=1000",
    overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
    genres: ["Action", "Crime", "Drama"],
    rating: 9.0,
    trailers: ["Trailer 1", "IMAX Featurette"],
  ),
];

// ----------------------------------------------------------------
// STEP 1: PROJECT SETUP & MAIN WRAPPER
// ----------------------------------------------------------------

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ----------------------------------------------------------------
// STEP 3: BUILD HOME SCREEN
// ----------------------------------------------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popcorn Movies"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummyMovies.length,
        itemBuilder: (context, index) {
          final movie = dummyMovies[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                // NAVIGATION: Navigator.push + MaterialPageRoute
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movie: movie),
                  ),
                );
              },
              child: Row(
                children: [
                  Hero(
                    tag: 'poster-${movie.id}',
                    child: Image.network(
                      movie.posterUrl,
                      height: 150,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(movie.rating.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ----------------------------------------------------------------
// STEP 4: BUILD MOVIE DETAIL SCREEN
// ----------------------------------------------------------------

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Banner (Stack + Image + Gradient)
            Stack(
              children: [
                Hero(
                  tag: 'poster-${widget.movie.id}',
                  child: Image.network(
                    widget.movie.posterUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black38,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Title and Genres (Wrap + Chips)
                  Text(
                    widget.movie.title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    children: widget.movie.genres
                        .map((genre) => Chip(
                      label: Text(genre),
                      backgroundColor: Colors.deepPurple.withOpacity(0.3),
                    ))
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  // 3. Action Buttons (Favorite / Rate / Share)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        icon: widget.movie.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.movie.isFavorite ? Colors.red : Colors.white,
                        label: "Favorite",
                        onTap: () {
                          setState(() {
                            widget.movie.isFavorite = !widget.movie.isFavorite;
                          });
                        },
                      ),
                      _buildActionButton(icon: Icons.star_border, label: "Rate"),
                      _buildActionButton(icon: Icons.share, label: "Share"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 4. Overview Text
                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie.overview,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),

                  const SizedBox(height: 25),

                  // 5. List of Trailers
                  const Text(
                    "Trailers",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true, // Needed inside SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.movie.trailers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.play_circle_fill, color: Colors.red),
                        title: Text(widget.movie.trailers[index]),
                        trailing: const Icon(Icons.download_outlined),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, Color color = Colors.white, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}