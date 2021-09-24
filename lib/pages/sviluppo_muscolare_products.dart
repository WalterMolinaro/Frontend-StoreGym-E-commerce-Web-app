import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/all_products.dart';

class SviluppoMuscolareProducts extends StatelessWidget {
  static const String routeName = "/ProdottiSviluppoMuscolare";
  const SviluppoMuscolareProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AllProducts(
            label: "Pesi",
            productsFuture:
                RestClient.fetchProducts("/categoria?categoriaProdotto=PESI")));
  }
}
