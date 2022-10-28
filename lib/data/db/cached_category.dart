const String categoryTable = "My_Category";

class CachedCategoryFields {
  static final List<String> values = [
    id,
    categoryName,
    categoryColor,
    iconPath,
  ];

  static const String id = "_id";
  static const String categoryName = "category_name";
  static const String categoryColor = "category_color";
  static const String iconPath = "icon_path";
}

class CachedCategory {
  CachedCategory({
    this.id,
    required this.iconPath,
    required this.categoryName,
    required this.categoryColor,
  });

  final int? id;
  final String categoryName;
  final int categoryColor;
  final int iconPath;

  CachedCategory copyWith({
    int? id,
    String? categoryName,
    int? categoryColor,
    int? iconPath,
  }) =>
      CachedCategory(
        id: id ?? this.id,
        iconPath: iconPath ?? this.iconPath,
        categoryName: categoryName ?? this.categoryName,
        categoryColor: categoryColor ?? this.categoryColor,
      );

  static CachedCategory fromJson(Map<String, Object?>json){
    return CachedCategory(
      id: json[CachedCategoryFields.id] as int?,
      iconPath: json[CachedCategoryFields.iconPath] as int,
      categoryName: json[CachedCategoryFields.categoryName] as String,
      categoryColor: json[CachedCategoryFields.categoryColor] as int
    );
  }


  Map<String, Object?> toJson() => {
    CachedCategoryFields.id: id,
    CachedCategoryFields.iconPath: iconPath,
    CachedCategoryFields.categoryName: categoryName,
    CachedCategoryFields.categoryColor: categoryColor,
  };

}
