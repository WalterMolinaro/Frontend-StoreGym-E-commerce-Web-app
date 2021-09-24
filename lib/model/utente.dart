import 'dart:convert';

import 'package:progetto_piattaforme/pages/shopping_cart.dart';

Utente utenteFromJson(String str) => Utente.fromJson(json.decode(str));

String utenteToJson(Utente data) => json.encode(data.toJson());

class Utente {
  Utente({
    this.idUtente,
    required this.nomeUtente,
    required this.cognomeUtente,
    required this.telefonoUtente,
    required this.indirizzoUtente,
    required this.email,
    required this.password,
    required this.carrello,
    required this.dataRegistrazione,
  });

  int? idUtente;
  String nomeUtente;
  String cognomeUtente;
  String telefonoUtente;
  String indirizzoUtente;
  String email;
  String password;
  ShoppingCart carrello;
  String dataRegistrazione;

  factory Utente.fromJson(Map<String, dynamic> json) => Utente(
        idUtente: json["idUtente"],
        nomeUtente: json["nomeUtente"],
        cognomeUtente: json["cognomeUtente"],
        telefonoUtente: json["telefonoUtente"],
        indirizzoUtente: json["indirizzoUtente"],
        email: json["email"],
        password: json["password"],
        carrello: ShoppingCart.fromJson(json["carrello"]),
        dataRegistrazione: json["dataRegistrazione"],
      );

  Map<String, dynamic> toJson() => {
        "idUtente": idUtente,
        "nomeUtente": nomeUtente,
        "cognomeUtente": cognomeUtente,
        "telefonoUtente": telefonoUtente,
        "indirizzoUtente": indirizzoUtente,
        "email": email,
        "password": password,
        "carrello": carrello.toJson(),
        "dataRegistrazione": dataRegistrazione
      };
}
