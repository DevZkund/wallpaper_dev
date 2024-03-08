import 'package:flutter/material.dart';
import 'package:wallpaper_dev/controller/api_operations.dart';
import 'package:wallpaper_dev/model/photos_model.dart';
import 'package:wallpaper_dev/views/screens/full_screen.dart';
import 'package:wallpaper_dev/views/widgets/custom_app_bar.dart';
import 'package:wallpaper_dev/views/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults = [];

  getSearchResult() async {
    searchResults = await ApiOperations.getSearchWallpaperFromApi(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: const CustomAppBar(word1: "Wallpaper", word2: "Dev"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const CustomSearchBar()),
            const SizedBox(
              height: 10,
            ),

            // Grid view
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 670,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 400,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: searchResults.length,
                itemBuilder: ((context, index) => GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                      imgUri: searchResults[index].imgSrc)));
                        },
                        child: Hero(
                          tag: searchResults[index].imgSrc,
                          child: Container(
                            height: 800,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                  height: 800,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  searchResults[index].imgSrc),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Developed by: DEVZKUND"),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
