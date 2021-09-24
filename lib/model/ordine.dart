// To parse this JSON data, do
//
//     final ordine = ordineFromJson(jsonString);

import 'dart:convert';

import 'package:progetto_piattaforme/model/products.dart';
import 'package:progetto_piattaforme/model/utente.dart';

Ordine ordineFromJson(String str) => Ordine.fromJson(json.decode(str));

String ordineToJson(Ordine data) => json.encode(data.toJson());

class Ordine {
  Ordine({
    this.ordineId,
    required this.dataCreazione,
    required this.totaleOrdine,
    required this.utente,
    required this.prodottiInOrdine,
  });

  int? ordineId;
  String dataCreazione;
  double totaleOrdine;
  Utente utente;
  List<ProdottiInOrdine> prodottiInOrdine;

  factory Ordine.fromJson(Map<String, dynamic> json) => Ordine(
        ordineId: json["ordineId"],
        dataCreazione: json["dataCreazione"],
        totaleOrdine: json["totaleOrdine"],
        utente: Utente.fromJson(json["utente"]),
        prodottiInOrdine: List<ProdottiInOrdine>.from(
            json["prodottiInOrdine"].map((x) => ProdottiInOrdine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ordineId": ordineId,
        "dataCreazione": dataCreazione,
        "totaleOrdine": totaleOrdine,
        "utente": utente.toJson(),
        "prodottiInOrdine":
            List<dynamic>.from(prodottiInOrdine.map((x) => x.toJson())),
      };
}

class ProdottiInOrdine {
  ProdottiInOrdine({
    required this.prodotto,
    required this.quantitaRichiesta,
  });

  Products prodotto;
  int quantitaRichiesta;

  factory ProdottiInOrdine.fromJson(Map<String, dynamic> json) =>
      ProdottiInOrdine(
        prodotto: Products.fromJson(json["prodotto"]),
        quantitaRichiesta: json["quantitaRichiesta"],
      );

  Map<String, dynamic> toJson() => {
        "prodotto": prodotto.toJson(),
        "quantitaRichiesta": quantitaRichiesta,
      };
}
