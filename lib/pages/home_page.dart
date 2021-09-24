import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:progetto_piattaforme/custom_widget/build_last_arrivals.dart';
import 'package:progetto_piattaforme/dto/product_details_dto.dart';
import 'package:progetto_piattaforme/model/products.dart';

import 'package:progetto_piattaforme/pages/product_details.dart';
import 'package:progetto_piattaforme/pages/salute_products.dart';
import 'package:progetto_piattaforme/pages/sviluppo_muscolare_products.dart';

import 'package:progetto_piattaforme/responsive/layout_responsive.dart';

import '../custom_widget/build_app_bar.dart';
import '../custom_widget/build_categories.dart';
import 'attrezzi_products.dart';

const List<String> imagesCategory = [
  "content/images/sviluppo_muscolare.jpg",
  "content/images/attrezzi.jpg",
  "content/images/salute.jpg",
];

class HomePage extends StatelessWidget {
  static const String routeName = '/';
  final Future<List<Products>> productsFuture;
  const HomePage({Key? key, required this.productsFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              BuildAppBar(),
              Divider(),
              LayoutResponsive(
                tablet: Wrap(
                  children: PromoInTab(context),
                ),
                desktop: PromoInDesk(context),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Categorie",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 5.0),
                            blurRadius: 3.0,
                          ),
                          Shadow(
                            offset: Offset(10.0, 5.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              LayoutResponsive(
                tablet: Wrap(
                  children: [
                    BuildCategories(
                      pathImage: imagesCategory[0],
                      text: Text(
                        "Sviluppo Muscolare",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.amber[100],
                        ),
                      ),
                      onTap: () => {
                        Navigator.pushNamed(
                            context, SviluppoMuscolareProducts.routeName)
                      },
                    ),
                    BuildCategories(
                      pathImage: imagesCategory[1],
                      text: Text(
                        "Attrezzi",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.amber[100],
                        ),
                      ),
                      onTap: () => {
                        Navigator.pushNamed(context, AttrezziProducts.routeName)
                      },
                    ),
                    BuildCategories(
                      pathImage: imagesCategory[2],
                      text: Text(
                        "Salute",
                        style: TextStyle(
                          color: Colors.amber[100],
                          fontSize: 20,
                        ),
                      ),
                      onTap: () => {
                        Navigator.pushNamed(context, SaluteProducts.routeName)
                      },
                    ),
                  ],
                ),
                desktop: Row(
                  children: [
                    Expanded(
                      child: BuildCategories(
                        pathImage: imagesCategory[0],
                        text: Text(
                          "Sviluppo Muscolare",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.amber[100],
                          ),
                        ),
                        onTap: () => {
                          Navigator.pushNamed(
                              context, SviluppoMuscolareProducts.routeName)
                        },
                      ),
                    ),
                    Expanded(
                      child: BuildCategories(
                        pathImage: imagesCategory[1],
                        text: Text(
                          "Attrezzi",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.amber[100],
                          ),
                        ),
                        onTap: () => {
                          Navigator.pushNamed(
                              context, AttrezziProducts.routeName)
                        },
                      ),
                    ),
                    Expanded(
                      child: BuildCategories(
                        pathImage: imagesCategory[2],
                        text: Text(
                          "Salute",
                          style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 20,
                          ),
                        ),
                        onTap: () => {
                          Navigator.pushNamed(context, SaluteProducts.routeName)
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Ultimi Arrivi",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 5.0),
                            blurRadius: 3.0,
                          ),
                          Shadow(
                            offset: Offset(10.0, 5.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              LayoutResponsive(
                tablet: Wrap(
                  children: <Widget>[
                    BuildLastArrivals(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetails.routeName,
                            arguments: ProductDetailsDTO(
                                product: Products(
                                    prodottoId: 30,
                                    categoriaProdotto: "INTEGRATORI",
                                    quantitaTotale: 100,
                                    nomeProdotto: "SHAPE CAPS",
                                    peso: 2,
                                    descrizioneProdotto:
                                        "Per ottenere con facilità un corpo da sogno.",
                                    prezzo: 24.99,
                                    immagineProdotto:
                                        "content/images/shape_caps.jpg")));
                      },
                      image: Image.asset(
                        "content/images/shape_caps.jpg",
                        scale: 1.5,
                      ),
                      title: Text(
                        "SHAPE CAPS",
                        style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      description: Text(
                        "Per ottenere con facilità\nun corpo da sogno.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      price: Text(
                        "24.99€",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    BuildLastArrivals(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetails.routeName,
                            arguments: ProductDetailsDTO(
                                product: Products(
                                    prodottoId: 34,
                                    categoriaProdotto: "INTEGRATORI",
                                    quantitaTotale: 100,
                                    nomeProdotto: "OMEGA 3",
                                    peso: 2,
                                    descrizioneProdotto:
                                        "La forza vegana per cervello e occhi.",
                                    prezzo: 34.99,
                                    immagineProdotto:
                                        "content/images/omega_3.jpg")));
                      },
                      image: Image.asset(
                        "content/images/omega_3.jpg",
                        scale: 1.5,
                      ),
                      title: Text(
                        "OMEGA 3 VEGAN",
                        style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      description: Text(
                        "La forza vegana\nper cervello e occhi.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      price: Text(
                        "34.99€",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    BuildLastArrivals(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetails.routeName,
                            arguments: ProductDetailsDTO(
                                product: Products(
                                    prodottoId: 3,
                                    categoriaProdotto: "PESI",
                                    quantitaTotale: 100,
                                    nomeProdotto: "KETTLEBELL",
                                    peso: 20,
                                    descrizioneProdotto:
                                        "Ideali per allenare forza ed esplosività di tutto il corpo.",
                                    prezzo: 49.99,
                                    immagineProdotto:
                                        "content/images/kettlebell_hero.jpg")));
                      },
                      image: Image.asset(
                        "content/images/kettlebell_hero.jpg",
                        scale: 1.5,
                      ),
                      title: Text(
                        "KETTLEBELL",
                        style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      description: Text(
                        "Ideali per allenare forza\ned esplosività di tutto il corpo.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      price: Text(
                        "49.99€",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    BuildLastArrivals(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetails.routeName,
                            arguments: ProductDetailsDTO(
                                product: Products(
                                    prodottoId: 13,
                                    categoriaProdotto: "ATTREZZI",
                                    quantitaTotale: 100,
                                    nomeProdotto: "POWER PERSONAL SUPERIOR",
                                    peso: 0,
                                    descrizioneProdotto:
                                        "La soluzione principale\nper allenare " +
                                            "tutti i muscoli del corpo a casa, in linea con l' attuale tendenza verso allenamenti professionali e dalle prestazioni elevate.",
                                    prezzo: 49.99,
                                    immagineProdotto:
                                        "content/images/panca.jpg")));
                      },
                      image: Image.asset(
                        "content/images/panca.jpg",
                        scale: 1.5,
                      ),
                      title: Text(
                        "POWER PERSONAL SUPERIOR",
                        style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      description: Text(
                        "La soluzione principale\nper allenare " +
                            "tutti i muscoli del corpo...",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      price: Text(
                        "9999.00€",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                desktop: Row(
                  children: <Widget>[
                    Expanded(
                      child: BuildLastArrivals(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: ProductDetailsDTO(
                                  product: Products(
                                      prodottoId: 30,
                                      categoriaProdotto: "INTEGRATORI",
                                      quantitaTotale: 100,
                                      nomeProdotto: "SHAPE CAPS",
                                      peso: 2,
                                      descrizioneProdotto:
                                          "Per ottenere con facilità un corpo da sogno.",
                                      prezzo: 24.99,
                                      immagineProdotto:
                                          "content/images/shape_caps.jpg")));
                        },
                        image: Image.asset(
                          "content/images/shape_caps.jpg",
                          scale: 1.5,
                        ),
                        title: Text(
                          "SHAPE CAPS",
                          style: TextStyle(
                              color: Colors.amber[100],
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        description: Text(
                          "Per ottenere con facilità\nun corpo da sogno.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        price: Text(
                          "24.99€",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BuildLastArrivals(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: ProductDetailsDTO(
                                  product: Products(
                                      prodottoId: 34,
                                      categoriaProdotto: "INTEGRATORI",
                                      quantitaTotale: 100,
                                      nomeProdotto: "OMEGA 3",
                                      peso: 2,
                                      descrizioneProdotto:
                                          "La forza vegana per cervello e occhi.",
                                      prezzo: 34.99,
                                      immagineProdotto:
                                          "content/images/omega_3.jpg")));
                        },
                        image: Image.asset(
                          "content/images/omega_3.jpg",
                          scale: 1.5,
                        ),
                        title: Text(
                          "OMEGA 3 VEGAN",
                          style: TextStyle(
                              color: Colors.amber[100],
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        description: Text(
                          "La forza vegana\nper cervello e occhi.",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        price: Text(
                          "34.99€",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BuildLastArrivals(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: ProductDetailsDTO(
                                  product: Products(
                                      prodottoId: 3,
                                      categoriaProdotto: "PESI",
                                      quantitaTotale: 100,
                                      nomeProdotto: "KETTLEBELL",
                                      peso: 20,
                                      descrizioneProdotto:
                                          "Ideali per allenare forza ed esplosività di tutto il corpo.",
                                      prezzo: 49.99,
                                      immagineProdotto:
                                          "content/images/kettlebell_hero.jpg")));
                        },
                        image: Image.asset(
                          "content/images/kettlebell_hero.jpg",
                          scale: 1.5,
                        ),
                        title: Text(
                          "KETTLEBELL",
                          style: TextStyle(
                              color: Colors.amber[100],
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        description: Text(
                          "Ideali per allenare forza\ned esplosività di tutto il corpo.",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        price: Text(
                          "49.99€",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BuildLastArrivals(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: ProductDetailsDTO(
                                  product: Products(
                                      prodottoId: 13,
                                      categoriaProdotto: "ATTREZZI",
                                      quantitaTotale: 100,
                                      nomeProdotto: "POWER PERSONAL SUPERIOR",
                                      peso: 0,
                                      descrizioneProdotto:
                                          "La soluzione principale\nper allenare " +
                                              "tutti i muscoli del corpo a casa, in linea con l' attuale tendenza verso allenamenti professionali e dalle prestazioni elevate.",
                                      prezzo: 49.99,
                                      immagineProdotto:
                                          "content/images/panca.jpg")));
                        },
                        image: Image.asset(
                          "content/images/panca.jpg",
                          scale: 1.5,
                        ),
                        title: Text(
                          "POWER PERSONAL SUPERIOR",
                          style: TextStyle(
                              color: Colors.amber[100],
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        description: Text(
                          "La soluzione principale\nper allenare " +
                              "tutti i muscoli del corpo...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        price: Text(
                          "9999.00€",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ), // qua chiudeva il LayoutResponsive

              Divider(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Hai delle domande sul tuo ordine?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Il nostro team di assistenza è a tua completa disposizione: " +
                          "FAQ & Assistenza " +
                          "service@storegym.it",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget PromoInDesk(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "content/images/immagine_home_page.jpg",
            scale: 1.5,
            width: 800,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Inizia la giornata\ncon la giusta energia\n" +
                      "grazie alle Breakfast Bowl!",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.amber[100],
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Bio, nutriente e facilissima\nda preparare," +
                        " non solo soddisfa gli occhi" +
                        " ma\nti da tutta l'energia necessaria" +
                        " per affrontare la giornata.",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.amber[100],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 30, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 20),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ProductDetails.routeName,
                                arguments: ProductDetailsDTO(
                                    product: Products(
                                        prodottoId: 9,
                                        categoriaProdotto: "INTEGRATORI",
                                        quantitaTotale: 100,
                                        nomeProdotto: "BREAKFAST BOWL",
                                        peso: 0.5,
                                        descrizioneProdotto:
                                            "Inizia la giornata con i superfood",
                                        prezzo: 19.99,
                                        immagineProdotto:
                                            "content/images/breakfast_bowl2.jpg")));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, right: 20, left: 20),
                            child: Text(
                              "Acquista ora",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: non_constant_identifier_names
List<Widget> PromoInTab(BuildContext context) {
  return <Widget>[
    ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "content/images/immagine_home_page.jpg",
              fit: BoxFit.fitWidth,
              scale: 1.5,
              width: 800,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Inizia la giornata con la giusta energia" +
                  " grazie alle Breakfast Bowl!",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.amber[100],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Bio, nutriente e facilissima da preparare," +
                  " non solo soddisfa gli occhi" +
                  " ma ti da tutta l'energia necessaria" +
                  " per affrontare la giornata.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.amber[100],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 20),
                    onPressed: () {
                      Navigator.pushNamed(context, ProductDetails.routeName,
                          arguments: ProductDetailsDTO(
                              product: Products(
                                  prodottoId: 9,
                                  categoriaProdotto: "INTEGRATORI",
                                  quantitaTotale: 100,
                                  nomeProdotto: "BREAKFAST BOWL",
                                  peso: 0.5,
                                  descrizioneProdotto:
                                      "Inizia la giornata con i superfood",
                                  prezzo: 19.99,
                                  immagineProdotto:
                                      "content/images/breakfast_bowl2.jpg")));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 170, left: 170),
                      child: Text(
                        "Acquista ora",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    )
  ];
}
