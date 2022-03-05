import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/Data.dart';
import 'data_inf.dart';

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";
  DataInf ?inf;
  BuildContext context;
  HttpService(this.context, this.inf);
  getPosts() async {
    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Data> data = body
          .map(
            (dynamic item) => Data.fromJson(item),
          )
          .toList();
      inf?.getData(data);
      log('data: $data');
      return data;
    } else {
      return null;
    }
  }

  postData({String ?title,String? bodys,int ?userId}) async {

    Data data=Data(body: bodys,title: title,userId: userId);
    //tạo post
    Response response = await post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: json.encode(data.toJson()));

    int statusCode = response.statusCode;
    print('status code $statusCode');
    String body = response.body;
    print('$body');

  }

}
