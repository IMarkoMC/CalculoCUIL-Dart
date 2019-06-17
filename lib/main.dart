import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculador de CUIL',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Calculador de CUIL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String DNI = "";
  String Sex = "Selecciona tu sexo";
  String FinalDoc = "";
  String xy = "";
  List<int> Multiply = [3, 2, 7, 6, 5, 4, 3, 2];

  int Sum = 0;

  int Div = 0;

  int PreDig = 0;

  int Digit = 0;

  @override
  Widget build(BuildContext context) {


    void Calcular() {
      //Reinicio de integers por seguridad;
      Sum = 0;
      Div = 0;
      PreDig = 0;
      Digit = 0;

      if (DNI != "") {
        if (DNI.length == 8) {
          if (Sex != "Selecciona tu sexo") {
            //Seteando los valores correspondientes para cada sexo.
            if (Sex == "Masculino") {
              print("[DEBUG] Sexo seleccioado es masculino");

              xy = "23";
            } else if (Sex == "Femenino") {
              print("[DEBUG] Sexo seleccionado es femenino");

              xy = "20";
            }else{
              //Mostrar alerta de sexo invalido.

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Error"),
                      content: new Text("Sexo invalido."),
                    );
                  });

            }


            Sum += (int.parse(xy[0]) * 5);
            Sum += (int.parse(xy[1]) * 4);

            var i = 0;

            while (i < DNI.length) {
              try {
                Sum += (int.parse(DNI[i]) * Multiply[i]);
              }catch (error){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("Error"),
                        content: new Text("Error interno al realizar alguna de las operaciones."),
                      );
                    });
                break;
              }
              print("[DEBUG] Calculando: ${DNI[i]} * ${Multiply[i]}");
              print("[DEBUG] el resultado es: " + (int.parse(DNI[i]) * Multiply[i]).toString());
              i++;
            }
            print("[DEBUG] El resultado de la suma es: ${Sum}");

            Div = (Sum / 11).round();

            print("[DEBUG] El resultado de la divicion es ${Div}");

            PreDig = Sum - (Div * 11);

            print("[DEBUG] El valor de Predig es: ${PreDig}");

            Digit = (11 - PreDig);

            //Actualizando el texto.
            setState(() {
              FinalDoc = "Tu cuil es: ${xy}-${DNI}-${Digit}";
            });
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Error"),
                    content: new Text("Selecciona tu sexo"),
                  );
                });
          }
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Error"),
                  content: new Text("Revisa que el DNI sea correcto"),
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Error"),
                content: new Text("El DNI no puede estar en blanco"),
              );
            });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => {DNI = value},
              decoration: InputDecoration(labelText: "Tu DNI"),
            ),
          ),

          Divider(),
          ListTile(
            title: Text(FinalDoc),
          ),

          ListTile(
              title:
                  RaisedButton(child: Text("Caclcular"), onPressed: Calcular) //llamar a la funcion para calcular el CUIL
          ),

          DropdownButton<String>(
            hint: new Text(Sex),
            items: <String>['Masculino', 'Femenino'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (val) => {
                  Sex = val,
                  this.setState(() {}) //Actualizando la hint
                },
          ),
        ],
      ),
    );
  }
}
