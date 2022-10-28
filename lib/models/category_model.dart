import 'package:flutter/material.dart';

class Category {
  Category({
    required this.categoryId,
    required this.iconPath,
    required this.categoryColor,
    required this.categoryName,
  });

  final int categoryId;
  final IconData iconPath;
  final String categoryName;
  final Color categoryColor;
}
