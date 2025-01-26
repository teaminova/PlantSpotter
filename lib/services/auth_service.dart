import 'package:flutter/material.dart';

class AuthService {
  bool isAuthenticated = false;

  Future<void> login(String email, String password) async {
    // Simulate authentication
    await Future.delayed(const Duration(seconds: 2));
    isAuthenticated = true;
  }

  Future<void> register(String email, String password) async {
    // Simulate registration
    await Future.delayed(const Duration(seconds: 2));
    isAuthenticated = true;
  }

  Future<void> logout() async {
    // Simulate logout
    await Future.delayed(const Duration(seconds: 1));
    isAuthenticated = false;
  }

  static String getCurrentUser() {
    return "jane.doe";
  }
}
