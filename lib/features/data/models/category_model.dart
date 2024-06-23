import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String note;
  Color categoryColor;
  String userId;
  

  CategoryModel({
    required this.id,
    required this.name,
    required this.note,
    this.categoryColor = Colors.transparent,
    required this.userId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      note: json['note'],
      id: json['id'],
      categoryColor: hexToColor(json['categoryColor']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'note': note,
      'id': id,
      'categoryColor': categoryColor.value.toRadixString(16),
      'userId': userId,
    };
  }
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'ff$hex';
  }
  return Color(int.parse(hex, radix: 16));
}
