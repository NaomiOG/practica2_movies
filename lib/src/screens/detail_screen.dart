import 'package:flutter/material.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/actordao.dart';
import 'package:practica2_2021/src/models/favoritedao.dart';
import 'package:practica2_2021/src/models/imagesdao.dart';
import 'package:practica2_2021/src/models/trailerdao.dart';
import 'package:practica2_2021/src/network/api_actors.dart';
import 'package:practica2_2021/src/network/api_images.dart';
import 'package:practica2_2021/src/network/api_trailer.dart';
import 'package:practica2_2021/src/screens/favorite_screen.dart';
import 'package:practica2_2021/src/screens/popular_screen.dart';
import 'package:practica2_2021/src/screens/videoplayer_screen.dart';
import 'package:practica2_2021/src/utils/settings.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context).settings.arguments as Map<String,dynamic>; //Recuperar los argumentos  
    return Scaffold(
        appBar: AppBar(
          title: Text('Movie Detail'), 
          leading: BackButton(
          color: Colors.white,
          onPressed: () => 
          Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => movie['favorite']? FavoriteScreen() : PopularScreen()),
                        movie['favorite']? ModalRoute.withName('/favorite'): ModalRoute.withName('/popular')
                      )      
           ,),
          backgroundColor: Settings.colorHeader),
        backgroundColor: Colors.black,
        body: 
         SingleChildScrollView( 
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _trailerMovie(movie['id']),
                  Container(
                    child:MyStatefulWidget(movie: movie, ban: movie['ban']),
                    margin: EdgeInsets.only(left:320.0,top: 20.0)
                  )
                  
                ],
              ),
              
              SizedBox(height:10,),//espacio entre los dos campos
             
                  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network('https://image.tmdb.org/t/p/w500/${movie['posterpath']}', width: 120, height: 120,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                  Text(movie['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0), textAlign: TextAlign.start ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(movie['voteaverage'].toString(), style: TextStyle(color: Colors.yellow[900],  fontWeight: FontWeight.bold, fontSize: 25.0), ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          children:[
                                            Icon(Icons.star, color: Colors.yellow[800]),
                                            Icon(Icons.star, color: Colors.yellow[800]),
                                            Icon(Icons.star, color: Colors.yellow[800]),
                                            Icon(Icons.star, color: Colors.yellow[800]),
                                            Icon(Icons.star, color: Colors.grey[350]),
                                          ]
                                        )
                                      )
                                    ],
                                  )                       
                              ]
                            )
                          ],
                        ),
                      
                    ],
                  ),
            
                  SizedBox(height:10,),//espacio entre los dos campos
                  
                  Text('Overview', style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold, fontSize: 16.0),textAlign: TextAlign.left ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child:
                    Text(movie['overview'], style: TextStyle(color: Colors.white, fontSize: 15.0), textAlign: TextAlign.justify,), 
                  ),
                   SizedBox(height:10,),//espacio entre los dos campos
                   Text('Cast', style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold, fontSize: 16.0),textAlign: TextAlign.left ),
                   SizedBox(height:10,),//espacio entre los dos campos
                  _actorMovie(movie['id']),
                  SizedBox(height:20,),//espacio entre los dos campos
                   Text('Photos', style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold, fontSize: 16.0),textAlign: TextAlign.left ),
                  _imageMovie(movie['id']),                  
             ],
            )

                
            ],
          ),        
    )
    );
  }
}

Widget _trailerMovie(int movieId){
  ApiTrailer apiTrailer= ApiTrailer();
  return FutureBuilder(
    future: apiTrailer.getTrailer(movieId),
    builder: (BuildContext context, AsyncSnapshot<List<TrailerDAO>> snapshot){
      if(snapshot.hasError){
            return Center(
              child: Text("Has error in this request :(")
              );
          }else if(snapshot.connectionState == ConnectionState.done){
            String videoKey = snapshot.data[0].key;
            print('key: ');
            print(snapshot.data[0].key);
            return YoutubePlayerScreen(videoKey: videoKey);
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
    }
  );

}

Widget _actorMovie(int movieId){
  ApiActors apiActor= ApiActors();
  return FutureBuilder(
    future: apiActor.getActors(movieId),
    builder: (BuildContext context, AsyncSnapshot<List<ActorDAO>> snapshot){
      if(snapshot.hasError){
        print('Error!');
        print(snapshot.data);
            return Center(
              child: Text("Has error in this request :(")
              );
          }else if(snapshot.connectionState == ConnectionState.done){
            print('llamo lista de actores');
            return _listActorsMovie(snapshot.data);
          }else{
            print('llamo lista a progress');
            return Center(
              
              child: CircularProgressIndicator(),
            );
          }
    }
  );

}
Widget _listActorsMovie(List<ActorDAO> actors) {
    return SingleChildScrollView( 
      scrollDirection: Axis.horizontal,
      child: Row(
        children: actors.map((actor) =>     
        Container(
          padding: EdgeInsets.all(3.0),
          child: Column(
              children: [
                CircleAvatar(backgroundImage: new NetworkImage('https://image.tmdb.org/t/p/w500/${actor.profile_path}'), radius: 45.0, backgroundColor: Colors.white),
                Text(actor.original_name, style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold, fontSize: 12.0),),
                Text(actor.character, style: TextStyle(color: Colors.white, fontSize: 10.0),),
              ]              
          )
        )
    
        ).toList(),
      )
    );
    
  }

  Widget _imageMovie(int movieId){
  ApiImages apiImage= ApiImages();
  return FutureBuilder(
    future: apiImage.getImages(movieId),
    builder: (BuildContext context, AsyncSnapshot<List<ImagesDAO>> snapshot){
      if(snapshot.hasError){
            return Center(
              child: Text("Has error in this request :(")
              );
          }else if(snapshot.connectionState == ConnectionState.done){
            print('llamo lista de actores');
            return _listImagesMovie(snapshot.data);
          }else{
            print('llamo lista a progress');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
    }
  );

}
Widget _listImagesMovie(List<ImagesDAO> images) {
  print('filepath: ${images[0].file_path}');
    return SingleChildScrollView( 
      scrollDirection: Axis.horizontal,
      child: Row(
        children: images.map((image) =>   
        Container(
          padding: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: 
            Image.network('https://image.tmdb.org/t/p/w500/${image.file_path}', width: 200, height: 200,),
          )
        )
        
        ).toList(),
      )
    );
    
  }




class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key,
  @required this.movie, 
  @required this.ban,
  }) : super(key: key);

  final Map<String,dynamic> movie;
  final int ban;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(movie,ban);
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {      
    bool _isFavoriteOn=true;
    Map<String,dynamic> movieMap;
    int bandera;
    DatabaseHelper _database= DatabaseHelper();

     _MyStatefulWidgetState(movie,ban){
    this.movieMap=movie;
    this.bandera=ban;
    if(ban==1){
      _isFavoriteOn=true;
    }else{
      _isFavoriteOn=false;
    }
   
  }
  @override
  Widget build(BuildContext context) {

    return IconButton(
            alignment: Alignment.topRight,
            icon: Icon(Icons.favorite),
            iconSize: 35,
            color: _isFavoriteOn ? Colors.red[400] : Colors.red[100],
            focusColor: Colors.purple,
            splashColor: Colors.cyan,
            disabledColor: Colors.red[100],
            highlightColor: Colors.red[400],
            onPressed: (){
              setState(() {
                  _isFavoriteOn = !_isFavoriteOn;
                  if(_isFavoriteOn){
                    FavoriteDAO objMOVIE = FavoriteDAO(
                       id: movieMap['id'],
                       backdropPath: movieMap['backdroppath'],
                       overview: movieMap['overview'],
                       posterPath: movieMap['posterpath'],
                       title: movieMap['title'],
                       voteAverage : movieMap['voteaverage'],
                       email: "naomiog98@gmail.com"
                      );
                      print('obj : ${movieMap['id']}');
                      print(objMOVIE.toJSON());
                      _database.insert('tbl_favorite', objMOVIE.toJSON());
                      
                  }else{
                    _database.delete('tbl_favorite', movieMap['id']);
                  }
                  print(_isFavoriteOn);
                  
                  
                });
                                            
           });
    
  }
}
