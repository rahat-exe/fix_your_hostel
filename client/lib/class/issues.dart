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
  const Issues(this.title, this.description, this.raisedBy, this.category);
  final String title;
  final String description;
  final String raisedBy;
  final Categories category;
}
