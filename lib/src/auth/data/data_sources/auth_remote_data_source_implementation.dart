import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';
import 'package:ttd_firebase_educational/core/enums/update_user.dart';
import 'package:ttd_firebase_educational/core/utils/constants.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';
import 'package:ttd_firebase_educational/src/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ttd_firebase_educational/src/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  AuthRemoteDataSourceImplementation({
    required FirebaseAuth authClient,
    required FirebaseFirestore dbClient,
    required FirebaseStorage cloudStoreClient,
  })  : _authClient = authClient,
        _dbClient = dbClient,
        _cloudStoreClient = cloudStoreClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _dbClient;
  final FirebaseStorage _cloudStoreClient;

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        throw const ServerException(
          message: 'Please Try Again Later',
          statusCode: 'Unknown Error',
        );
      }
      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      // If doesn't exist
      await _setUserData(user, email);

      userData = await _getUserData(user.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);
      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.displayName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData});

        case UpdateUserAction.email:
          await _authClient.currentUser
              ?.verifyBeforeUpdateEmail(userData as String);
          await _updateUserData({'email': userData});

        case UpdateUserAction.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              message: 'User Does Not Exist',
              statusCode: 'Insufficient Permission',
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _authClient.currentUser!.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );
          await _authClient.currentUser!
              .updatePassword(newData['newPassword'] as String);

        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});

        case UpdateUserAction.profilePic:
          final ref = _cloudStoreClient
              .ref()
              .child('profile_pics/${_authClient.currentUser?.uid}');
          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) {
    return _dbClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(
    User user,
    String fallbackEmail,
  ) async {
    await _dbClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            points: 0,
            fullName: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _dbClient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}
