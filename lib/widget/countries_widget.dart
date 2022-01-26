import 'package:covid19/object/countries_ob.dart';
import 'package:flutter/material.dart';

class CountriesWidget extends StatefulWidget {
  List<CountriesOb> countriesList;
  CountriesWidget(this.countriesList, { Key? key }) : super(key: key);

  @override
  State<CountriesWidget> createState() => _CountriesWidgetState();
}

class _CountriesWidgetState extends State<CountriesWidget> {

  List<CountriesOb> selectCountriesList = [];

  TextEditingController _selectCTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _selectCTEC,
            onChanged: (str){
              if(str.isEmpty){
                selectCountriesList;
              }
              else{
                selectCountriesList = widget.countriesList.where((element) {
                  return element.country!.toLowerCase().contains(str.toLowerCase());
                }).toList();
              }
              setState(() {
                
              });
            },
            decoration: InputDecoration(
              label: Text("Select Country")
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectCTEC.text.isEmpty? widget.countriesList.length: selectCountriesList.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: (){
                    Navigator.of(context).pop(_selectCTEC.text.isEmpty? widget.countriesList[index].slug: selectCountriesList[index].slug);
                  },
                  child: Card(
                    child: Text(_selectCTEC.text.isEmpty? widget.countriesList[index].country!: selectCountriesList[index].country!),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}