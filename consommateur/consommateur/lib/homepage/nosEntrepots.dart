import 'package:consommateur/repository/consommateur_repository.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';
import 'package:consommateur/homepage/entrepot/entrepot.dart';
import '../models/Entrepot.dart';

class NosEntrepots extends StatefulWidget {
  const NosEntrepots({super.key});

  @override
  State<NosEntrepots> createState() => _NosEntrepotsState();
}

class _NosEntrepotsState extends State<NosEntrepots> {
  Future<List<EntrepotClass>?>? futureEntrepots;
  List<EntrepotClass>? entrepotList;
  Future<List<String>?>? futureProduit;
  List<String>? produits;
  List<List<String>?>? listProduitsEntrepot;

  @override
  void initState() {
    super.initState();
    _loadEntrepot();
  }

  Future<void> _loadEntrepot() async {
    futureEntrepots = ConsommateurRepository().getAllEntrepot();
    futureEntrepots?.then((entrepots) {
      setState(() {
        entrepotList = entrepots ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nos entrepôts",
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: entrepotList != null && entrepotList!.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: entrepotList!.map((entrepot) {
                      futureProduit = ConsommateurRepository()
                          .getDistinctProductTypes(entrepot.entrepotid);
                      futureProduit?.then((produitList) {
                        setState(() {
                          produits = produitList ??
                              []; // Initialement, tous les entrepôts sont affichés
                        });
                      });
                      return EntrePotItem(
                          nom: (entrepot.entrepotnom).toString(),
                          imagePath: 'assets/keur-massar.jpg',
                          produits: produits,
                          id: (entrepot.entrepotid).toString());
                    }).toList()),
                  )
                : Column(
                    children: [
                      Image.asset(
                        "assets/undraw_No_data_re_kwbl.png",
                        scale: 5,
                      ),
                      const Text("Auncun entrepôt disponible"),
                    ],
                  ))
      ],
    );
  }
}

class EntrePotItem extends StatefulWidget {
  final String nom;
  final String imagePath;
  final List<String>? produits;
  final String id;
  const EntrePotItem(
      {super.key,
      required this.nom,
      required this.imagePath,
      required this.produits,
      required this.id});

  @override
  State<EntrePotItem> createState() => _EntrePotItemState();
}

class _EntrePotItemState extends State<EntrePotItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Entrepot(name: widget.nom, id: widget.id)));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
        width: Responsive().width(context, 1.2),
        height: Responsive().height(context, 4.5),
        decoration: BoxDecoration(
            color: teraOrange, borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
              color: teraDark, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.imagePath,
                    width: 100,
                    height: 130,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nom,
                    style: const TextStyle(
                        color: teraOrange,
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Produits disponibles",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children:
                        widget.produits != null && widget.produits!.isNotEmpty
                            ? widget.produits!.map((produit) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: Responsive().width(context, 10),
                                  height: Responsive().width(context, 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ImageProduct(
                                    itemType: produit,
                                    imageScale: 18,
                                  ),
                                );
                              }).toList()
                            : [
                                const Text(
                                  '',
                                ),
                              ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
