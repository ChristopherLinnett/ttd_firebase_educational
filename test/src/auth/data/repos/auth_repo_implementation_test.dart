import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/core/enums/update_user.dart';
import 'package:ttd_firebase_educational/src/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ttd_firebase_educational/src/auth/data/models/user_model.dart';
import 'package:ttd_firebase_educational/src/auth/data/repos/auth_repo_implementation.dart';
import 'package:ttd_firebase_educational/src/auth/domain/repos/auth_repo.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource dataSource;
  late AuthRepoImplementaiton repoImplementation;
  const testUser = LocalUserModel.empty();
  const testUpdateUserAction = UpdateUserAction.email;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
    repoImplementation = AuthRepoImplementaiton(remoteDataSource: dataSource);
    registerFallbackValue(testUpdateUserAction);
  });

  test('should be a subclass of [AuthRepo]', () {
    expect(repoImplementation, isA<AuthRepo>());
  });
  group(
    'forgotPassword',
    () {
      test(
        'Should complete successfully and return void when server response is successful',
        () async {
          when(() => dataSource.forgotPassword(email: any(named: 'email')))
              .thenAnswer(
            (_) async => const Right<ServerException, void>(null),
          );
          final result = await repoImplementation.forgotPassword('email');
          expect(result, equals(const Right<dynamic, void>(null)));
          verify(
            () => dataSource.forgotPassword(email: 'email'),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
      test(
        'Should return [ServerFailure] with appropriate server response is failed',
        () async {
          when(() => dataSource.forgotPassword(email: 'email')).thenThrow(
            const ServerException(
              message: 'Invalid Response',
              statusCode: '404',
            ),
          );
          final result = await repoImplementation.forgotPassword('email');
          expect(
            result,
            equals(
              Left<ServerFailure, void>(
                ServerFailure(
                  message: 'Invalid Response',
                  statusCode: '404',
                ),
              ),
            ),
          );
          verify(
            () => dataSource.forgotPassword(email: 'email'),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
  group(
    'signUp',
    () {
      test(
        'Should complete successfully and return the new [LocalUserModel] when server response is successful',
        () async {
          when(
            () => dataSource.signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
              fullName: any(named: 'fullName'),
            ),
          ).thenAnswer(
            (_) async => Future.value(),
          );
          final result = await repoImplementation.signUp(
            email: testUser.email,
            password: 'password',
            fullName: testUser.fullName,
          );
          expect(
            result,
            equals(const Right<dynamic, void>(null)),
          );
          verify(
            () => dataSource.signUp(
              email: testUser.email,
              password: 'password',
              fullName: testUser.fullName,
            ),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
      test(
        'Should return [ServerFailure] with appropriate message server response is failed',
        () async {
          when(
            () => dataSource.signUp(
              email: testUser.email,
              password: 'password',
              fullName: testUser.fullName,
            ),
          ).thenThrow(
            const ServerException(
              message: 'Invalid Password Length',
              statusCode: '532',
            ),
          );
          final result = await repoImplementation.signUp(
            email: testUser.email,
            password: 'password',
            fullName: testUser.fullName,
          );
          expect(
            result,
            equals(
              Left<ServerFailure, void>(
                ServerFailure(
                  message: 'Invalid Password Length',
                  statusCode: '532',
                ),
              ),
            ),
          );
          verify(
            () => dataSource.signUp(
              email: testUser.email,
              password: 'password',
              fullName: testUser.fullName,
            ),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
  group(
    'signIn',
    () {
      test(
        'Should complete successfully and return the new [LocalUserModel] when server response is successful',
        () async {
          when(
            () => dataSource.signIn(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer(
            (_) async => Future.value(
              testUser,
            ),
          );
          final result = await repoImplementation.signIn(
            email: testUser.email,
            password: 'password',
          );
          expect(
            result,
            equals(const Right<dynamic, LocalUserModel>(testUser)),
          );
          verify(
            () => dataSource.signIn(
              email: testUser.email,
              password: 'password',
            ),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
      test(
        'Should return [ServerFailure] with appropriate message server response is failed',
        () async {
          when(
            () => dataSource.signIn(
              email: testUser.email,
              password: 'password',
            ),
          ).thenThrow(
            const ServerException(
              message: 'Invalid Password Length',
              statusCode: '532',
            ),
          );
          final result = await repoImplementation.signIn(
            email: testUser.email,
            password: 'password',
          );
          expect(
            result,
            equals(
              Left<ServerFailure, void>(
                ServerFailure(
                  message: 'Invalid Password Length',
                  statusCode: '532',
                ),
              ),
            ),
          );
          verify(
            () => dataSource.signIn(
              email: testUser.email,
              password: 'password',
            ),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
  group(
    'updateUser',
    () {
      registerFallbackValue(UpdateUserAction);
      test(
        'Should complete successfully and return void when server response is successful',
        () async {
          when(
            () => dataSource.updateUser(
              action: any(named: 'action'),
              userData: any<dynamic>(named: 'userData'),
            ),
          ).thenAnswer(
            (_) async => const Right<ServerException, void>(null),
          );
          final result = await repoImplementation.updateuser(
            action: UpdateUserAction.email,
            userData: 'test-email123@test.com',
          );
          expect(result, equals(const Right<dynamic, void>(null)));
          verify(
            () => dataSource.updateUser(
              action: UpdateUserAction.email,
              userData: 'test-email123@test.com',
            ),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
      test(
        'Should return [ServerFailure] with appropriate server response is failed',
        () async {
          when(
            () => dataSource.updateUser(
              action: any(named: 'action'),
              userData: any<dynamic>(named: 'userData'),
            ),
          ).thenThrow(
            const ServerException(
              message: 'Invalid Response',
              statusCode: '404',
            ),
          );
          final result = await repoImplementation.updateuser(
            action: UpdateUserAction.email,
            userData: 'test-email123@test.com',
          );
          expect(
            result,
            equals(
              Left<ServerFailure, void>(
                ServerFailure(
                  message: 'Invalid Response',
                  statusCode: '404',
                ),
              ),
            ),
          );
          verify(
            () => dataSource.updateUser(
              action: UpdateUserAction.email,
              userData: 'test-email123@test.com',
            ),
          ).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
}
