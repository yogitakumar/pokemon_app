import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PokeHubClass.dart';
import 'pokemon_details.dart';
void main() => runApp(MaterialApp(
  title: 'Poke App',
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override

  HomePageState createState(){
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  var url="https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;
  @override
  void initState(){
     super.initState();
     fetchData();

  }
  fetchData() async{
//#######Coding to get local Json file##########
      var jsonData = await DefaultAssetBundle.of(context).loadString("assets/pokedex.json");
      var jsonResult = jsonDecode(jsonData);
      pokeHub = PokeHub.fromJson(jsonResult);
 // #############################

 // ###########json file  ############
 //var res = await http.get(url);
  //var decodedJson = jsonDecode(res.body);
  //pokeHub = PokeHub.fromJson(decodedJson);
  print(pokeHub.toJson());
 setState(() {});
 // #######end change Actual git hub#############################
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Pokemon App'),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body:
      pokeHub == null
          ? Center(
        child: CircularProgressIndicator(),
      )
      :GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon.map((poke)=>Padding(
    padding:const EdgeInsets.all(2.0),
            child:InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
                  pokemon: poke,
                )));
              },
              child: Hero(
                tag: poke.img,
                child: Card(
                  elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                    image:DecorationImage(
                    image:NetworkImage(poke.img)
                )
                ),
                    ),

                    Text(
                      poke.name,
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)
                    ),

                  ],
                ),
                ),
              ),
            )
        ))
            .toList(),
      ),

      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
