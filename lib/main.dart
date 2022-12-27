import 'dart:convert';
import 'package:api_demo/GetSampleApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<GetSampleApi>? apiList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter get api demo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if(apiList != null)
            getList()
        ],
      ),
    );
  }

  Widget getList(){
    return Expanded(
      child: ListView.builder(
          itemCount: apiList!.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 20),
                    child: Text("${apiList![index].body}"),
                  ),
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 20),
                    child: Text("${apiList![index].email}"),
                  ),
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 20),
                    child: Text("${apiList![index].name}"),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Future<void> getApiData() async {
    String url = "https://jsonplaceholder.typicode.com/comments";
    var result = await http.get(Uri.parse(url));
    // print(result.body);
    apiList = jsonDecode(result.body)
        .map((item) => GetSampleApi.fromJson(item))
        .toList()
        .cast<GetSampleApi>();
  }
}