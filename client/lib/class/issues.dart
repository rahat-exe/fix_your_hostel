enum Categories {
  water,
  electrical,
  furniture,
  wifi,
  security,
  cleanliness,
  other,
}

extension CategoriesX on Categories {
  String get label {
    switch (this) {
      case Categories.water:
        return 'Water';
      case Categories.electrical:
        return 'Electrical';
      case Categories.furniture:
        return 'Furniture';
      case Categories.wifi:
        return 'Wi-Fi';
      case Categories.security:
        return 'Security';
      case Categories.cleanliness:
        return 'Cleanliness';
      case Categories.other:
        return 'Other';
    }
  }
}

class Issues {
  Issues({
    required this.title,
    required this.description,
    required this.raisedBy,
    this.category,
  });
  final String title;
  final String description;
  final String raisedBy;
  Categories? category;
}
