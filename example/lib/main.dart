import 'package:flutter/material.dart';
import 'package:z_grouped_list/z_grouped_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Map<String, dynamic>> books =[
    {"name": "Atomic Habits" , "year": 2018},
    {"name": "The Subtle art" , "year": 2018},
    {"name": "Jurassic Park" , "year": 1990},
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Grouped List"),
      ),


      body: Column(
        children: [

        ZGroupedList.grid(
        shrinkWrap: true,
        crossAxisCount: 3,
        items: books,
        sortBy: (item){
          int year = item['year'];
          return year;
        },
        itemBuilder: (context, item){
          String? name = item['name'];
          return Text(name ?? "empty");
        },
        groupSeparatorBuilder: (year) {
          return Text(year.toString(),);
        },

        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 80,
            childAspectRatio: 5 / 9,
            crossAxisSpacing: 25,
            mainAxisSpacing: 15),
        )],
      ),

    );
  }
}
