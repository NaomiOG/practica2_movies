import "package:flutter/material.dart";
import 'package:practica2_2021/src/screens/dashboard.dart';

class Login extends StatefulWidget{
  Login({Key key}) : super(key:key);
  @override
  _LoginState createState()=>_LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
  var emailController=TextEditingController();
  var pwdController=TextEditingController();
  final popcorn= Image.network('https://image.freepik.com/vector-gratis/ilustracion-icono-palomitas-maiz-aislado_385450-88.jpg',width: 250,height: 120,);

  final txtEmail=TextFormField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: 'Introduce el email',//placeholder
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      ),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
      
    ),
  );
  final txtPwd=TextFormField(
    controller: pwdController,
    keyboardType: TextInputType.text,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Introduce el password',//placeholder
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
      

    ),
  );

  final loginButton = RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    child: Text('Validar Usuario', style: TextStyle(color:Colors.white),),
    color: Colors.blue[300],
    onPressed:(){
        //validar usuario mediante API
        //mete una pantalla mediante un alias
       // Navigator.pushNamed(context,'/dashboard');
        Navigator.push(context, MaterialPageRoute(builder:(context)=> Dashboard(email: emailController.text)));
    }
  );
  
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://st2.depositphotos.com/1813957/6716/i/600/depositphotos_67168205-stock-photo-beautiful-colorful-pastel-background-texture.jpg'),
              fit: BoxFit.fill
            )
          ),
        ),
        Card(
          color: Colors.white,
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,//se ajusta al contenido que tiene
              children: [
                //cajas de texto que conforma el formulario de captura
                txtEmail,
                SizedBox(height:10,),//espacio entre los dos campos
                txtPwd,
                SizedBox(height:10,),//espacio entre los dos campos
                loginButton
              ],
            ),
          ),
       ),
        Positioned(
          child: popcorn,
          bottom: 180,
          )
      ],
    );
  }
}