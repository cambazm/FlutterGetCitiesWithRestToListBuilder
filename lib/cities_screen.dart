
import 'package:citiesrest/city_response.dart';
import 'package:citiesrest/city_service_client.dart';
import 'package:citiesrest/remote_data_source.dart';
import 'package:flutter/material.dart';

class CitiesScreen extends StatefulWidget {
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turkiye Iller"),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getCities(),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                CityResponse response = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: response.data.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        title: Text(response.data[index].name),
                        subtitle: Text(response.data[index].id),
                      );
                    });
              } else if (snapshot.data is ErrorState) {
                String errorMessage = (snapshot.data as ErrorState).msg;
                return Text(errorMessage);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}