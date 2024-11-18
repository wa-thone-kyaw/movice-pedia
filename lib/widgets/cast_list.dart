import 'package:flutter/material.dart';

class CastList extends StatelessWidget {
  final List<dynamic> cast;

  const CastList({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          final actor = cast[index];
          return SizedBox(
            width: 100,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: actor['profile_path'] != null
                      ? NetworkImage(
                          'https://image.tmdb.org/t/p/w200${actor['profile_path']}')
                      : null,
                  radius: 30,
                ),
                Text(
                  actor['name'] ?? 'Unknown',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
