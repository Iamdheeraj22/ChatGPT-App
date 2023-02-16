import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_app/util/size_config.dart';
import 'package:flutter/material.dart';

class FullImageScreen extends StatefulWidget {
  FullImageScreen({Key? key, required this.imageUrl}) : super(key: key);
  String imageUrl;
  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 60.h),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                        Colors.red, BlendMode.colorBurn)),
              ),
            ),
            placeholder: (context, url) => Center(
                child: SizedBox(
                    height: 50.h,
                    width: 50.h,
                    child: const CircularProgressIndicator())),
            errorWidget: (context, url, error) => Text(error),
          ),
        ),
      ),
    );
  }
}
