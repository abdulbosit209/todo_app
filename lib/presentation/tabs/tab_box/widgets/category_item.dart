import 'package:flutter/material.dart';
import 'package:todo_app/data/db/cached_category.dart';
import '../../../../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
        required this.categoryModel,
        required this.onTap,
        required this.isSelected})
      : super(key: key);

  final CachedCategory categoryModel;
  final VoidCallback onTap;
  final bool isSelected;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: 85,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(categoryModel.categoryColor)),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconData(categoryModel.iconPath, fontFamily: "MaterialIcons"),
                      // Icon(IconData(categoryModel.iconPath, fontFamily: 'MaterialIcons'));
                      size: 35,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        categoryModel.categoryName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                    color: Colors.white.withOpacity(0.85),
                    child: const Center(
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                  )),
            )
          ],
        ));
  }
}