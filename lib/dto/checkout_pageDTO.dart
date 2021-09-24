import 'package:progetto_piattaforme/model/ordine.dart';
import 'package:progetto_piattaforme/model/utente.dart';

import 'package:progetto_piattaforme/pages/shopping_cart.dart';

class CheckOutPageDto {
  Ordine ordine = new Ordine(
    dataCreazione: "",
    totaleOrdine: 0.0,
    prodottiInOrdine: [],
    utente: new Utente(
        nomeUtente: "tappo",
        cognomeUtente: "tappo",
        telefonoUtente: "-1",
        indirizzoUtente: "tappo",
        email: "tappo",
        password: "tappo",
        carrello: new ShoppingCart(carrelloId: -1, listProducts: []),
        dataRegistrazione: ""),
  );

  CheckOutPageDto({required this.ordine});
}
