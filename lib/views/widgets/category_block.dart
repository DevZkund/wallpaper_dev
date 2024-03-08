import 'package:flutter/material.dart';
import 'package:wallpaper_dev/views/screens/category.dart';

class CategoryBlock extends StatelessWidget {
  final String catImgName;
  final String catImgUrl;
  const CategoryBlock(
      {super.key, required this.catImgName, required this.catImgUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(catName: catImgName, catImgUrl: catImgUrl)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                height: 50,
                width: 100,
                fit: BoxFit.cover,
                catImgUrl,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Positioned(
              left: 30,
              top: 15,
              child: Text(
                catImgName,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
