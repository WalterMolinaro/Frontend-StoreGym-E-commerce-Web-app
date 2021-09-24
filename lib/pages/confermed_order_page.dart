import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/dto/all_productsDTO.dart';
import 'package:progetto_piattaforme/pages/all_products.dart';
import 'package:progetto_piattaforme/pages/home_page.dart';

class ConfermedOrderPage extends StatelessWidget {
  static const String routeName = "/confermedOrder";
  const ConfermedOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://th.bing.com/th/id/R.cc07621766a6adcad1ed1b06f97ad501?rik=Mce5PXsMFKeoxQ&pid=ImgRaw&r=0",
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BuildAppBar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.done_outline_rounded, size: 40),
                        ),
                        Expanded(
                            child: Text(
                          " Complimenti, hai effettuato l'ordine " +
                              "con successo!",
                          style: TextStyle(fontSize: 40, color: Colors.green),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Torna alla home",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        ),
                        Expanded(
                            child: Icon(
                          Icons.arrow_right_alt,
                          size: 100,
                        )),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, HomePage.routeName);
                            },
                            icon: Icon(Icons.home, size: 30)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Vai allo shop",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        ),
                        Expanded(
                            child: Container(
                          width: 100,
                          child: Icon(
                            Icons.arrow_right_alt,
                            size: 100,
                          ),
                        )),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AllProducts.routeName,
                                  arguments: AllProductsDTO(
                                      label: "Tutti i prodotti"));
                            },
                            icon: Icon(Icons.shop, size: 30)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
