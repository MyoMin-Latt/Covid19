
import 'dart:async';
import 'dart:convert';
import 'package:covid19/object/country_ob.dart';
import 'package:covid19/utlis/contant.dart';
import 'package:http/http.dart' as http;
import 'package:covid19/object/response_ob.dart';

class SearchBloc{
  final StreamController<ResponseOb> _controller = StreamController();
  Stream<ResponseOb> getCountryStream() => _controller.stream;

  getCountryData(String country, String startDate, String endDate)async{
    ResponseOb respOb = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(respOb);
    var response = await http.get(Uri.parse(baseCountryUrl+country+"?from="+startDate+"&to="+endDate));
    print("Each Country StatusCode : " +response.statusCode.toString());
    if(response.statusCode == 200){
      List<dynamic> list = jsonDecode(response.body);
      List<CountryOb> countryList = [];
      for (var element in list) {
        countryList.add(CountryOb.fromJson(element));
      }
      respOb.msgState = MsgState.data;
      respOb.data = countryList;
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