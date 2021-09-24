import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progetto_piattaforme/model/ordine.dart';
import 'package:progetto_piattaforme/model/prodotti_carrello.dart';
import 'package:progetto_piattaforme/model/products.dart';
import 'package:progetto_piattaforme/model/utente.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';

class RestClient {
  static const String URL_PRODUCTS = "http://localhost:8080/prodotti";

  static const String URL_USERS = "http://localhost:8080/utente";

  static const String URL_GET_USER = "http://localhost:8080/utente/login";

  static const String URL_ADD_PRODUCT_IN_CART =
      "http://localhost:8080/carrello/aggiungiProdotto/";

  static const String URL_SHOW_PRODUCTS_IN_CART =
      "http://localhost:8080/carrello/tuttiProdotti/";

  static const String URL_ADD_ORDER = "http://localhost:8080/ordini";

  static const String URL_FETCH_PRODUCTS_IN_ORDER =
      "http://localhost:8080/ordini/specifico/";
  static const String URL_DELETED_CART =
      "http://localhost:8080/carrello/cancella/";

  static const String URL_DELETED_PRODUCT_CART =
      "http://localhost:8080/carrello/cancellaProdotto/";
  static const String URL_GET_ORDERS_USER = "http://localhost:8080/ordini/";
  /*Il futuro viene utilizzato per caricare in modo pigro
   le informazioni sul prodotto. Il caricamento lento è un 
   concetto per rinviare l'esecuzione del codice fino a quando 
   non è necessario.

  http.get viene utilizzato per recuperare i dati da Internet.

  json.decode viene utilizzato per decodificare i
  dati JSON nell'oggetto Dart Map. Una volta che i dati
  JSON sono stati decodificati,
  convertiti in List <Products> utilizzando fromMap della classe Products.
  */

  static List<Products> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Products>((json) => Products.fromJson(json)).toList();
  } //parseProducts

  static Future<List<Products>> fetchProducts(String pathSearch) async {
    final response = await http.get(Uri.parse(URL_PRODUCTS + pathSearch));

    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception("Errore nella fetch dei prodotti!");
    }
  } //fetchProducts

  static Future<String> deleteShoppingCart(int idCart) async {
    final response =
        await http.delete(Uri.parse(URL_DELETED_CART + idCart.toString()));
    if (response.statusCode == 200) {
      return "Lista prodotti articoli per carrello con id: $idCart, cancellata correttamente!";
    }

    return "Nessun prodotto nel carrello con id: $idCart cancellato!";
  }

  static Future<String> deletedProductInCarts(int idCart, int idProduct) async {
    final response = await http.delete(
        Uri.parse(URL_DELETED_PRODUCT_CART + "$idCart" + "/" + "$idProduct"));
    if (response.statusCode == 200) {
      return "Cancellazione Prodotto con id: $idProduct, avvenuta con successo!";
    }

    return "Nessun prodotto nel carrello con id: $idCart cancellato!";
  }

  static List<ProdottiCarrello> parseProdottiCarrello(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ProdottiCarrello>((json) => ProdottiCarrello.fromJson(json))
        .toList();
  }

  static Future<List<ProdottiCarrello>> fetchProductsInCart(
      String emailUtente) async {
    final response =
        await http.get(Uri.parse(URL_SHOW_PRODUCTS_IN_CART + emailUtente));

    if (response.statusCode == 200) {
      return parseProdottiCarrello(response.body);
    } else {
      return [];
    }
  }

  static List<Ordine> parseOrdersForUser(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Ordine>((json) => Ordine.fromJson(json)).toList();
  }

  static Future<List<Ordine>> fetchOrdersUser(int idUtente) async {
    final response =
        await http.get(Uri.parse(URL_GET_ORDERS_USER + "$idUtente"));
    if (response.statusCode == 200) {
      return parseOrdersForUser(response.body);
    } else {
      return [];
    }
  }

  static Future<Ordine> fetchProductsInOrder(
      int idUtente, String dataRegistrazione) async {
    final response = await http.get(Uri.parse(URL_FETCH_PRODUCTS_IN_ORDER +
        idUtente.toString() +
        "/" +
        dataRegistrazione));

    if (response.statusCode == 200) {
      return parseProductInOrder(response.body);
    } else {
      return new Ordine(
          dataCreazione: "",
          totaleOrdine: -1,
          utente: new Utente(
              nomeUtente: "tappo",
              cognomeUtente: "tappo",
              telefonoUtente: "-1",
              indirizzoUtente: "tappo",
              email: "tappo",
              password: "tappo",
              carrello: new ShoppingCart(carrelloId: -1, listProducts: []),
              dataRegistrazione: ""),
          prodottiInOrdine: []);
    }
  }

  static Ordine parseProductInOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Ordine>((json) => Ordine.fromJson(json)).toList();
  }

  static List<Utente> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Utente>((json) => Utente.fromJson(json)).toList();
  } //parseUsers

  static Future<List<Utente>> fetchUsers() async {
    final response = await http.get(Uri.parse(URL_USERS));

    if (response.statusCode == 200) {
      return parseUsers(response.body);
    } else {
      throw Exception("Errore nella fetch degli utenti!");
    }
  } //fetchUsers

  static Future<Utente> getUser(String email, String password) async {
    final response = await http.get(Uri.parse(
        URL_GET_USER + "?email=" + email + "&" + "password=" + password));
    if (response.statusCode == 200)
      return utenteFromJson(response.body);
    else if (response.statusCode == 400)
      return new Utente(
          idUtente: -1,
          nomeUtente: "tappo",
          cognomeUtente: "tappo",
          telefonoUtente: "tappo",
          indirizzoUtente: "tappo",
          email: "tappo",
          password: "tappo",
          carrello: new ShoppingCart(carrelloId: -1, listProducts: []),
          dataRegistrazione: "tappo");
    else {
      throw new Exception("Errore nel fetching dei dati dell'utente");
    }
  } //getUser

  static Future<Ordine> addOrderForUser(Ordine ordine) async {
    final response = await http.post(Uri.parse(URL_ADD_ORDER),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "utente": ordine.utente,
          "dataCreazione": ordine.dataCreazione,
          "totaleOrdine": ordine.totaleOrdine,
          "prodottiInOrdine": ordine.prodottiInOrdine
        }));

    if (response.statusCode == 200) {
      Ordine order = new Ordine(
          utente: ordine.utente,
          dataCreazione: ordine.dataCreazione,
          prodottiInOrdine: ordine.prodottiInOrdine,
          totaleOrdine: ordine.totaleOrdine);
      return order;
    } else {
      throw Exception("Aggiunta ordine nel database fallita!");
    }
  }

  static Future<Products> addProductInCart(
      int idCart,
      int prodottoId,
      String nomeProdotto,
      String immagineProdotto,
      double peso,
      double prezzo,
      int quantitaTotale,
      String categoriaProdotto,
      String descrizioneProdotto,
      int quantitaRichiesta) async {
    final response = await http.post(
        Uri.parse(
            URL_ADD_PRODUCT_IN_CART + "$idCart" + "/" + "$quantitaRichiesta"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "prodottoId": prodottoId,
          "nomeProdotto": nomeProdotto,
          "immagineProdotto": immagineProdotto,
          "categoriaProdotto": categoriaProdotto,
          "peso": peso,
          "quantitaTotale": quantitaTotale,
          "descrizioneProdotto": descrizioneProdotto
        }));

    if (response.statusCode == 200) {
      Products product = new Products(
          prodottoId: prodottoId,
          nomeProdotto: nomeProdotto,
          immagineProdotto: immagineProdotto,
          peso: peso,
          prezzo: prezzo,
          categoriaProdotto: categoriaProdotto,
          descrizioneProdotto: descrizioneProdotto,
          quantitaTotale: quantitaTotale);
      return product;
    } else {
      throw Exception("Aggiunta prodotto nel carrello fallita!");
    }
  }

  static Future<Utente> createUser(
      String nomeUtente,
      String cognomeUtente,
      String telefonoUtente,
      String indirizzoUtente,
      String email,
      String password,
      ShoppingCart carrello,
      String dataRegistrazione) async {
    final response = await http.post(Uri.parse(URL_USERS),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nomeUtente": nomeUtente,
          "cognomeUtente": cognomeUtente,
          "telefonoUtente": telefonoUtente,
          "indirizzoUtente": indirizzoUtente,
          "email": email,
          "password": password,
          "carrello": carrello,
          "dataRegistrazione": dataRegistrazione
        }));

    if (response.statusCode == 200) {
      String responseString = response.body;

      SnackBar(content: Text(responseString));
      Utente ut = new Utente(
          nomeUtente: nomeUtente,
          carrello: carrello,
          cognomeUtente: cognomeUtente,
          telefonoUtente: telefonoUtente,
          indirizzoUtente: indirizzoUtente,
          email: email,
          password: password,
          dataRegistrazione: dataRegistrazione);
      return ut;
    } else if (response.statusCode == 409) {
      //EMAIL GIà ESISTENTE
      return new Utente(
          idUtente: -1,
          nomeUtente: "tappo",
          cognomeUtente: "tappo",
          telefonoUtente: "tappo",
          indirizzoUtente: "tappo",
          email: "tappo",
          password: "tappo",
          carrello: new ShoppingCart(carrelloId: -1, listProducts: []),
          dataRegistrazione: "tappo");
    } else {
      throw new Exception("Errore nel fetching dei dati dell'utente");
    }
  } //createUser

  //static Future<ShoppingCart> createShoppingCart(){

  //}
}
