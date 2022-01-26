import 'package:covid19/object/summary_ob.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatelessWidget {
  SummaryOb summaryOb;
  HomeWidget(this.summaryOb, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue.shade200,
          padding: EdgeInsets.all(2),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Global Update List"),
                Text("Update Time : " + DateFormat('EEEE dd-MMM-yyyy').format(DateTime.parse(summaryOb.date!))),
                Row(
                  
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('New Confirmed : ' + summaryOb.global!.newConfirmed.toString()),
                          Text('New Recovered : ' + summaryOb.global!.newRecovered.toString()),
                          Text('New Deaths : ' + summaryOb.global!.newDeaths.toString()),
                        ],
                      ),
                    ),
          
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Confirmed : ' + summaryOb.global!.totalConfirmed.toString()),
                          Text('Total Recovered : ' + summaryOb.global!.totalRecovered.toString()),
                          Text('Total Deaths : ' + summaryOb.global!.totalDeaths.toString()),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(10),
          child: Text("Update List per Each Country")
        ),

        Expanded(
          child: ListView.builder(
            itemCount: summaryOb.countries!.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(summaryOb.countries![index].country!),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('New Confirmed : ' + summaryOb.countries![index].newConfirmed.toString()),
                          Text('New Recovered : ' + summaryOb.countries![index].newRecovered.toString()),
                          Text('New Deaths : ' + summaryOb.countries![index].newDeaths.toString()),
                        ],
                      ),
                    ),
          
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Confirmed : ' + summaryOb.countries![index].totalConfirmed.toString()),
                          Text('Total Recovered : ' + summaryOb.countries![index].totalRecovered.toString()),
                          Text('Total Deaths : ' + summaryOb.countries![index].totalDeaths.toString()),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
              );
            }
          )
        )
      ],
    );
  }
}





