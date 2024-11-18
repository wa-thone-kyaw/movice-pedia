class Cast {
  final String name;
  final String character;
  final String profilePath;

  Cast({
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'] ?? 'Unknown',
      character: json['character'] ?? 'Unknown',
      profilePath: json['profile_path'] ?? '',
    );
  }
}
