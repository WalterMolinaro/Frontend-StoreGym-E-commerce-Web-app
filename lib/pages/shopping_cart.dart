import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/dto/checkout_pageDTO.dart';
import 'package:progetto_piattaforme/model/ordine.dart';

import 'package:progetto_piattaforme/model/prodotti_carrello.dart';
import 'package:intl/intl.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/user_login_page.dart';

import 'checkout_page.dart';

class ShoppingCart extends StatefulWidget {
  static const String routeName = 'Carrello';
  final int carrelloId;
  static int staticIdCart = 0;
  final List<ProdottiCarrello> listProducts = [];
  static List<ProdottiCarrello> staticListProducts = [];

  // ignore: non_constant_identifier_names
  static bool CHIAMATO = false;

  ShoppingCart({
    Key? key,
    required this.carrelloId,
    required List<ProdottiCarrello> listProducts,
  }) : super(key: key);

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
      carrelloId: json["carrelloId"],
      listProducts: List<ProdottiCarrello>.from(
          json["prodottiCarrello"].map((x) => ProdottiCarrello.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "carrelloId": carrelloId,
        "prodottiCarrello":
            List<dynamic>.from(staticListProducts.map((x) => x.toJson())),
      };

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ProdottiCarrello> prodottiCarrello = [];

  @override
  void initState() {
    super.initState();
    prodottiCarrello = ShoppingCart.staticListProducts;
  }

  showSnackBar(context, ProdottiCarrello prodotto, index) {
    Scaffold.of(context)
        // ignore: deprecated_member_use
        .showSnackBar(SnackBar(
            content: Text(
      "Il prodotto: ${prodotto.prodotto.nomeProdotto} è stato rimosso dal carrello!",
      style: TextStyle(fontWeight: FontWeight.bold),
    )));
  }

  removeProdottoCarrello(int index) {
    setState(() {
      ProdottiCarrello prodRimosso = prodottiCarrello.removeAt(index);
      for (int i = 0; i < ShoppingCart.staticListProducts.length; i++)
        if (prodRimosso.prodotto.prodottoId ==
            ShoppingCart.staticListProducts[i].prodotto.prodottoId) {
          ShoppingCart.staticListProducts.removeAt(i);
          break;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShoppingCart.staticListProducts.length == 0) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "content/images/sfondo_home.jpg",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                BuildAppBar(),
                Divider(),
                Container(
                    height: 500,
                    child: Center(
                      child: Text(
                        "Il TUO CARRELLO E' VUOTO",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.green,
                          shadows: <Shadow>[
                            Shadow(offset: Offset(1, 10), blurRadius: 8),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            BuildAppBar(),
            Divider(),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Articoli nel carrello",
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
            Flexible(
              child: showList(),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Totale",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Text("${calcolaTotale()}€")),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 20),
                    onPressed: () {
                      Ordine ordine = createOrder();
                      if (UserLoginPage.STATUS_USER)
                        Navigator.pushNamed(context, CheckOutPage.routeName,
                            arguments: CheckOutPageDto(ordine: ordine));
                      else
                        Navigator.pushNamed(context, UserLoginPage.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 90, left: 90),
                      child: Text(
                        "Vai alla cassa",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ],
        )),
      );
    }
  }

  ListView showList() {
    return ListView.builder(
        padding: EdgeInsets.all(18),
        itemCount: prodottiCarrello.length,
        itemBuilder: (BuildContext context, int index) {
          return rowItem(index, context);
        });
  }

  Widget deleteBgItem() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget rowItem(int index, BuildContext context) {
    return Dismissible(
      background: deleteBgItem(),
      key: Key(prodottiCarrello[index].prodotto.prodottoId.toString()),
      onDismissed: (direction) async {
        var prodotto = prodottiCarrello[index];
        int idProdotto = prodottiCarrello[index].prodotto.prodottoId;
        if (UserLoginPage.STATUS_USER)
          await RestClient.deletedProductInCarts(
              ShoppingCart.staticIdCart, idProdotto);

        removeProdottoCarrello(index);

        showSnackBar(context, prodotto, index);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Card(
          elevation: 2,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          prodottiCarrello[index].prodotto.immagineProdotto)),
                  title: Text(prodottiCarrello[index].prodotto.nomeProdotto),
                  subtitle: Text(
                      "${prodottiCarrello[index].prodotto.prezzo}€ cad/uno"),
                ),
              ),
              Expanded(
                child: Text(
                    "Quantità : ${prodottiCarrello[index].quantitaRichiesta}"),
              ),
              Expanded(
                child: Text(
                    "Totale Parziale: ${prodottiCarrello[index].quantitaRichiesta * prodottiCarrello[index].prodotto.prezzo}€"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createOrder() {
    List<ProdottiInOrdine> prodottiInOrdine = [];

    for (ProdottiCarrello pr in ShoppingCart.staticListProducts) {
      //inserisco tutti i prodotti nel carrello in una lista di prodottiInOrdine
      prodottiInOrdine.add(new ProdottiInOrdine(
          prodotto: pr.prodotto, quantitaRichiesta: pr.quantitaRichiesta));
    }

    Ordine ordine = new Ordine(
        utente: UserLoginPage.UTENTE,
        dataCreazione: DateTime.now().toString(),
        prodottiInOrdine: prodottiInOrdine,
        totaleOrdine: calcolaTotaleOrdine(prodottiInOrdine));

    return ordine;
  }

  double calcolaTotaleOrdine(List<ProdottiInOrdine> prodottiInOrdine) {
    double totale = 0.0;
    for (ProdottiInOrdine prod in prodottiInOrdine) {
      totale += prod.quantitaRichiesta * prod.prodotto.prezzo;
    }
    return totale;
  }

  String calcolaTotale() {
    var f = NumberFormat('###.0#', 'en_US');
    double totale = 0;
    for (int i = 0; i < prodottiCarrello.length; i++)
      totale += prodottiCarrello[i].prodotto.prezzo *
          prodottiCarrello[i].quantitaRichiesta;
    return f.format(totale);
  }
}
