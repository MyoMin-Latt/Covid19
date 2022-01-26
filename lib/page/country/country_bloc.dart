
import 'dart:async';
import 'dart:convert';
import 'package:covid19/object/countries_ob.dart';
import 'package:covid19/utlis/contant.dart';
import 'package:http/http.dart' as http;
import 'package:covid19/object/response_ob.dart';

class CountriesBloc{
  final StreamController<ResponseOb> _controller = StreamController();
  Stream<ResponseOb> getCountriesStream() => _controller.stream;

  getCountriesData()async{
    ResponseOb respOb = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(respOb);
    var response = await http.get(Uri.parse(baseCountriesUrl));
    print("Countries StatusCode : " +response.statusCode.toString());
    if(response.statusCode == 200){
      List<dynamic> list = jsonDecode(response.body);
      List<CountriesOb> countriesList = [];
      for (var element in list) {
        countriesList.add(CountriesOb.fromJson(element));
      }
      respOb.msgState = MsgState.data;
      respOb.data = countriesList;
      _controller.sink.add(respOb);
    }

    else if(response.statusCode == 500){
      respOb.data = null;
      respOb.msgState = MsgState.error;
      respOb.errState = ErrState.serverErr;
    }

    else if(response.statusCode == 404){
      respOb.data = null;
      respOb.msgState = MsgState.error;
      respOb.errState = ErrState.notFoundErr;
    }

    else{
      respOb.data = null;
      respOb.msgState = MsgState.error;
      respOb.errState = ErrState.unknowErr;
    }


  }
}