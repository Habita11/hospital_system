import 'dart:convert';
import 'dart:typed_data';

import 'package:cohms/views/03.components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Dummy extends StatelessWidget {
 Future<Uint8List> getData()async{
   var result=await http.post(Uri.parse("https://matted-subtotals.000webhostapp.com/devices_view.php?device_code=159357"));
  Uint8List image= base64Decode(jsonDecode(result.body)[0]["URL"]);
  return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:FutureBuilder(
        future: getData(),
          builder: (context,snapshot){
          if(snapshot.hasData)
       { return Column(
          children: [
            Image.memory(snapshot.data!)
          ],
        );
      }else{
            return CircularProgressIndicator();
          }
        }) ,
    );
  }
}
