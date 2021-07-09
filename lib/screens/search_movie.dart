import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moviedatabase/models/data_model.dart';
import 'package:moviedatabase/screens/search_result.dart';

class SearchMovies extends StatefulWidget {
  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  static TextEditingController searchTextEditingController = TextEditingController();

  //URL
  var url = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=b9a825a82ebe362e74f0a59439b3b6de&language=en-US");

  //RestApi Method
  Future<List<DataModel>> _getAllData() async {
    var response = await http.get(url);
    var decodedData = json.decode(response.body);
    print(decodedData);
    List<DataModel> data = [];
    for (var i in decodedData['results']) {
      DataModel dataModel = DataModel(
          id: i['id'],
          title: i['title'],
          original_language: i['original_language'],
          original_title: i['original_title'],
          overview: i['overview'],
          popularity: i['popularity'],
          poster_path: i['poster_path'],
          vote_average: i['vote_average'.toString()],
          vote_count: i['vote_count'],
          release_date: i['release_date']);
      data.add(dataModel);
    }
    return data;
  }

  //Init Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllData();
  }


  bool tapped = false;
  //Search Movie
  homeScreen() {
    return FutureBuilder(
      future: _getAllData(),
      builder: (c, s) {
        if (s.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        } else if (s.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: s.data.length,
              itemBuilder: (c, i) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://image.tmdb.org/t/p/w500/'+"${s.data[i].poster_path}",
                            height: 200,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.data[i].original_title,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 10,),
                              Text(
                               "Released Date:  ${s.data[i].release_date}",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.blue),
                              ),
                              SizedBox(height: 10,),
                              Container(

                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                   "${s.data[i].vote_average.toString()} TMDB",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {

                  },
                );
              });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Home",style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0,),
            child: searchView(),
          ),
          homeScreen()



        ],
      ),
    );
  }

  Widget searchView(){
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade800,width: 2),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 15.0,bottom: 5.0),
              child: TextFormField(
                cursorColor: Colors.black,
                controller: searchTextEditingController,
                decoration: InputDecoration(
                  hintText: "Search for movies",
                  hintStyle: GoogleFonts.montserrat(fontSize: 14,color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0,right: 10.0),
            child: GestureDetector(
              child: Icon(Icons.search,color: Colors.black,),
              onTap: (){

               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   SearchResult(searchText: searchTextEditingController.text)
               ));

              },
            ),
          )

        ],
      ),
    );
  }
}
