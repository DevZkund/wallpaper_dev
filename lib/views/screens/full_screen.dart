import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imgUri;

  const FullScreen({Key? key, required this.imgUri}) : super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  double _progress = 0.0;
  bool _downloading = false;

  Future<void> setWallpaper(dynamic screen) async {
    setState(() {
      _downloading = true;
      _progress = 0.0;
    });

    try {
      int location = screen;
      var file = await DefaultCacheManager().getSingleFile(widget.imgUri);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
    } on PlatformException catch (error) {
      print(error);
    } finally {
      setState(() {
        _downloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              btnShowBottomSheet(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imgUri),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (_downloading)
            Center(
              child: CircularProgressIndicator(
                value: _progress,
              ),
            ),
        ],
      ),
    );
  }

  Future<dynamic> btnShowBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white12,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setWallpaper(WallpaperManager.HOME_SCREEN);
                  Navigator.pop(context);
                },
                child: Container(
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                        child: Text(
                      "Home Screen",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
              ),
              InkWell(
                onTap: () {
                  setWallpaper(WallpaperManager.LOCK_SCREEN);
                  Navigator.pop(context);
                },
                child: Container(
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                        child: Text(
                      "Lock Screen",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
              ),
            ],
          ),
        );
      },
    );
  }
}
