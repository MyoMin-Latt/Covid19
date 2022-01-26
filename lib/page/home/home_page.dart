import 'package:covid19/object/response_ob.dart';
import 'package:covid19/object/summary_ob.dart';
import 'package:covid19/page/home/home_bloc.dart';
import 'package:covid19/page/search/search_page.dart';
import 'package:covid19/utlis/contant.dart';
import 'package:covid19/widget/home_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _bloc = HomeBloc();
  @override
  void initState() {
    _bloc.getSummaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(baseUrl);
    // print(baseSummaryUrl);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context){
                  return SearchPage();
                }
                )
              );
            }, 
            icon: Icon(Icons.search)
          )
        ],
        title: Text("Move away Covid"),
      ),
      body: StreamBuilder<ResponseOb>(
        initialData: ResponseOb(msgState: MsgState.loading),
        stream: _bloc.getSummaryStream(),
        builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot){
          ResponseOb respOb = snapshot.data!;
          if(respOb.msgState == MsgState.loading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          else if(respOb.msgState == MsgState.data){
            SummaryOb summaryOb = respOb.data;
            return HomeWidget(summaryOb);
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

        },
      ),
    );
  }
}