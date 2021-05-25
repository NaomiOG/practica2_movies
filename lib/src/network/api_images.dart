//con show se renombra la importacion
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2_2021/src/models/imagesdao.dart';

class ApiImages{
  
  Client http = Client();
  //se ejecuta en segundo plano por lo que es async
  //Future retorna una lista de peliculas trailers
  Future<List<ImagesDAO>> getImages(int movieId) async{
     
    String URL_POPULAR = 'https://api.themoviedb.org/3/movie/$movieId/images?api_key=0f30c0f313ce7fc4a175e554b8324a60&language=en-US&append_to_response=images&include_image_language=en,null';
    final response = await http.get(URL_POPULAR);
    if( response.statusCode == 200){
      //results se convierte a una lista dinámica
      var images = jsonDecode(response.body)['backdrops'] as List;
      //covertir la lista a una lista de tipo TrailerDAO
      //para ello nos movmos en cada elemento de la lista
      //cada elemento que se itere se vacía sobre movie
      List<ImagesDAO> listImages = images.map((image) => ImagesDAO.fromJSON(image)).toList();
      return listImages;
    }else{
      return null;
    }
  }
}