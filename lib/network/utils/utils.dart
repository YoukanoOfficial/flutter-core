

Uri addQueryParametersToUrl(String baseUrl, Map<String, dynamic> queryParameters) {
  final uri = Uri.parse(baseUrl);
  final updatedUri = uri.replace(queryParameters: queryParameters);
  return updatedUri;
}