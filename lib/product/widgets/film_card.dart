import 'package:flutter/material.dart';
import 'package:chillflix_app/product/models/movie_model.dart';

class FilmCard extends StatelessWidget {
  final Movie movie;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final VoidCallback? onListTap;
  final bool isInList;

  const FilmCard({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
    this.onTap,
    this.onListTap,
    this.isInList = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Film poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                movie.imageUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: width,
                    height: height,
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.movie,
                      color: Colors.white,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            // Listem butonu
            if (onListTap != null)
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: onListTap,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isInList ? Icons.remove : Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            // Film bilgileri (alt kısım)
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
