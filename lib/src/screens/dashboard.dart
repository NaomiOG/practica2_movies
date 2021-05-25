

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/userdao.dart';
import 'package:practica2_2021/src/utils/settings.dart';

class Dashboard extends StatelessWidget{

   Dashboard({
    Key key,
    @required this.email,
  }) : super(key: key);

  final String email;


  @override
  Widget build(BuildContext context) {
    print('email: $email');

    DatabaseHelper _database= DatabaseHelper();

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), backgroundColor: Settings.colorHeader,),
      drawer: FutureBuilder(
        future: _database.getUser('naomiog98@gmail.com'),      
        builder: (BuildContext context, AsyncSnapshot<UserDAO> snapshot){
          print(snapshot.data);
          var currentAccountPicture2 = snapshot.data != null
                          ? ClipOval(child: Image.file(File(snapshot.data.photousr), fit: BoxFit.cover, width: 200, height:200,),)
                          : CircleAvatar(backgroundImage: NetworkImage('https://i.pinimg.com/originals/77/3e/4a/773e4a6b450dea859d9c0b9d45030ae6.png'),);
                    return Drawer(
                    child: ListView(
                      children: [
                        UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: Settings.colorHeader
                          ),
                          accountName: Text('Naomi Ortiz González'),
                          accountEmail: Text('naomiog98@gmail.com'),
                          currentAccountPicture: currentAccountPicture2,
                onDetailsPressed: (){
                  Navigator.pushNamed(context,'/profile');
                },
              ),
              ListTile(
                //posiciona el mensaje a la izq o der
                leading: Icon(Icons.trending_up, color: Settings.colorIcons,),
                title: Text('Trending'),
                onTap: (){
                  Navigator.pushNamed(context, '/popular');
                },
                trailing: Icon(Icons.chevron_right, color: Settings.colorIcons),
              ),
              ListTile(
                leading: Icon(Icons.search, color: Settings.colorIcons,),
                title: Text('Search'),
                onTap: (){
                  Navigator.pop(context);
                },
                trailing: Icon(Icons.chevron_right, color: Settings.colorIcons),
              ),
              ListTile(
                leading: Icon(Icons.favorite, color: Settings.colorIcons,),
                title: Text('Favorites'),
                onTap: (){
                  Navigator.pushNamed(context, '/favorite');
                },
                trailing: Icon(Icons.chevron_right, color: Settings.colorIcons),
              ),
              ListTile(
                leading: Icon(Icons.contact_page, color: Settings.colorIcons,),
                title: Text('Contact us'),
                onTap: (){
                  Navigator.pushNamed(context, '/contact');
                },
                trailing: Icon(Icons.chevron_right, color: Settings.colorIcons),
              ),
            ],
          ),
        );
        }
      ),
    );
  }

}