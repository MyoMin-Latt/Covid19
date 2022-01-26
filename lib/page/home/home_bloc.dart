
import 'dart:async';
import 'dart:convert';
import 'package:covid19/object/summary_ob.dart';
import 'package:covid19/utlis/contant.dart';
import 'package:http/http.dart' as http;
import 'package:covid19/object/response_ob.dart';

class HomeBloc{
  final StreamController<ResponseOb> _controller = StreamController();
  Stream<ResponseOb> getSummaryStream() => _controller.stream;

  getSummaryData()async{
    ResponseOb respOb = ResponseOb();
    var response = await http.get(Uri.parse(baseSummaryUrl));
    print("Summary StatusCode : " +response.statusCode.toString());
    if(response.statusCode == 200){
      Map<String, dynamic> map = jsonDecode(response.body);
      SummaryOb summaryOb = SummaryOb.fromJson(map); 
      respOb.msgState = MsgState.data;
      respOb.data = summaryOb;
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