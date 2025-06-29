class ApiConstants {
  static const String apiKey = 'your_super_secret_key';
  static const String baseUrl = "https://sahary.com.sa//wp-json/custom/v1";
  static const String fetchSections = "$baseUrl/sections";
  static const String fetchBrands = "$baseUrl/brands";
  static const String fetchProducts =
      "$baseUrl/products?page=1&per_page={number-of-items}";
  static const String fetchProjects =
      "$baseUrl/projects?page=1&per_page=1000000000000";
  static const String fetchProjectsFilters = "$baseUrl/projects/filters";
  static const String submitQuote = '$baseUrl/submit-quote';
  static const String contactUs = '$baseUrl/submit-contact';
  static const String fetchClients = '$baseUrl/clients';
  static const String fetchPartners = '$baseUrl/partners';
  static const String survey = 'https://sahary.com.sa/language/en/surveys/';
  static const String termsAndConditions =
      'https://sahary.com.sa/language/en/sahary-home-english/';
  static const String tradeRegistry =
      'https://sahary.com.sa/language/en/sahary-home-english/';
}
