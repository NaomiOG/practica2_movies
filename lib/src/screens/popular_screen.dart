import 'package:flutter/material.dart';
import 'package:practica2_2021/src/models/populardao.dart';
import 'package:practica2_2021/src/network/api_popular.dart';
import 'package:practica2_2021/src/utils/settings.dart';
import 'package:practica2_2021/src/views/card_popular.dart';

class PopularScreen extends StatefulWidget{
    PopularScreen({Key key}) : super(key: key);

    @override
    _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen>{
  ApiPopular apiPopular;

  @override
  void initState(){
    super.initState();
    apiPopular=ApiPopular();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
        backgroundColor: Settings.colorHeader,
      ),
      //FutureBuilder retorna siempre un Widget
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: apiPopular.getAllPopular(),
        builder: (BuildContext context, AsyncSnapshot<List<PopularDAO>> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("Has error in this request :(")
              );
          }else if(snapshot.connectionState == ConnectionState.done){
            return _listPopularMovies(snapshot.data);
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _listPopularMovies(List<PopularDAO> movies) {
    return ListView.builder(
      //itera sobre cada elemento de la lista de populares y aumenta el index
      itemBuilder: (context,index){
        PopularDAO popular = movies[index];
        return CardPopular(popular: popular);
      },
      itemCount: movies.length,
    );
  }
}