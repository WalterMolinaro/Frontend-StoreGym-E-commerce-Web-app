import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/all_products.dart';

class SaluteProducts extends StatelessWidget {
  static const String routeName = "/ProdottiSalute";
  const SaluteProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AllProducts(
            label: "Integratori",
            productsFuture: RestClient.fetchProducts(
                "/categoria?categoriaProdotto=INTEGRATORI")));
  }
}
