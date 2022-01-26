import 'package:covid19/object/countries_ob.dart';
import 'package:covid19/object/response_ob.dart';
import 'package:covid19/page/country/country_bloc.dart';
import 'package:covid19/widget/countries_widget.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({ Key? key }) : super(key: key);
 
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  final _bloc = CountriesBloc();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.getCountriesData();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ResponseOb>(
        stream: _bloc.getCountriesStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot){
            ResponseOb? respOb = snapshot.data;
            if(snapshot.hasData){
            if(respOb!.msgState == MsgState.loading){
            return Center(
              child: CircularProgressIndicator(),
              );
            }

            else if(respOb.msgState == MsgState.data){
              List<CountriesOb> countryList = respOb.data;
              return CountriesWidget(countryList);
            }

            else{
              if(respOb.errState == ErrState.serverErr){
                return Text("500\nServer Error");
              }
              else if(respOb.errState == ErrState.unknowErr){
                return Text("404\nNot Found Error");
              }
              else{
                return Text("Unknow Error");
              }
            }
            }
            else{
              return Center(
                child: Text("Empty Data"),
              );
            }

          
        }
      )
    );
  }
}