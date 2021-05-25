//con show se renombra la importacion
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:practica2_2021/src/models/trailerdao.dart';
class ApiTrailer{
  
  Client http = Client();
  //se ejecuta en segundo plano por lo que es async
  //Future retorna una lista de peliculas trailers
  Future<List<TrailerDAO>> getTrailer(int movieId) async{
    String URL_POPULAR = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=0f30c0f313ce7fc4a175e554b8324a60&language=en-US';
    print('urlpopular');
    print(URL_POPULAR);
    final response = await http.get(URL_POPULAR);
    if( response.statusCode == 200){
      //results se convierte a una lista dinámica
      var trailer = jsonDecode(response.body)['results'] as List;
      //covertir la lista a una lista de tipo TrailerDAO
      //para ello nos movmos en cada elemento de la lista
      //cada elemento que se itere se vacía sobre movie
      List<TrailerDAO> listTrailer = trailer.map((video) => TrailerDAO.fromJSON(video)).toList();
      return listTrailer;
    }else{
      return null;
    }
  }
}