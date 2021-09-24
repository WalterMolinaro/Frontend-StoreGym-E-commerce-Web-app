import 'package:flutter/material.dart';

import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/all_products.dart';

class AttrezziProducts extends StatelessWidget {
  static const String routeName = "/ProdottiAttrezzi";
  const AttrezziProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AllProducts(
            label: "Attrezzi",
            productsFuture: RestClient.fetchProducts("/categoria")));
  }
}
