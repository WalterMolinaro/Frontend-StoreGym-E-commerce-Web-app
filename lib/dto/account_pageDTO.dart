import 'package:progetto_piattaforme/model/ordine.dart';
import 'package:progetto_piattaforme/model/utente.dart';

class AccountPageDTO {
  Utente user;
  Future<List<Ordine>> listProducts;
  AccountPageDTO({required this.user, required this.listProducts});
}
