import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/all_products.dart';

const List<String> categories = ["ATTREZZI", "INTEGRATORI", "PESI"];

class SearchObjectPage extends StatelessWidget {
  static const String routeName = "/SearchObjectPage";
  final String path;
  final String label;
  SearchObjectPage({Key? key, required this.path, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllProducts(
          label: label,
          productsFuture: (categories.contains(path.toUpperCase()))
              ? RestClient.fetchProducts("/categoria?categoriaProdotto=" + path)
              : RestClient.fetchProducts(
                  "/nomeProdotti/" + path.toUpperCase().trim())),
    );
  }
}
