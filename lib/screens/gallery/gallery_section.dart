import 'package:flutter/material.dart';
import 'category_filter.dart';
import 'gallery_grid.dart';
import 'project_details_dialog.dart';
import 'gallery_data_provider.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  String _selectedCategory = 'All';
  late List<Map<String, dynamic>> _items;
  late List<String> _categories;

  @override
  void initState() {
    super.initState();
    _items = GalleryDataProvider.getGalleryItems();
    _categories = GalleryDataProvider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category Filter
        CategoryFilter(
          categories: _categories,
          selectedCategory: _selectedCategory,
          onCategorySelected: (category) {
            setState(() => _selectedCategory = category);
          },
        ),
        const SizedBox(height: 40),

        // Gallery Grid
        GalleryGrid(
          items: _getFilteredItems(),
          onItemTap: (item) => _showProjectDetails(context, item),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    if (_selectedCategory == 'All') {
      return _items;
    } else {
      return _items.where((item) => item['category'] == _selectedCategory).toList();
    }
  }

  void _showProjectDetails(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailsDialog(project: item),
    );
  }
}