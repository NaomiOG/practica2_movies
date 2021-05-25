import 'package:flutter/material.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/favoritedao.dart';
import 'package:practica2_2021/src/screens/dashboard.dart';
import 'package:practica2_2021/src/utils/settings.dart';
import 'package:practica2_2021/src/views/card_favorite.dart';

class FavoriteScreen extends StatefulWidget{
    FavoriteScreen({Key key}) : super(key: key);

    @override
    _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>{
  DatabaseHelper _database= DatabaseHelper();

  @override
  void initState(){
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context)=> Dashboard(email: "naomiog98@gmail.com"))) ,),
        title: Text("Favorite Movies"),
        backgroundColor: Settings.colorHeader,
      ),
      //FutureBuilder retorna siempre un Widget
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _database.getFavorite("naomiog98@gmail.com"),
        builder: (BuildContext context, AsyncSnapshot<List<FavoriteDAO>> snapshot){
          
          if(snapshot.hasError){
            print("entre pero con error");
            return Center(
              child: Text("Has error in this request :(")
              );
          }else if(snapshot.connectionState == ConnectionState.done){
            return _listFavoriteMovies(snapshot.data);
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _listFavoriteMovies(List<FavoriteDAO> movies) {
   
    return  movies==null ? Container() : ListView.builder(
      //itera sobre cada elemento de la lista de favoritees y aumenta el index
      itemBuilder: (context,index){
        FavoriteDAO favorite = movies[index];
        return CardFavorite(favorite: favorite);
      },
      itemCount: movies.length,
    );
  }
}