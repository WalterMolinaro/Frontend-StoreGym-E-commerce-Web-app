import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/button.dart';
import 'package:progetto_piattaforme/custom_widget/search_bar.dart';
import 'package:progetto_piattaforme/dto/account_pageDTO.dart';

import 'package:progetto_piattaforme/dto/all_productsDTO.dart';
import 'package:progetto_piattaforme/dto/shopping_cart_pageDTO.dart';
import 'package:progetto_piattaforme/model/prodotti_carrello.dart';
import 'package:progetto_piattaforme/model/utente.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';

import 'package:progetto_piattaforme/pages/account_page.dart';

import 'package:progetto_piattaforme/pages/all_products.dart';
import 'package:progetto_piattaforme/pages/home_page.dart';
import 'package:progetto_piattaforme/pages/log_in_page.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';
import 'package:progetto_piattaforme/pages/user_login_page.dart';
import 'package:progetto_piattaforme/responsive/layout_responsive.dart';

import 'build_red_button_on_cart.dart';

class BuildAppBar extends StatefulWidget {
  // ignore: non_constant_identifier_names

  BuildAppBar({Key? key}) : super(key: key);

  @override
  _BuildAppBarState createState() => _BuildAppBarState();
}

class _BuildAppBarState extends State<BuildAppBar> {
  @override
  void initState() {
    super.initState();
    if (ShoppingCart.staticListProducts.length > 0) {
      BuildRedButtonOnCart();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: LayoutResponsive(
        tablet: Row(
          children: [
            IconButton(
              //la funzione deve chiamare un navigator su un altra pagina
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute<SearchBar>(builder: (context) {
                  return Scaffold(
                    body: Column(
                      children: [
                        SearchBar(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          // ignore: deprecated_member_use
                          child: OutlineButton(
                              child: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop()),
                        )
                      ],
                    ),
                  );
                }));
              },
              icon: Icon(
                Icons.search,
                color: Colors.green,
              ),
            ),
            IconButton(
              //la funzione deve chiamare un navigator su un altra pagina
              onPressed: () {
                Navigator.pushNamed(context, AllProducts.routeName,
                    arguments: AllProductsDTO(label: "Tutti i prodotti"));
              },
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.green,
              ),
            ),
            IconButton(
              //la funzione deve chiamare un navigator su un altra pagina
              onPressed: () async {
                if (!UserLoginPage.STATUS_USER) {
                  Navigator.pushNamed(
                    context,
                    UserLoginPage.routeName,
                  );
                } else {
                  Utente utenteAccesso = await RestClient.getUser(
                      UserLoginPage.UTENTE.email,
                      UserLoginPage.UTENTE.password);
                  Navigator.pushNamed(context, AccountPage.routeName,
                      arguments: AccountPageDTO(
                        user: utenteAccesso,
                        listProducts:
                            RestClient.fetchOrdersUser(utenteAccesso.idUtente!),
                      ));
                }
              },
              icon: Icon(
                Icons.person,
                color: Colors.green,
              ),
            ),
            Expanded(
              child: Button(
                text: Text(
                  "STORE GYM",
                  style: TextStyle(
                      fontSize: 40,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(10.0, 5.0),
                          blurRadius: 3.0,
                        ),
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 8.0,
                        ),
                      ],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.routeName);
                },
              ),
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () async {
                    if (UserLoginPage.STATUS_USER &&
                        UserLoginPage.COUNT_LOG == 0) {
                      UserLoginPage.COUNT_LOG++;
                      List<ProdottiCarrello> productsInCart =
                          await RestClient.fetchProductsInCart(
                              UserLoginPage.UTENTE.email);
                      if (ShoppingCart.staticListProducts.length != 0) {
                        for (ProdottiCarrello p in productsInCart) {
                          bool daAggiungere = true;
                          for (ProdottiCarrello prodInStatic
                              in ShoppingCart.staticListProducts) {
                            //entrato = true;
                            if (p.prodotto.nomeProdotto ==
                                prodInStatic.prodotto.nomeProdotto) {
                              daAggiungere = false;
                              break;
                            }
                          }
                          if (daAggiungere)
                            ShoppingCart.staticListProducts.add(p);
                        }
                      } else {
                        for (ProdottiCarrello prod in productsInCart)
                          ShoppingCart.staticListProducts.add(prod);
                      }
                    }

                    Navigator.pushNamed(context, ShoppingCart.routeName,
                        arguments: ShoppingCartPageDTO(
                            idCart: ShoppingCart.staticIdCart,
                            listaProdotti: ShoppingCart.staticListProducts));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                ),
                BuildRedButtonOnCart(),
              ],
            ),
            IconButton(
              //la funzione deve chiamare un navigator su un altra pagina
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.routeName);
              },
              icon: Icon(
                Icons.login,
                color: Colors.green,
              ),
            )
          ],
        ),
        desktop: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                right: 30,
              ),
              child: Button(
                text: Text(
                  "STORE GYM",
                  style: TextStyle(
                      fontSize: 40,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(10.0, 5.0),
                          blurRadius: 3.0,
                        ),
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 8.0,
                        ),
                      ],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.routeName);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Button(
                text: Text(
                  "Prodotti",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AllProducts.routeName,
                      arguments: AllProductsDTO(label: "Tutti i prodotti"));
                },
                iconData: Icons.shopping_bag,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Button(
                text: Text(
                  "Utente",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
                onPressed: () async {
                  if (!UserLoginPage.STATUS_USER) {
                    Navigator.pushNamed(
                      context,
                      UserLoginPage.routeName,
                    );
                  } else {
                    Utente utenteAccesso = await RestClient.getUser(
                        UserLoginPage.UTENTE.email,
                        UserLoginPage.UTENTE.password);
                    Navigator.pushNamed(context, AccountPage.routeName,
                        arguments: AccountPageDTO(
                            user: utenteAccesso,
                            listProducts: RestClient.fetchOrdersUser(
                                utenteAccesso.idUtente!)));
                  }
                },
                iconData: Icons.person,
              ),
            ),

            //è necessario il widget sottostante poiché
            //la classe contiene un textField
            //che la rende non espandibile
            Expanded(
              flex: 2,
              child: SearchBar(),
            ),

            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Stack(children: [
                Button(
                  text: Text(
                    "Carrello",
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  onPressed: () async {
                    if (UserLoginPage.STATUS_USER &&
                        UserLoginPage.COUNT_LOG == 0) {
                      UserLoginPage.COUNT_LOG++;
                      List<ProdottiCarrello> productsInCart =
                          await RestClient.fetchProductsInCart(
                              UserLoginPage.UTENTE.email);
                      if (ShoppingCart.staticListProducts.length != 0) {
                        for (ProdottiCarrello p in productsInCart) {
                          bool daAggiungere = true;
                          for (ProdottiCarrello prodInStatic
                              in ShoppingCart.staticListProducts) {
                            //entrato = true;
                            if (p.prodotto.nomeProdotto ==
                                prodInStatic.prodotto.nomeProdotto) {
                              daAggiungere = false;
                              break;
                            }
                          }
                          if (daAggiungere)
                            ShoppingCart.staticListProducts.add(p);
                        }
                      } else {
                        for (ProdottiCarrello prod in productsInCart)
                          ShoppingCart.staticListProducts.add(prod);
                      }
                    }

                    Navigator.pushNamed(context, ShoppingCart.routeName,
                        arguments: ShoppingCartPageDTO(
                            idCart: ShoppingCart.staticIdCart,
                            listaProdotti: ShoppingCart.staticListProducts));
                  },
                  iconData: Icons.shopping_cart,
                ),
                Container(width: 15, height: 15, child: BuildRedButtonOnCart()),
              ]),
            ),

            Container(
              padding: EdgeInsets.only(right: 20),
              child: Button(
                text: Text(
                  "Accedi",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                iconData: Icons.login,
              ),
            )
          ],
        ),
      ),
    );
  }
}
