import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:practica2_2021/src/models/favoritedao.dart';
import 'package:practica2_2021/src/models/populardao.dart';

class CardPopular extends StatelessWidget{
const CardPopular({
  Key key,
  @required this.popular
  }) : super (key: key);

  final PopularDAO popular;
  

  @override
  Widget build(BuildContext context){
    DatabaseHelper _database= DatabaseHelper();
    int ban;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0,5.0),
            blurRadius: 2.5
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            FutureBuilder(
                future: _database.getMovie(popular.id),
                builder: (BuildContext context, AsyncSnapshot<FavoriteDAO> snapshot){
                  if(snapshot.hasError){
                    print("entre pero con error");
                    return Center(
                      child: Text("Has error in this request :(")
                      );
                  }else if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.data==null){
                      ban=2;
                    }
                    else{
                      ban=1;
                    }
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                      child: Container(),
                    );
                },
              ),
            Container(
              child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),
              fadeInDuration: Duration(milliseconds: 100),
              ),
            ),
            Opacity(
              opacity: .6,
              child: Container(
                height: 55.0,
                color: Colors.black,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(popular.title, style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    MaterialButton(
                      onPressed: (){
                        Navigator.pushNamed(
                          context, '/detail',
                          arguments: {
                            'title': popular.title,
                            'overview': popular.overview,
                            'posterpath': popular.posterPath,
                            'voteaverage': popular.voteAverage,
                            'id': popular.id,
                            'backdroppath':popular.backdropPath,
                            'ban' : ban,
                            'favorite': false
                          }
                        );
                      },
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.chevron_right, color: Colors.white,)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}