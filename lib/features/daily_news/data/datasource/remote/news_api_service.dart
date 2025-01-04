import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/environment/environment.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi()
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<dynamic>> getNewsArticles({
    @Query('apiKey') required String apiKey,
    @Query('country') required String country,
    @Query('category') String? category,
  });
}

// Configure Dio and initialize the service
Dio createDio() {
  final dio = Dio();
  dio.options.baseUrl = newsAPIBaseURL; // Set the base URL dynamically
  return dio;
}

NewsApiService createNewsApiService() {
  final dio = createDio();
  return NewsApiService(dio);
}
