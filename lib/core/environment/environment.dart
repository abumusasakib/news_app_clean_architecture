import 'package:flutter_dotenv/flutter_dotenv.dart';

final String newsAPIBaseURL = dotenv.env['NEWS_API_BASE_URL'] ?? '';
final String newsAPIKey = dotenv.env['NEWS_API_KEY'] ?? '';
final String countryQuery = dotenv.env['COUNTRY_QUERY'] ?? 'us';
final String categoryQuery = dotenv.env['CATEGORY_QUERY'] ?? 'general';
