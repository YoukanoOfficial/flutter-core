
class Environment {

  String key;
  String name;
  String? seleced;
  String prodUrl;
  String testUrl;
  String devUrl;
  Map<String, String>? otherUrl;

  Environment({
    required this.key,
    required this.name,
    this.seleced,
    required this.prodUrl,
    required this.testUrl,
    required this.devUrl,
    this.otherUrl,
  });
}
