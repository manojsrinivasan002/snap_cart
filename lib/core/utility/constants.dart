class Constants {
  // base url
  static const String baseUrl = "https://dummyjson.com";

  // enpoints
  static const String productsEndPoint = "/products";
  static const String categoriesEndPoint = "/products/categories";

  // timeouts
  static const Duration connectTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 5);

  // headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
