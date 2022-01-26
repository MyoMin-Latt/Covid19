import 'package:covid19/object/country_ob.dart';
import 'package:flutter/material.dart';

class CountryWiget extends StatelessWidget {
  List<CountryOb> countryList;
  CountryWiget(this.countryList, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return countryList.isEmpty? Center(child: Text("no data")): Card(
      child: ListView.builder(
            itemCount: countryList.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(countryList[index].country!),
                Text(countryList[index].confirmed.toString())
              ],
            ),
              );
            }
          ),
    );
  }
}