import 'package:progetto_piattaforme/model/prodotti_carrello.dart';

class ShoppingCartPageDTO {
  final int idCart;
  final List<ProdottiCarrello> listaProdotti;

  ShoppingCartPageDTO({required this.idCart, required this.listaProdotti});
}
