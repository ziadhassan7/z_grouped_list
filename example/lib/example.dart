import 'package:flutter/material.dart';
import 'package:z_grouped_list/z_grouped_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const List<Map<String, dynamic>> _books =[
    {"name": "Atomic Habits" , "year": 2018},
    {"name": "The Miracle Morning" , "year": 2018},
    {"name": "Jurassic Park" , "year": 2019},
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Grouped List"),
        ),


        body: Column(
          children: [

            Expanded(
              child: ZGroupedList(
                // All items list
                items: _books,
                // What element should you sort by?
                sortBy: (item){
                  int year = item['year'];
                  return year;
                },
                // Item widget
                itemBuilder: (context, item){
                  String? name = item['name'];
                  return Text(name ?? "empty");
                },
                // Group separator widget
                groupSeparatorBuilder: (year) {
                  return Text(year.toString(),);
                }, ),
            )],
        ),

      ),
    );
  }
}