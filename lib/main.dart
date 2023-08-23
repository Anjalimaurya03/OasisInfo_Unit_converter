import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Converter(),
      );
  }
}

class Converter extends StatefulWidget {
  const Converter();

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override

  void initState(){
    userInput = 0;
    _startMeasures = measures[0];
    _convertMeasures = measures[1];
    super.initState();
  }
  final List<String> measures = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Pounds(lbs)',
    'ounces'
  ];
final Map<String,int> measuresMap
  =
  {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 3,
    'Kilograms': 4,
    'Feet': 5,
    'Pounds(lbs)': 6,
    'ounces': 7

  };

  dynamic formulas ={

    '0':[1,0.001,0,0,3.280,0.0006213,0],
    '1':[1000,1,0,0,3280.84,0,6213,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220,0.03],
    '3':[0,0,1000,1,0,0,2.2046,35.274],
    '4':[0.0348,0.00030,0,0,1,0.000189],
    '5':[1609.34,1.60934,0,05280,1,0,0],
    '6':[0,0,453.592,0.4535,0,0,1,16],
    '7':[0,0,28.3495,0.02834,3.28084,0,0.1]
  };

void convert(double value,String from,String to)
{
  int nFrom = measuresMap[from] as int;
  int nTo = measuresMap[to] as int;
  var multi = formulas[nFrom.toString()][nTo];
  var result = value *multi;

  if(result == 0)
    resultMessage = 'Cannot Performed This Conversion :-(';
  else{
    resultMessage = '${(userInput.toString())} ${_startMeasures} are ${result.toString()} $_convertMeasures .';
  }
  setState(() {
    resultMessage = resultMessage;
  });
}


  late double userInput;
  late String _startMeasures;
  late String _convertMeasures;
  String resultMessage= '';



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                const Text(
                  'Measures',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ), 
                ), //text
                const Text(
                  'Converters!',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ), 
                ), //text
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (text){

                      var input = double.tryParse(text);
                      if(input != null)
                        setState(() {
                          userInput = input;
                        });


                    },

                    style:const  TextStyle(
                      fontSize: 22,
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: 'Enter Your Value',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //FROM
                const Text(
                    'From',
                  style: TextStyle(
                    fontWeight:  FontWeight.w700,
                    fontSize: 30
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _startMeasures,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber),
                        hint: const Text('Choose a Unit', style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 20

                          ),),

                        items: measures.map((String value){
                        return DropdownMenuItem(value: value,
                        child: Text(value),);
                      }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _startMeasures = value as String;
                          });
                        }, ),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                //TO

                const Text(
                  'To',
                  style: TextStyle(
                      fontWeight:  FontWeight.w700,
                      fontSize: 30
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _convertMeasures,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.amber),
                        hint:const  Text('Choose a Unit', style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 20
                        ),),

                        items: measures.map((String value){
                          return DropdownMenuItem(value: value,
                            child: Text(value),);
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _convertMeasures = value as String ;
                          });
                        }, ),
                    ),
                  ),
                ),

                const SizedBox(height: 50,),

                // CONVERT
                TextButton(
                  onPressed: (){
                    if (_startMeasures.isEmpty || _convertMeasures.isEmpty || userInput == 0)
                      return;
                    else
                      convert(userInput, _startMeasures, _convertMeasures);
                  },

                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                        'Convert',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber
                      ),),
                  ),
                ),
                const SizedBox(height: 25,),

                 Center(
                   child: Text(
                    resultMessage,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                ),
                 )

              ],

            ),
          ),

        ),
      ),
    );
  }
}

