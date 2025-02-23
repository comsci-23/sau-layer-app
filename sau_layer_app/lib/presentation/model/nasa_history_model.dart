class NasaHistoryModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  NasaHistoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory NasaHistoryModel.fromJson(Map<String, dynamic> json) {
    final links = json['links'] as List<dynamic>?;
    final imageUrl = links != null && links.isNotEmpty ? links[0]['href'] : '';

    return NasaHistoryModel(
      id: json['data'][0]['nasa_id'],
      title: json['data'][0]['title'],
      description: json['data'][0]['description'],
      imageUrl: imageUrl,
    );
  }
}