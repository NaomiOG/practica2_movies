import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactScreen extends StatefulWidget{
  ContactScreen({Key key}) : super (key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>{

  @override
  Widget build(BuildContext context){
    Completer<GoogleMapController> _controller = Completer();

    CameraPosition _myPosition = CameraPosition(
      target: LatLng(20.5417018,-100.8130878),
      zoom: 25.0
    );

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _myPosition,
        onMapCreated:(GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton:_buildBoomMenu(),
       
    );
  }
}

_buildBoomMenu(){
         return BoomMenu(
           animatedIcon: AnimatedIcons.menu_close,
           animatedIconTheme: IconThemeData(size:20),
           overlayColor: Colors.black,
           overlayOpacity: 0.7,
           children: [
             MenuItem(
               child: Icon(MdiIcons.gmail),
               title: 'Email',
               titleColor: Colors.green[850],
               subtitle: 'naomiog98@itcelaya.edu.mx',
               subTitleColor: Colors.grey[850],
               backgroundColor: Colors.blue[50],
               onTap: () => _sendEmail()
             ),
             MenuItem(
               child: Icon(MdiIcons.phone),
               title: 'Phone Number',
               titleColor: Colors.green[850],
               subtitle: '4611212331',
               subTitleColor: Colors.grey[850],
               backgroundColor: Colors.blue[50],
               onTap: () => _callPhone()
             ),
             MenuItem(
               child: Icon(MdiIcons.message),
               title: 'Message',
               titleColor: Colors.green[850],
               subtitle: '4616119380',
               subTitleColor: Colors.grey[850],
               backgroundColor: Colors.blue[50],
               onTap: () => _sendMessage()
             )
           ],

           
         );
}

_callPhone() async{
  const tel='tel: 4611212331';
  if( await canLaunch(tel)){
    await launch(tel);
  }


}
_sendEmail() async{
  final Uri params = Uri(
    scheme:'mailto',
    path:'naomiog98@gmail.com',
    query: 'subject=Enviando email&body=Hola desde mi app'
  );
  var email = params.toString();
  if( await canLaunch(email)){
    await launch(email);
  }

  
}
_sendMessage() async{
  const tel='sms: 4611212331';
  if( await canLaunch(tel)){
    await launch(tel);
  }
}
       