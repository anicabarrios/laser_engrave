class GalleryDataProvider {
  // Sample gallery items
  static List<Map<String, dynamic>> getGalleryItems() {
    return [
      {
        'imageUrl': 'assets/images/custom.webp',
        'title': 'Custom Wood Signage',
        'category': 'Wood Engraving',
        'tags': ['Custom Design', 'Premium Wood', 'Business'],
      },
      {
        'imageUrl': 'assets/images/industrial2.webp',
        'title': 'Industrial Component Marking',
        'category': 'Metal',
        'tags': ['Serial Numbers', 'QR Codes', 'Industrial'],
      },
      {
        'imageUrl': 'assets/images/engraved.webp',
        'title': 'Custom Metal Engraving',
        'category': 'Metal',
        'tags': ['Crystal', 'Awards', 'Bulk Order'],
      },
        {
      'imageUrl': 'assets/images/artistic1.webp',
      'title': 'Artistic Laser Cut',
      'category': 'Artistic',
      'tags': ['Modern Art', 'Creative', 'Laser Engraving'],
    },
     {
        'imageUrl': 'assets/images/glass.webp',
        'title': 'Glass Crystal Engraving',
        'category': 'Crystal',
        'tags': ['Premium Gift', 'Corporate Award', '3D Etching'],
      },
    {
        'imageUrl': 'assets/images/personalized.webp',
        'title': 'Personalized Gift Items',
        'category': 'Gift',
        'tags': ['Custom Message', 'Keepsake', 'Anniversary'],
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