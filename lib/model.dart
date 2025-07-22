class Pokemon {
  final String name;
  final int? height;
  final int? weight;
  final List<String> types;
  final String imageUrl;

  Pokemon({
    required this.name,
     this.height,
     this.weight,
    required this.types,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ??
          json['sprites']['front_default'] ?? '',
    );
  }
}
