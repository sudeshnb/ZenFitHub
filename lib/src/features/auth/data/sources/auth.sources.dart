import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zen_fit_hub/src/core/config/database.helper.dart';
import 'package:zen_fit_hub/src/core/error/error.dart';
import 'package:zen_fit_hub/src/core/network/network_info.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';
import 'cache.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    CacheClient? cache,
    auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// User cache key.
  /// Should only be used for testing purposes.
  ///
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of User which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits User.empty if the user is not authenticated.
  ///
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to User.empty] if there is no cached user.
  ///
  UserModel get currentUser {
    return _cache.read<UserModel>(key: userCacheKey) ?? UserModel.empty;
  }

  /// Creates a new user with the provided email and password].
  ///
  /// Throws a SignUpWithEmailAndPasswordFailure if an exception occurs.
  ///
  EitherString<String> register(String email, String pass) async {
    try {
      if (await NetworkInfo.isConnected) {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: pass);
        await reload();
        return Left(_firebaseAuth.currentUser!.uid);
      } else {
        return Right(FailuresToString.message(ServerFailure()));
      }
    } on auth.FirebaseAuthException catch (e) {
      return Right(SignUpWithEmailAndPasswordFailure.fromCode(e.code).message);
    } catch (x) {
      return Right(FailuresToString.message(UnexpectedFailure()));
    }
  }

  EitherString<bool> loginWithFacebook() async {
    try {
      if (await NetworkInfo.isConnected) {
        // final LoginResult loginResult = await FacebookAuth.instance.login();
        //    // Create a credential from the access token
        // final auth.OAuthCredential facebookAuthCredential =
        //     auth.FacebookAuthProvider.credential(
        //         loginResult.accessToken!.token);

        // await auth.FirebaseAuth.instance
        //     .signInWithCredential(facebookAuthCredential);

        return const Left(true);
      } else {
        return Right(FailuresToString.message(ServerFailure()));
      }
    } on auth.FirebaseAuthException catch (e) {
      return Right(SignUpWithEmailAndPasswordFailure.fromCode(e.code).message);
    } catch (_) {
      return Right(FailuresToString.message(UnexpectedFailure()));
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a LogInWithGoogleFailure if an exception occurs.
  ///
  EitherString<bool> loginwithGoogle() async {
    try {
      late final auth.AuthCredential credential;

      if (await NetworkInfo.isConnected) {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _firebaseAuth.signInWithCredential(credential);

        return const Left(true);
      } else {
        return Right(FailuresToString.message(ServerFailure()));
      }
    } on auth.FirebaseAuthException catch (e) {
      return Right(LogInWithGoogleFailure.fromCode(e.code).message);
    } catch (e) {
      return Right(FailuresToString.message(UnexpectedFailure()));
    }
  }

  Future<void> reload() async {
    await _firebaseAuth.currentUser?.reload();
  }

  ///
  /// Signs in with the provided email and password.
  ///
  /// Throws a LogInWithEmailAndPasswordFailure if an exception occurs.
  ///
  EitherString<String> logIn(String email, String pass) async {
    try {
      if (await NetworkInfo.isConnected) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        await reload();
        return Left(_firebaseAuth.currentUser!.uid);
      } else {
        return Right(FailuresToString.message(ServerFailure()));
      }
    } on auth.FirebaseAuthException catch (e) {
      log(e.code);
      return Right(LogInWithEmailAndPasswordFailure.fromCode(e.code).message);
    } catch (_) {
      return Right(FailuresToString.message(UnexpectedFailure()));
    }
  }

  EitherString<bool> forgotPassword(String email) async {
    try {
      if (await NetworkInfo.isConnected) {
        return await _firebaseAuth
            .sendPasswordResetEmail(email: email)
            .onError((error, stackTrace) => const Left(false))
            .then((value) => const Left(true));
      } else {
        return Right(FailuresToString.message(ServerFailure()));
      }
    } on auth.FirebaseAuthException catch (e) {
      return Right(LogInWithEmailAndPasswordFailure.fromCode(e.code).message);
    } catch (_) {
      return Right(FailuresToString.message(UnexpectedFailure()));
    }
  }

  /// Signs out the current user which will emit
  /// User.empty from the user Stream.
  ///
  /// Throws a LogOutFailure if an exception occurs.
  ///
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw UnexpectedFailure();
    }
  }

  Future<void> delete() async {
    try {
      await DatabaseHelper.instance.delete();
      await _firebaseAuth.currentUser!.delete();
      await _firebaseAuth.signOut();
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  ///
}

extension on auth.User {
  ///
  /// Maps a firebase_auth.User into a User.
  ///
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
      image: photoURL,
    );
  }
}
