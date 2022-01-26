

import 'package:covid19/object/country_ob.dart';
import 'package:covid19/object/response_ob.dart';
import 'package:covid19/page/country/country_page.dart';
import 'package:covid19/page/search/search_bloc.dart';
import 'package:covid19/widget/country_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final _bloc  = SearchBloc();
  final TextEditingController _chooseTC = TextEditingController();
  String dateRange = "Select Date Range";
  String? startDate;
  String? endDate;
  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search by country"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context){
                        return const CountryPage();
                      } 
                    )
                  ).then((value) {
                    if(value != null){
                      _chooseTC.text = value;
                    }
                     
                  });
                },
                child: TextField(
                  enabled: false,
                  controller: _chooseTC,
                  decoration: InputDecoration(
                    label: Text("choose country")
                  ),
                ),
              ),
            ),

            OutlinedButton(
              onPressed: (){
                showDateRangePicker(
                  context: context, 
                  firstDate: DateTime(2020), 
                  lastDate: DateTime.now(),
                ).then((value) {
                  startDate = value!.start.toString();
                  endDate = value.end.toString();
                  String sDate = DateFormat("dd/ MMM/ yyy").format(DateTime.parse(value.start.toString()));
                  String eDate = DateFormat("dd/ MMM/ yyyy").format(DateTime.parse(value.end.toString()));
                  dateRange = sDate + " - " + eDate;
                  setState(() {
                    
                  });
                });
                
              }, 
              child: Text(dateRange)
            ),

            ElevatedButton(
              onPressed: (){
                if(_chooseTC.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please choose country"))
                  );
                  return;
                }
                if(startDate==null || endDate == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select date Range"))
                  );
                  return;
                }
                _bloc.getCountryData(_chooseTC.text, startDate!, endDate!);
              }, 
              child: Text("Search")
            ),

            Expanded(
              child: StreamBuilder<ResponseOb>(
                stream: _bloc.getCountryStream(),
                builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot){
                  ResponseOb? respOb = snapshot.data;
                  if(snapshot.hasData){
                    if(respOb!.msgState == MsgState.loading){
                      return Center(
                        child: CircularProgressIndicator(),
                        );
                      }

                      else if(respOb.msgState == MsgState.data){
                        List<CountryOb> countryList = respOb.data;
                        return CountryWiget(countryList);
                      }

                    else{
                      if(respOb.errState == ErrState.serverErr){
                        return Text("500\nServer Error");
                      }
                      else if(respOb.errState == ErrState.unknowErr){
                        return Text("404\nNot Found Error");
                      }
                      else{
                        return Center(child: Text("Unknow Error"));
                      }
                    }
                  }

                  else{
                    return Center(child: Text("Empty data.\nCheck your country & Date Range"),);
                  }
                },
              ) 
            )
          ],
        ),
      ),
    );
  }
}