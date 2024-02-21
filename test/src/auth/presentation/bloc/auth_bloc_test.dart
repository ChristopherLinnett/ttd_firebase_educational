import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/src/auth/domain/entities/user.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/forgot_password.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/sign_in.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/sign_up.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/update_user.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/bloc/auth_bloc.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc authBloc;

  const testUser = LocalUser.empty();

  const testSignUpParams = SignUpParams.empty();
  const testUpdateUserParams = UpdateUserParams.empty();
  const testSignInParams = SignInParams.empty();

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });

  setUpAll(() {
    registerFallbackValue(testSignUpParams);
    registerFallbackValue(testUpdateUserParams);
    registerFallbackValue(testSignInParams);
  });

  tearDown(() => authBloc.close());

  test('initialState should be [AuthStateInitial]', () {
    expect(authBloc.state, AuthInitial());
  });

  final testServerFailure = ServerFailure(
    message: 'user-not-found',
    statusCode: 'There is no user corresponding to this identifier',
  );

  group(
    'SignInEvent',
    () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, SignedIn] when signIn succeeds',
        build: () {
          when(() => signIn(any()))
              .thenAnswer((_) async => const Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignInEvent(
            email: testUser.email,
            password: testSignInParams.password,
          ),
        ),
        expect: () => [const AuthLoading(), const SignedIn(testUser)],
        verify: (bloc) {
          verify(
            () => signIn(
              SignInParams(
                email: testUser.email,
                password: testSignInParams.password,
              ),
            ),
          ).called(1);
          verifyNoMoreInteractions(signIn);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] when Signin fails',
        build: () {
          when(() => signIn(any()))
              .thenAnswer((_) async => Left(testServerFailure));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignInEvent(
            email: testSignInParams.email,
            password: testSignInParams.password,
          ),
        ),
        expect: () => [
          const AuthLoading(),
          AuthError(testServerFailure.errorMessage),
        ],
        verify: (_) {
          verify(() => signIn(testSignInParams)).called(1);
          verifyNoMoreInteractions(signIn);
        },
      );
    },
  );

  group(
    'SignUpEvent',
    () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, SignedUp] when signUp succeeds',
        build: () {
          when(() => signUp(any())).thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignUpEvent(
            fullName: testUser.fullName,
            email: testUser.email,
            password: testSignUpParams.password,
          ),
        ),
        expect: () => [const AuthLoading(), const SignedUp()],
        verify: (bloc) {
          verify(
            () => signUp(
              SignUpParams(
                fullName: testUser.fullName,
                email: testUser.email,
                password: testSignUpParams.password,
              ),
            ),
          ).called(1);
          verifyNoMoreInteractions(signUp);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] when SignUp fails',
        build: () {
          when(() => signUp(any()))
              .thenAnswer((_) async => Left(testServerFailure));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignUpEvent(
            fullName: testSignUpParams.fullName,
            email: testSignUpParams.email,
            password: testSignUpParams.password,
          ),
        ),
        expect: () => [
          const AuthLoading(),
          AuthError(testServerFailure.message),
        ],
        verify: (_) {
          verify(() => signUp(testSignUpParams)).called(1);
          verifyNoMoreInteractions(signUp);
        },
      );
    },
  );

  group(
    'ForgotPasswordEvent',
    () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, ForgotPasswordSent] when signIn succeeds',
        build: () {
          when(() => forgotPassword(any()))
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          ForgotPasswordEvent(
            email: testUser.email,
          ),
        ),
        expect: () => [const AuthLoading(), const ForgotPasswordSent()],
        verify: (bloc) {
          verify(
            () => forgotPassword(
              testUser.email,
            ),
          ).called(1);
          verifyNoMoreInteractions(forgotPassword);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] when forgotPassword fails',
        build: () {
          when(() => forgotPassword(any()))
              .thenAnswer((_) async => Left(testServerFailure));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          ForgotPasswordEvent(
            email: testSignInParams.email,
          ),
        ),
        expect: () => [
          const AuthLoading(),
          AuthError(testServerFailure.message),
        ],
        verify: (_) {
          verify(() => forgotPassword(testUser.email)).called(1);
          verifyNoMoreInteractions(forgotPassword);
        },
      );
    },
  );

  group(
    'UpdateUserEvent',
    () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, UpdatedUser] when updateUser succeeds',
        build: () {
          when(() => updateUser(any()))
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdateUserEvent(
            action: testUpdateUserParams.action,
            userData: testUpdateUserParams.userData,
          ),
        ),
        expect: () => [const AuthLoading(), const UserUpdated()],
        verify: (bloc) {
          verify(
            () => updateUser(
              UpdateUserParams(
                action: testUpdateUserParams.action,
                userData: testUpdateUserParams.userData,
              ),
            ),
          ).called(1);
          verifyNoMoreInteractions(updateUser);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] when UpdateUser fails',
        build: () {
          when(() => updateUser(any()))
              .thenAnswer((_) async => Left(testServerFailure));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdateUserEvent(
            action: testUpdateUserParams.action,
            userData: testUpdateUserParams.userData,
          ),
        ),
        expect: () => [
          const AuthLoading(),
          AuthError(testServerFailure.message),
        ],
        verify: (_) {
          verify(() => updateUser(testUpdateUserParams)).called(1);
          verifyNoMoreInteractions(updateUser);
        },
      );
    },
  );
}
