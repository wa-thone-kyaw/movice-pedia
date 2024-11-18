import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  final List<dynamic> reviews;

  const ReviewList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(review['author'] ?? 'Anonymous'),
            subtitle: Text(review['content'] ?? 'No content available'),
          ),
        );
      },
    );
  }
}
