import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/userdao.dart';
import 'package:practica2_2021/src/screens/dashboard.dart';

class ProfileScreen extends StatefulWidget{
  ProfileScreen({Key key}) : super(key:key);
  @override
  _ProfileScreenState createState()=>_ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  final picker = ImagePicker();
  String imagePath= "";

  DatabaseHelper _database;

  @override
  void initState(){
    super.initState();
    _database = DatabaseHelper();
  }
  
  @override
  Widget build(BuildContext context) {  
    TextEditingController nombreController=TextEditingController();
    TextEditingController paternoController=TextEditingController();
    TextEditingController maternoController=TextEditingController();
    TextEditingController telefonoController=TextEditingController();
    TextEditingController emailController=TextEditingController();

    

    final imgFinal = imagePath == ""
    ? CircleAvatar(
      backgroundImage: NetworkImage('https://i.pinimg.com/originals/77/3e/4a/773e4a6b450dea859d9c0b9d45030ae6.png'),
      radius: 80.0,
    )
    : ClipOval(
      child: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: 200,
        height: 200,
      )
    );


    final txtEmail=TextFormField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      prefixIcon: Icon(
                    Icons.email,
                    color: Colors.cyan[300],
                    size: 24.0,
                    ),
      hintText: 'Email',//placeholder
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      ),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
      
    ),
  );
  final txtNombre=TextFormField(
    controller: nombreController,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(
                    Icons.person_pin,
                    color: Colors.cyan[300],
                    size: 24.0,
                    ),
      hintText: 'Nombre',//placeholder
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
    ),
  );

final txtApellidoMat=TextFormField(
    controller: maternoController,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(
                    Icons.person_pin,
                    color: Colors.cyan[300],
                    size: 24.0,
                    ),
      hintText: 'Apellido Materno',//placeholder
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
    ),
  );
  final txtApellidoPat=TextFormField(
    controller: paternoController,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(
                    Icons.person_pin,
                    color: Colors.cyan[300],
                    size: 24.0,
                    ),
      hintText: 'Apellido Paterno',//placeholder
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
    ),
  );
  final txtTelefono=TextFormField(
    controller: telefonoController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      prefixIcon:  Icon(
                    Icons.phone,
                    color: Colors.cyan[300],
                    size: 24.0,
                    ),
      hintText: 'Teléfono',//placeholder
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
    ),
  );
  return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
      ),
      body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Opacity(
          opacity: .2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://st2.depositphotos.com/1813957/6716/i/600/depositphotos_67168205-stock-photo-beautiful-colorful-pastel-background-texture.jpg'),
                fit: BoxFit.fill
              )
            ),
          ),
        ),
        
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  FloatingActionButton(  
                    child: Icon(Icons.camera),
                    elevation: 20.0,
                    heroTag: null,
                    backgroundColor: Colors.cyan[200],
                    onPressed: () async {
                      final file = await picker.getImage(source: ImageSource.camera);//abrimos la cámara
                      imagePath = file.path;//la variable de clase obtiene la ruta donde se almacenó la ruta de la foto tomada
                      setState(() {});
                
                    }
                  ),
                  imgFinal,
                  FloatingActionButton(
                    child: Icon(Icons.save),
                    heroTag: null,
                    elevation: 20.0,
                    backgroundColor: Colors.cyan[200],
                    onPressed: (){
                      UserDAO objUSER = UserDAO(
                        nomusr: nombreController.text,
                        apepat: paternoController.text,
                        apemat: maternoController.text,
                        mailusr: emailController.text,
                        telusr: telefonoController.text,
                        photousr: imagePath
                      );
                      _database.insert('tbl_perfil', objUSER.toJSON());
                      print(objUSER.toJSON());
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => Dashboard(email: emailController.text,)),
                        ModalRoute.withName('/dashboard')
                      );
                    }
                  ),
              ],
            ),
            SizedBox(height:20,),//espacio entre los dos campos
            Card(
              color: Colors.cyan[50],
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,//se ajusta al contenido que tiene
                  children: [
                    txtNombre,
                    SizedBox(height:5,),//espacio entre los dos campos
                    txtApellidoPat,
                    SizedBox(height:5,),//espacio entre los dos campos
                    txtApellidoMat,
                    SizedBox(height:5,),//espacio entre los dos campos
                    txtTelefono,
                    SizedBox(height:5,),//espacio entre los dos campos
                    txtEmail
                  ],
                ),
              ),
          ),
          ],
        )    
      ],
    ),
  );

  }
}