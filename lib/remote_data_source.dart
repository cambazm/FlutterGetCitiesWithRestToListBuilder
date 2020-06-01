import 'dart:async';
import 'package:turkish/turkish.dart';
import 'package:citiesrest/city_service_client.dart';
import 'package:http/http.dart';
import 'package:citiesrest/city_response.dart';

class RemoteDataSource {
  //Creating Singleton
  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse =
      RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  CityServiceClient client = CityServiceClient(Client());

  Future<Result> getCities() async {
    try {
      final response =
          await client.request(requestType: RequestType.GET, path: "cities");
      if (response.statusCode == 200) {
        CityResponse r = CityResponse.fromRawJson(response.body);
        r.data.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase()); //TODO Turkce karakterle baslayan sehirler en sona atiliyor, https://pub.dev/packages/turkish sort implemente edilmeli
        });
        return Result<CityResponse>.success(r);
      } else {
        return Result.error("Sehirler bulunamadi");
      }
    } catch (error) {
      return Result.error("Hata olustu!");
    }
  }
}
