import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/dto/all_productsDTO.dart';
import 'package:progetto_piattaforme/dto/search_object_page_dto.dart';
import 'package:progetto_piattaforme/pages/all_products.dart';
import 'package:progetto_piattaforme/pages/search_object_page.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = new TextEditingController();
  SearchItems searchItems = SearchItems();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "content/images/sfondo_user_log.jpg",
                ),
                fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Cerca...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                  onSubmitted: (String request) {
                    if (request.isEmpty) {
                      Navigator.pushNamed(context, AllProducts.routeName,
                          arguments: AllProductsDTO(label: "Tutti i prodotti"));
                    } else {
                      //inviare la richiesta Get al server backend
                      //del determinato prodotto
                      searchItems.text = request.trim();
                      Navigator.pushNamed(context, SearchObjectPage.routeName,
                          arguments: SearchObjectPageDTO(
                              label: searchItems.text, path: searchItems.text));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchItems {
  String text = "";
}
