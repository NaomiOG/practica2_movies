//con show se renombra la importacion
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2_2021/src/models/populardao.dart';
class ApiPopular{
  final String URL_POPULAR = "https://api.themoviedb.org/3/movie/popular?api_key=0f30c0f313ce7fc4a175e554b8324a60";
  Client http = Client();
  //se ejecuta en segundo plano por lo que es async
  //Future retorna una lista de peliculas populares
  Future<List<PopularDAO>> getAllPopular() async{
    final response = await http.get(URL_POPULAR);
    if( response.statusCode == 200){
      //results se convierte a una lista dinámica
      var popular = jsonDecode(response.body)['results'] as List;
      //covertir la lista a una lista de tipo PopularDAO
      //para ello nos movmos en cada elemento de la lista
      //cada elemento que se itere se vacía sobre movie
      List<PopularDAO> listPopular = popular.map((movie) => PopularDAO.fromJSON(movie)).toList();
      return listPopular;
    }else{
      return null;
    }
  }
}