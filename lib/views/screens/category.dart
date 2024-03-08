import 'package:flutter/material.dart';
import 'package:wallpaper_dev/controller/api_operations.dart';
import 'package:wallpaper_dev/model/photos_model.dart';
import 'package:wallpaper_dev/views/screens/full_screen.dart';
import '../widgets/custom_app_bar.dart';

class CategoryScreen extends StatefulWidget {
  final String catName;
  final String catImgUrl;
  const CategoryScreen(
      {super.key, required this.catName, required this.catImgUrl});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<PhotosModel> categoryImgList = [];

  getCategoryImages() async {
    categoryImgList =
        (await ApiOperations.getSearchWallpaperFromApi(widget.catName));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCategoryImages();
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
            Stack(
              children: [
                Image.network(
                  widget.catImgUrl,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                  child: Column(
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      Text(
                        widget.catName,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 2),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Grid view
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 560,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 400,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: categoryImgList.length,
                itemBuilder: ((context, index) => GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                      imgUri: categoryImgList[index].imgSrc)));
                        },
                        child: Container(
                          height: 600,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                                height: 600,
                                width: 50,
                                fit: BoxFit.cover,
                                categoryImgList[index].imgSrc),
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
