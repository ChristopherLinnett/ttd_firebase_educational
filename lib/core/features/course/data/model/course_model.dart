import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.imageIsFile = false,
    super.description,
    super.image,
  });

  factory CourseModel.fromMap(DataMap map) {
    return CourseModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String?,
      numberOfExams: (map['numberOfExams'] as num?)?.toInt() ?? 0,
      numberOfMaterials: (map['numberOfMaterials'] as num?)?.toInt() ?? 0,
      numberOfVideos: (map['numberOfVideos'] as num?)?.toInt() ?? 0,
      groupId: map['groupId'] as String? ?? '',
      image: map['image'] as String?,
      imageIsFile: map['imageIsFile'] as bool? ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as DataMap);

  CourseModel.empty()
      : this(
          id: '',
          title: '',
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          groupId: '',
          createdAt: DateTime.fromMillisecondsSinceEpoch(0),
          updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
        );

  CourseModel copyWith({
    String? id,
    String? title,
    ValueGetter<String?>? description,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    ValueGetter<String?>? image,
    bool? imageIsFile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description != null ? description() : this.description,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      image: image != null ? image() : this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'numberOfExams': numberOfExams,
      'numberOfMaterials': numberOfMaterials,
      'numberOfVideos': numberOfVideos,
      'groupId': groupId,
      'image': image,
      'imageIsFile': imageIsFile,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  String toJson() => json.encode(toMap());
}
