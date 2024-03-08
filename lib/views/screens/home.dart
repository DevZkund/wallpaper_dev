import 'package:flutter/material.dart';
import 'package:wallpaper_dev/controller/api_operations.dart';
import 'package:wallpaper_dev/model/category_model.dart';
import 'package:wallpaper_dev/model/photos_model.dart';
import 'package:wallpaper_dev/views/screens/full_screen.dart';
import 'package:wallpaper_dev/views/widgets/category_block.dart';
import 'package:wallpaper_dev/views/widgets/custom_app_bar.dart';
import 'package:wallpaper_dev/views/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> trendingWalpaperList = [];
  List<CategoryModel> categoryItem = [];

  getTrendingWallpaper() async {
    trendingWalpaperList = await ApiOperations.getTrendingWallpaperFromApi();
    setState(() {});
  }

  getCategoryItems() async {
    categoryItem = ApiOperations.getCategoryListFromApi();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCategoryItems();
    getTrendingWallpaper();
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
            // Horizontal views
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryItem.length,
                  itemBuilder: ((context, index) => CategoryBlock(
                        catImgName: categoryItem[index].catImgName,
                        catImgUrl: categoryItem[index].catImgSrc,
                      )),
                ),
              ),
            ),
            // Grid view

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 590,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 400,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: trendingWalpaperList.length,
                itemBuilder: ((context, index) => GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                      imgUri:
                                          trendingWalpaperList[index].imgSrc)));
                        },
                        child: Hero(
                          tag: trendingWalpaperList[index].imgSrc,
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
                                  trendingWalpaperList[index].imgSrc),
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
