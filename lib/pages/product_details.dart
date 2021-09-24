import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/custom_widget/build_box_quantity.dart';
import 'package:progetto_piattaforme/custom_widget/build_rating_box.dart';
import 'package:progetto_piattaforme/model/prodotti_carrello.dart';
import 'package:progetto_piattaforme/model/products.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';
import 'package:progetto_piattaforme/pages/user_login_page.dart';
import 'package:progetto_piattaforme/responsive/layout_responsive.dart';

class ProductDetails extends StatelessWidget {
  static Color? colorAmber = Colors.amber[100];
  static const String routeName = '/DettaglioProdotto';
  final Products? product;
  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            BuildAppBar(),
            Divider(),
            LayoutResponsive(
              tablet: Column(
                children: [
                  Container(
                    height: 700,
                    width: 700,
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: NetworkImage(product!.immagineProdotto),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, bottom: 20),
                          child: Text(
                            product!.nomeProdotto,
                            style: TextStyle(
                                shadows: <Shadow>[Shadow(offset: Offset(5, 5))],
                                fontSize: 40,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            "<< " + product!.descrizioneProdotto + " >>",
                            style: TextStyle(
                                shadows: <Shadow>[Shadow(offset: Offset(5, 0))],
                                fontSize: 28,
                                color: colorAmber),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: RatingBox(),
                              padding: EdgeInsets.all(20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                ),
                                child: Text(
                                  "Numero",
                                  style: TextStyle(
                                      fontSize: 20, color: colorAmber),
                                ),
                              ),
                            ),
                            Expanded(child: BuildBoxQuantity()),
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Divider()),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.verified,
                                size: 20,
                                color: colorAmber,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Subito disponibile",
                                style: TextStyle(color: colorAmber),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                "${product!.prezzo}" + "€",
                                style:
                                    TextStyle(fontSize: 30, color: colorAmber),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.info,
                                size: 20,
                                color: colorAmber,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Peso",
                                style: TextStyle(color: colorAmber),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                "${product!.peso}" + "Kg",
                                style:
                                    TextStyle(fontSize: 30, color: colorAmber),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "IVA incl. & più spese di spedizione",
                                style:
                                    TextStyle(color: colorAmber, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Divider()),
                        Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(elevation: 20),
                                  onPressed: addProductInCart,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          right: 170,
                                          left: 170),
                                      child: Text(
                                        "Lo voglio!",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ],
                          ),
                        )
                      ]))
                ],
              ),
              desktop:
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  height: 700,
                  width: 700,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: NetworkImage(product!.immagineProdotto),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 8,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                          product!.nomeProdotto,
                          style: TextStyle(
                              shadows: <Shadow>[Shadow(offset: Offset(5, 5))],
                              fontSize: 40,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          "<< " + product!.descrizioneProdotto + " >>",
                          style: TextStyle(
                              shadows: <Shadow>[Shadow(offset: Offset(5, 0))],
                              fontSize: 28,
                              color: colorAmber),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: RatingBox(),
                            padding: EdgeInsets.all(20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 20,
                                top: 10,
                              ),
                              child: Text(
                                "Numero",
                                style:
                                    TextStyle(fontSize: 20, color: colorAmber),
                              ),
                            ),
                          ),
                          Expanded(child: BuildBoxQuantity()),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Divider()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.verified,
                              size: 20,
                              color: colorAmber,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Subito disponibile",
                              style: TextStyle(color: colorAmber),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              "${product!.prezzo}" + "€",
                              style: TextStyle(fontSize: 30, color: colorAmber),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.info,
                              size: 20,
                              color: colorAmber,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Peso",
                              style: TextStyle(color: colorAmber),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              "${product!.peso}" + "Kg",
                              style: TextStyle(fontSize: 30, color: colorAmber),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "IVA incl. & più spese di spedizione",
                              style: TextStyle(color: colorAmber, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Divider()),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(elevation: 20),
                                onPressed: addProductInCart,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      right: 90,
                                      left: 90),
                                  child: Text(
                                    "Lo voglio!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ]))),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  void addProductInCart() async {
    product!.setQuantitaRichiesta(BuildBoxQuantity.quantityOfProduct);
    ProdottiCarrello prodCarr = new ProdottiCarrello(
        prodotto: product!, quantitaRichiesta: product!.quantitaRichiesta);
    ShoppingCart.staticListProducts.add(prodCarr);

    if (UserLoginPage.STATUS_USER) {
      //DEVO EFFETTUARE LA POST DI QUESTO PRODOTTO NEL CARRELLO
      await RestClient.addProductInCart(
          ShoppingCart.staticIdCart,
          product!.prodottoId,
          product!.nomeProdotto,
          product!.immagineProdotto,
          product!.peso,
          product!.prezzo,
          product!.quantitaTotale,
          product!.categoriaProdotto,
          product!.descrizioneProdotto,
          product!.quantitaRichiesta);
    }
  }
}
