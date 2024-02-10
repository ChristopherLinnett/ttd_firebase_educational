import 'package:ttd_firebase_educational/core/utils/type_defs.dart';
import 'package:ttd_firebase_educational/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupIds,
    super.enrolledCourseIds,
    super.followers,
    super.following,
    super.profilePic,
    super.bio,
  });
  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['fullName'] as String,

          ///Note numbers coming from external sources may not be seen as ints straight up, use num then convert to int
          points: (map['points'] as num).toInt(),
          groupIds: List<String>.from(map['groupIds'] as List<dynamic>),
          enrolledCourseIds:
              List<String>.from(map['enrolledCourseIds'] as List<dynamic>),

          ///Note 2 different methods for casting data that comes from a server as lists may not come in expected format
          followers: List<String>.from(map['followers'] as List<dynamic>),
          following: (map['following'] as List<dynamic>).cast<String>(),
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
        );

  const LocalUserModel.empty()
      : this(uid: '', email: '', points: 0, fullName: '');

  LocalUserModel copyWith({
    String? uid,
    String? email,
    int? points,
    String? fullName,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? followers,
    List<String>? following,
    String? profilePic,
    String? bio,
  }) =>
      LocalUserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        points: points ?? this.points,
        fullName: fullName ?? this.fullName,
        groupIds: groupIds ?? this.groupIds,
        enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        profilePic: profilePic ?? this.profilePic,
        bio: bio ?? this.bio,
      );

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'points': points,
      'groupIds': groupIds,
      'enrolledCourseIds': enrolledCourseIds,
      'followers': followers,
      'following': following,
      'profilePic': profilePic,
      'bio': bio,
    };
  }
}
