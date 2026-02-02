import 'package:flutter/material.dart';

// ----------------------------------------------------------------
// STEP 2: DEFINE MOVIE MODEL & SAMPLE DATA
// ----------------------------------------------------------------
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

final List<Movie> allMovies = [
  Movie(
    title: "Interstellar",
    year: 2014,
    genres: ["Sci-Fi", "Drama"],
    posterUrl: "https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=400",
    rating: 8.7,
  ),
  Movie(
    title: "Inception",
    year: 2010,
    genres: ["Sci-Fi", "Action"],
    posterUrl: "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=400",
    rating: 8.8,
  ),
  Movie(
    title: "The Dark Knight",
    year: 2008,
    genres: ["Action", "Crime"],
    posterUrl: "https://images.unsplash.com/photo-1478720568477-152d9b164e26?q=80&w=400",
    rating: 9.0,
  ),
  Movie(
    title: "The Lion King",
    year: 1994,
    genres: ["Animation", "Drama"],
    posterUrl: "https://images.unsplash.com/photo-1543007630-9710e4a00a20?q=80&w=400",
    rating: 8.5,
  ),
  Movie(
    title: "Pulp Fiction",
    year: 1994,
    genres: ["Crime", "Drama"],
    posterUrl: "https://images.unsplash.com/photo-1594909122845-11baa439b7bf?q=80&w=400",
    rating: 8.9,
  ),
  Movie(
    title: "The Matrix",
    year: 1999,
    genres: ["Sci-Fi", "Action"],
    posterUrl: "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=400",
    rating: 8.7,
  ),
];

// ----------------------------------------------------------------
// STEP 1 & 3: PROJECT SETUP & BASE SCAFFOLD
// ----------------------------------------------------------------
void main() {
  runApp(const ResponsiveMovieApp());
}

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Genre Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // STATE VARIABLES
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = 'A-Z';

  final List<String> availableGenres = [
    "Action", "Drama", "Sci-Fi", "Crime", "Animation"
  ];

  final List<String> sortOptions = ["A-Z", "Z-A", "Year", "Rating"];

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------------
    // STEP 7: FILTER AND SORT LOGIC
    // ----------------------------------------------------------------
    List<Movie> visibleMovies = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre = selectedGenres.isEmpty ||
          movie.genres.any((g) => selectedGenres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    // Sorting
    if (selectedSort == "A-Z") {
      visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    } else if (selectedSort == "Z-A") {
      visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    } else if (selectedSort == "Year") {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year));
    } else if (selectedSort == "Rating") {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Lab 6.1: Heading
              const Text(
                "Find a Movie",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // STEP 4: SEARCH BAR
              TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: "Search title...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // STEP 5: GENRE CHIPS (WRAP)
              const Text("Genres", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: availableGenres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGenres.add(genre);
                        } else {
                          selectedGenres.remove(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // STEP 6: SORT DROPDOWN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Showing ${visibleMovies.length} movies"),
                  DropdownButton<String>(
                    value: selectedSort,
                    items: sortOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (val) => setState(() => selectedSort = val!),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // STEP 8: RESPONSIVE MOVIE LIST/GRID
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (visibleMovies.isEmpty) {
                      return const Center(child: Text("No movies found."));
                    }

                    // Breakpoint: 800px
                    if (constraints.maxWidth < 800) {
                      // MOBILE VIEW: Single Column List
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) => MovieCard(movie: visibleMovies[index], isGrid: false),
                      );
                    } else {
                      // TABLET/WEB VIEW: Two Column Grid
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) => MovieCard(movie: visibleMovies[index], isGrid: true),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// MOVIE CARD COMPONENT
// ----------------------------------------------------------------
class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isGrid;

  const MovieCard({super.key, required this.movie, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // Poster
          Image.network(
            movie.posterUrl,
            width: isGrid ? 100 : 80,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                color: Colors.grey,
                child: const Icon(Icons.movie)
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("${movie.year} • ${movie.genres.join(', ')}",
                      style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(movie.rating.toString(), style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}