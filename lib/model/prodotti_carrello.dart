import 'package:progetto_piattaforme/model/products.dart';

class ProdottiCarrello {
  ProdottiCarrello({
    this.prodottoCarrelloId,
    required this.prodotto,
    required this.quantitaRichiesta,
  });

  int? prodottoCarrelloId;
  Products prodotto;
  int quantitaRichiesta;

  factory ProdottiCarrello.fromJson(Map<String, dynamic> json) =>
      ProdottiCarrello(
        prodottoCarrelloId: json["prodottoCarrelloId"],
        prodotto: Products.fromJson(json["prodotto"]),
        quantitaRichiesta: json["quantitaRichiesta"],
      );

  Map<String, dynamic> toJson() => {
        "prodottoCarrelloId": prodottoCarrelloId,
        "prodotto": prodotto.toJson(),
        "quantitaRichiesta": quantitaRichiesta,
      };
}
