import 'package:consommateur/authentification/login.dart';
import 'package:consommateur/homepage/nosEntrepots.dart';
import 'package:consommateur/homepage/nosProduits.dart';
import 'package:consommateur/homepage/searchBar.dart';
import 'package:consommateur/homepage/topRow.dart';
import 'package:consommateur/models/consommateur.dart';
import 'package:consommateur/shared_preferences/consommateur_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<Consommateur?>? futureConsommateur;
  Consommateur? consommateur;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureConsommateur = ConsommateurDataManager.loadStoreData();
    _initClass();
  }

  Future<void> _initClass() async {
    consommateur = await futureConsommateur;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () async {
                // Effacer les données stockées et rediriger vers la page de connexion
                await ConsommateurDataManager.removeStoreData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.logout,
                size: 35,
                color: Colors.black,
              ),
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(
                  Icons.notifications,
                  size: 35,
                  color: Colors.black,
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopRow(
                name: (consommateur?.consommateurfirstname),
              ),
              const SizedBox(
                height: 40,
              ),
              const NosEntrepots(),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Nos produits",
                style: TextStyle(
                    fontFamily: "Poppins", fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(child: SearchBarTera()),
              const SizedBox(
                height: 20,
              ),
              const Center(child: NosProduits()),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    ));
  }
}
