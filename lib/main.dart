import 'package:flutter/material.dart';

void main() => runApp(AppConv());

class AppConv extends StatefulWidget {
  @override
  _AppConvState createState() => _AppConvState();
}

class _AppConvState extends State<AppConv> {
 
  final Map<String, int> _medidaMap = {
    'Metros' : 0,
    'Quilômetros' : 1,
    'Gramas' : 2,
    'Quilogramas' : 3,
    'Pés' : 4, 
    'Milhas' : 5,
    'Libras': 6,
    'Onças' : 7,
  };

  final dynamic _formulas = {
  '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
  '1':[1000,1,0,0,3280.84,0.621371,0,0],
  '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
  '3':[0,0,1000,1,0,0,2.20462,35.274],
  '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
  '5':[1609.34, 1.60934,0,0,5280,1,0,0],
  '6':[0,0,453.592,0.453592,0,0,1,16],
  '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };

  double _valorinserido;

  final List<String> _medidas = [
    'Metros', 'Quilômetros', 'Gramas', 'Quilogramas',
    'Pés', 'Milhas', 'Libras', 'Onças',
  ];

  String _iniMedida, _medConvertido, _mensagemResult;

  void converter (double valor, String de, String para){
    int nDe = _medidaMap[de];
    int nPara = _medidaMap[para];
    var mult = _formulas[nDe.toString()][nPara];
    var result = valor*mult;
    if(result == 0){
      _mensagemResult = 'Esta conversão não pode ser realizada';
    }
    else{
      _mensagemResult = '${_valorinserido.toString()}';
    }
    setState(() {
      _mensagemResult = _mensagemResult;
    });
  }

  @override
  void initState(){
    _valorinserido = 0;
    super.initState();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conversor de Medidas',
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.only(left: 35.0, top: 80.0,right: 35.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Conversor',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                       ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 70),
                      child: DropdownButton(
                        isExpanded: true,
                        items: _medidas.map((String valor){
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(), 
                        onChanged: (valor){
                          setState(() {
                          _iniMedida = valor;
                          });
                        },
                        value: _iniMedida,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 50),
                      child: TextField(
                        onChanged:(text){
                          var rv = double.tryParse(text);
                          if(rv != null){
                            _valorinserido = rv;
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.headline5,
                        decoration: InputDecoration(
                          hintText: 'Por favor, insira um valor',
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    // Align(
                    // alignment: Alignment.centerRight,
                    // child: FloatingActionButton(
                    //   child: Icon(Icons.swap_vert),
                    //   onPressed: (){}, 
                    //   ),
                    // ),   
                    Container(
                      padding: EdgeInsets.only(right: 70),
                      child: DropdownButton(
                        isExpanded: true,
                        items: _medidas.map((String valor){
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(), 
                        onChanged: (valor){
                          setState(() {
                          _medConvertido = valor;
                          });
                        },
                        value: _medConvertido,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      alignment: Alignment.centerLeft,
                      child: Text((_valorinserido == null) ? '' : _valorinserido.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ), 
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 100),
                  child:RaisedButton(
                    child: Text('Converter'),
                    onPressed: () {
                      if(_iniMedida.isEmpty || _medConvertido.isEmpty || _valorinserido == 0){
                        return;
                      }
                      else{
                        converter(_valorinserido, _iniMedida, _medConvertido);
                      }
                    },
                  ),
                ), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}