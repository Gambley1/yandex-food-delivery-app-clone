class UrlBuilder {
  const UrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://reqres.in/api';

  final String _baseUrl;

  String buildLogInUrl() {
    return '$_baseUrl/login';
  }

  String buildSingOutUrl() {
    return '$_baseUrl/users/2';
  }

  String buildGetRestaurantsUrl() {
    return 'https://restaurants-api.p.rapidapi.com/restaurants';
  }

  String buildGetAllRestaurantsUrl() {
    return 'https://foodbukka.herokuapp.com/api/v1/restaurant';
  }
}
