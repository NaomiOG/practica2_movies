//con show se renombra la importacion
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2_2021/src/models/actordao.dart';

class ApiActors{
  
  Client http = Client();
  //se ejecuta en segundo plano por lo que es async
  //Future retorna una lista de peliculas trailers
  Future<List<ActorDAO>> getActors(int movieId) async{
     
    String URL_POPULAR = 'https://api.themoviedb.org/3/movie/$movieId/casts?api_key=0f30c0f313ce7fc4a175e554b8324a60&language=en-US';
    print('urlactores');
    print(URL_POPULAR);
    final response = await http.get(URL_POPULAR);
    if( response.statusCode == 200){
      //results se convierte a una lista dinámica
      var actors = jsonDecode(response.body)['cast'] as List;
      print('lista actores');
      print(actors);
      //covertir la lista a una lista de tipo TrailerDAO
      //para ello nos movmos en cada elemento de la lista
      //cada elemento que se itere se vacía sobre movie
      List<ActorDAO> listActors = actors.map((actor) => ActorDAO.fromJSON(actor)).toList();
      return listActors;
    }else{
      return null;
    }
  }
}