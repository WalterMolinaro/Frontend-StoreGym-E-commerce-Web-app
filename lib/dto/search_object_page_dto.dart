//DTO = DATA TRANSFER OBJECT,
// questa classe è stata crata con lo scopo
//di effettuare un casting esplicito tra gli argmoneti
//passati nella navigazione delle routes.abstract

class SearchObjectPageDTO {
  final String path;
  final String label;

  SearchObjectPageDTO({required this.path, required this.label});
}
