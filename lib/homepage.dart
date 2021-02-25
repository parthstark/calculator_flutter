import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String equation="0";
  String result="0";
  double eqSize=48;
  double resSize=72;


  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=="C"){
        equation="0";
        result="0";
        eqSize=48;
        resSize=72;
      }
      else if(buttonText=="<-"){
        if(equation.length>1){
          equation=equation.substring(0,equation.length-1);
        }else{
          equation="0";
          result="0";
          eqSize=48;
          resSize=72;
        }
      }
      else if(buttonText=="="){
        eqSize=48;
        resSize=72;
        try {
          Parser p= new Parser();
          Expression exp=p.parse(equation);
          ContextModel cm=ContextModel();
          result='${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result="Error";
        }
      }
      else{
        eqSize=72;
        resSize=48;
        if(equation=="0"){
          equation=buttonText;
        }else{
          equation+=buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, double h, double w){
    return Container(
            margin: EdgeInsets.all(w*0.01),
            alignment: Alignment.center,
            child: FlatButton(
              splashColor: buttonColor,
              height: h*0.1,
              onPressed: ()=>buttonPressed(buttonText),
              child: Text(buttonText, style: TextStyle(color: Colors.black54, fontSize: 36),),
            ) ,
            width: w*0.225, 
            height: h*0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              shape: BoxShape.rectangle, 
              color: buttonColor, 
              border: Border.all(color:buttonColor,width:5)),
          );
  }

  @override
  Widget build(BuildContext context) {

    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator", style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)))
      ),
      body:Container(
        margin: EdgeInsets.all(w*0.01),
        alignment: Alignment.center,
        child:Column(children: [
        Scrollbar(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                                padding: EdgeInsets.fromLTRB(10,20,10,0),
                                child: Text(equation, style: TextStyle(color: Colors.black38, fontSize: eqSize),),
                    ),
                  ),
        ),
        Scrollbar(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                                padding: EdgeInsets.fromLTRB(10,20,10,0),
                                child: Text(result, style: TextStyle(color: Colors.black54, fontSize: resSize),),
                    ),
                  ),
        ),
        Expanded(child: Divider()),
        Row(children:[
          buildButton("C", Colors.pink[400], h, w),
          buildButton("%", Colors.pink[400], h, w),
          buildButton("<-", Colors.pink[400], h, w),
          buildButton("/", Colors.pink[400], h, w),
        ]),
        Row(children:[
          buildButton("7", Colors.cyan[200], h, w),
          buildButton("8", Colors.cyan[200], h, w),
          buildButton("9", Colors.cyan[200], h, w),
          buildButton("*", Colors.pink[400], h, w),
        ]),
        Row(children:[
          buildButton("4", Colors.cyan[200], h, w),
          buildButton("5", Colors.cyan[200], h, w),
          buildButton("6", Colors.cyan[200], h, w),
          buildButton("-", Colors.pink[400], h, w),
        ]),
        Row(children:[
          buildButton("1", Colors.cyan[200], h, w),
          buildButton("2", Colors.cyan[200], h, w),
          buildButton("3", Colors.cyan[200], h, w),
          buildButton("+", Colors.pink[400], h, w),
        ]),
        Row(children:[
          buildButton("00", Colors.cyan[200], h, w),
          buildButton("0", Colors.cyan[200], h, w),
          buildButton(".", Colors.cyan[200], h, w),
          buildButton("=", Colors.pink[400], h, w),
        ])
    ],),
    ),
    );
  }
}
