//import 'package:flutter/material.dart';

import 'package:progetto_piattaforme/pages/shopping_cart.dart';

class Products {
  int prodottoId = 0;
  String nomeProdotto = "";
  String immagineProdotto = "";
  double peso = 0;
  double prezzo = 0.0;
  List<ShoppingCart> carrelli = [];
  String categoriaProdotto = "";
  String descrizioneProdotto = "";
  int quantitaTotale = 0;
  int quantitaRichiesta = 0;

  Products({
    required this.prodottoId,
    required this.nomeProdotto,
    required this.immagineProdotto,
    required this.peso,
    required this.prezzo,
    required this.categoriaProdotto,
    required this.descrizioneProdotto,
    required this.quantitaTotale,
    this.quantitaRichiesta = 0,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      prodottoId: json['prodottoId'],
      nomeProdotto: json['nomeProdotto'],
      immagineProdotto: json['immagineProdotto'],
      peso: json['peso'],
      prezzo: json['prezzo'],
      categoriaProdotto: json['categoriaProdotto'],
      descrizioneProdotto: json['descrizioneProdotto'],
      quantitaTotale: json['quantitaTotale'],
    );
  }

  Map<String, dynamic> toJson() => {
        "prodottoId": prodottoId,
        "nomeProdotto": nomeProdotto,
        "immagineProdotto": immagineProdotto,
        "peso": peso,
        "prezzo": prezzo,
        "categoriaProdotto": categoriaProdotto,
        "descrizioneProdotto": descrizioneProdotto,
        "quantitaTotale": quantitaTotale,
      };

  void setQuantitaRichiesta(int quantita) {
    quantitaRichiesta = quantita;
  }
}
