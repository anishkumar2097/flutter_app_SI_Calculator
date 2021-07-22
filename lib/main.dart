
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
   runApp(MaterialApp(
     title: "SIC Calculator",
     theme: ThemeData(
       primaryColor: Colors.indigo,
       accentColor: Colors.amberAccent
     ),
     home: SIcalculator(),
   )
   );
}

class SIcalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIcalculatorState();
  }
  
}

class _SIcalculatorState extends State<SIcalculator> {

  var _curr=['Rupee','dollar','euro'];
  String dropdownValue = 'Rupee';
  TextEditingController textRateController=TextEditingController();
  TextEditingController textPrincipalController=TextEditingController();
  TextEditingController termEditController=TextEditingController();
  String displayResult='';
  var _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  resizeToAvoidBottomInset: false,

      appBar: AppBar(title: Text("SI Calculator"),),
      body: Container(
          margin: EdgeInsets.all(10.0),
         child:  ListView(children: <Widget>[
           getImageAsset(),
           getPrincipalTextField(),
           getRateTextField(textRateController),
           getRow(termEditController,_curr,dropdownValue),
           getRaiseButton(),
           getDescription(),
         ],

         ),
             )

      );


  }


  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 350.0, height: 220.0,);

    return Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
      child: image,);
  }

  Widget getPrincipalTextField() {
    return TextField(

      controller: textPrincipalController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Principal",
        hintText: 'Enter principal Eg. 2000',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),

      ),
    );
  }

  Widget getRateTextField(TextEditingController textRateController) {
    return Container(margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextField(

         controller: textRateController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Rate of Interest",
          hintText: 'Enter rate ..Eg. 5',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),

        ),
      ),);
  }

  Widget getRow(TextEditingController termEditController,var _curr,String dropDownValue) {

    return Container(
      margin: EdgeInsets.fromLTRB(0.0,10.0 ,0.0, 0.0),
      child:Row(

      children: <Widget>[
        Expanded(child: TextField(

          controller: termEditController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Term",
            hintText: 'Enter year Eg. 3',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
            ),

          ),
        )),
        Container(width: 5.0,),
        Expanded(child: DropdownButton<String>(
          value: dropDownValue,
          items: _curr.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),

        )) ,
      ],

    ) ,);
  }

Widget  getRaiseButton() {
    return Container(child:Row(
      children: [

        Expanded(child:
        RaisedButton(child: Text("Calculate"),
        padding: EdgeInsets.only(right: 4.0),
        onPressed:(){
         setState(() {

             this.displayResult=  _calculateTotalReturn();


         });
        },)),
        Container(width: 10.0,),
        Expanded(child: RaisedButton(
          child: Text("Reset"),
          onPressed: (){
          setState(() {
            _reset();
          });
          },
        ))
      ],
    ));
}

 Widget getDescription() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Text(displayResult,style: TextStyle(fontStyle:FontStyle.italic),),
    );
 }
   String _calculateTotalReturn(){
      double term= double.parse(termEditController.text) ;
      double amount= double.parse(textPrincipalController.text) ;
      double rate= double.parse(textRateController.text) ;

      double total=amount+(amount*rate*term)/100;
      String result='After $term year,your investment will be worth : $total';
      return result;
  }

  void  _reset(){
    textPrincipalController.text='';
    textRateController.text='';
    termEditController.text='';
    displayResult='';
  }

}




