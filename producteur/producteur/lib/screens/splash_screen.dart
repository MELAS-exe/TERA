import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:producteur/screens/navigationBar.dart';

import '../shared_preferences/producteur_data_manager.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogedin = false;

  /// Méthode pour vérifier si l'utilisateur est connecté
  Future<void> setDetails() async {
    isLogedin = await ProducteurDataManager.hasStoreData();
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Méthode pour initialiser l'application
  Future<void> _initializeApp() async {
    await setDetails(); // Attendre que la vérification soit terminée
    Timer(const Duration(seconds: 3), () {
      if (isLogedin) {
        // Navigation avec Get
        Get.off(() => const NavBar(currentIndex: 1,));
      } else {
        // Redirection vers l'écran de connexion
        Get.off(() => const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/Tera2.png', width: 500),
      ),
    );
  }
}
