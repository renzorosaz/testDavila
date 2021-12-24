import 'package:flutter/material.dart';
import 'package:test_davila/listPromotionsScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  goToListPromotions(context) {
    print("ho");
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ListPromotionsScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  child: Image.asset('assets/pv2.png'),
                ),
                SizedBox(height: 30),
                Container(
                  child: Text('Registrate para ingresar', style: TextStyle(color: Colors.red)),
                ),
                SizedBox(height: 30),
                Container(child: Text("Foto de perfil")),
                SizedBox(height: 30),
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.person_outline_rounded, size: 50)),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Nombres"),
                    SizedBox(height: 8),
                    Container(
                      width: 340,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: nameController,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                          hintText: "Rodrigo Chambe Lupaca",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Apellidos",
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 340,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: lastNameController,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                          hintText: "Rodrigo Chambe Lupaca",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    MaterialButton(
                      minWidth: 340,
                      height: 60,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      onPressed: () {
                        goToListPromotions(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ListPromotionsScreen()),
                        // );
                      },
                      child: Text("Ingresar", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                Container(padding: EdgeInsets.only(right: 110, top: 5), child: Image.asset('assets/boxf.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
