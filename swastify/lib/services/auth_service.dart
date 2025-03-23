import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:swastify/provider/login_provider.dart';
import 'dart:convert';

Future<UserCredential> signInWithEmailPassword(
  String email,
  String password,
) async {
  try {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  } catch (e) {
    print('Email/Password Sign-In Error: $e');
    rethrow;
  }
}

Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      print('Google Sign-In cancelled by user.');
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    print("Login Successful");
    return userCredential;
  } catch (e) {
    print('Google Sign-In Error: $e');
    rethrow;
  }
}

Future<http.Response> verifyUser({
  required String url,
  required Map<String, dynamic> body,
  required LoginProvider loginProvider,
}) async {
  final token = loginProvider.token;

  if (token == null || token.isEmpty) {
    throw Exception("No auth token found. Please login first.");
  }

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );

  return response;
}

// Future<http.Response> migrateDbWithUser({
//   required String url,
//   required Map<String, dynamic> body,
//   required LoginProvider loginProvider,
// }) async {
//   final token = loginProvider.token;

//   if (token == null || token.isEmpty) {
//     throw Exception("No auth token found. Please login first.");
//   }

//   final response = await http.post(
//     Uri.parse(url),
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     },
//     body: jsonEncode(body),
//   );
// }
