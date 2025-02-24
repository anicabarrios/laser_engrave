class GalleryItem {
  final String imageUrl;
  final String title;
  final String category;
  final List<String> tags;

  const GalleryItem({
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.tags,
  });

  // Convert from Map to GalleryItem
  factory GalleryItem.fromMap(Map<String, dynamic> map) {
    return GalleryItem(
      imageUrl: map['imageUrl'],
      title: map['title'],
      category: map['category'],
      tags: List<String>.from(map['tags']),
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'category': category,
      'tags': tags,
    };
  }
}