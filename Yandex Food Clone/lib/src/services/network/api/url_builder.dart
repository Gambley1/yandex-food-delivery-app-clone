class UrlBuilder {
  const UrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://reqres.in/api';

  final String _baseUrl;

  final String _baseDummyUrl = 'http://127.0.0.1:5500/apis/restaurants.json';

  String dummyStringOfRestaurants() {
    return _baseDummyUrl;
  }

  String buildLogInUrl() {
    return '$_baseUrl/login';
  }

  String buildSingOutUrl() {
    return '$_baseUrl/users/2';
  }
}
