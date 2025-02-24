class GalleryDataProvider {
  // Sample gallery items
  static List<Map<String, dynamic>> getGalleryItems() {
    return [
      {
        'imageUrl': 'assets/images/project1.jpg',
        'title': 'Custom Wood Signage',
        'category': 'Wood Engraving',
        'tags': ['Custom Design', 'Premium Wood', 'Business'],
      },
      {
        'imageUrl': 'assets/images/project2.jpg',
        'title': 'Industrial Component Marking',
        'category': 'Metal',
        'tags': ['Serial Numbers', 'QR Codes', 'Industrial'],
      },
      {
        'imageUrl': 'assets/images/project3.jpg',
        'title': 'Corporate Awards Set',
        'category': 'Corporate',
        'tags': ['Crystal', 'Awards', 'Bulk Order'],
      },
        {
      'imageUrl': 'assets/images/project4.jpg',
      'title': 'Artistic Laser Sculpture',
      'category': 'Artistic',
      'tags': ['Modern Art', 'Creative', 'Laser Engraving'],
    },
    ];
  }

  // Get unique categories from gallery items
  static List<String> getCategories() {
    final items = getGalleryItems();
    final categories = items.map((item) => item['category'] as String).toSet().toList();
    categories.insert(0, 'All');
    return categories;
  }
}