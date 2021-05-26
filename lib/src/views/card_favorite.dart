

import 'package:flutter/material.dart';
import 'package:practica2_2021/src/models/favoritedao.dart';

class CardFavorite extends StatelessWidget{
const CardFavorite({
  Key key,
  @required this.favorite
  }) : super (key: key);

  final FavoriteDAO favorite;

  @override
  Widget build(BuildContext context){
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
            Container(
              child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage('https://image.tmdb.org/t/p/w500/${favorite.backdropPath}'),
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
                    Text(favorite.title, style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    MaterialButton(
                      onPressed: (){
                        Navigator.pushNamed(
                          context, '/detail',
                          arguments: {
                            'title': favorite.title,
                            'overview': favorite.overview,
                            'posterpath': favorite.posterPath,
                            'voteaverage': favorite.voteAverage,
                            'id': favorite.id,
                            'backdroppath':favorite.backdropPath,
                            'ban': 1,
                            'favorite':true
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