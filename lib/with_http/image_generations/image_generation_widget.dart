import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_app/model/images_generation_model/ImageTextModel.dart';
import 'package:chat_gpt_app/model/images_generation_model/image_generation_model.dart';
import 'package:chat_gpt_app/util/size_config.dart';
import 'package:chat_gpt_app/with_http/image_generations/full_image_screen.dart';
import 'package:flutter/material.dart';

class ImageGenerationWidget extends StatelessWidget {
  ImageGenerationWidget({Key? key, required this.model}) : super(key: key);
  ImageTextModel model;
  @override
  Widget build(BuildContext context) {
    return model.type == 1
        ? TextItemWidget(promptText: model.promptText.toString())
        : ImageItemWidget(imageData: model.imageData!);
  }
}

class TextItemWidget extends StatelessWidget {
  TextItemWidget({Key? key, required this.promptText}) : super(key: key);
  String promptText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
      child: Row(
        children: [
          Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(200.h)),
            child: Center(
              child: Text(
                'U',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 24.sp,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(
              promptText.trim().replaceAll("\n", " "),
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageItemWidget extends StatelessWidget {
  ImageItemWidget({super.key, required this.imageData});
  List<ImageData> imageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(200.h)),
            child: Center(
              child: Text(
                'B',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 24.sp,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: imageData.length,
                itemBuilder: (gContext, gIndex) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => FullImageScreen(
                              imageUrl: imageData[gIndex].url!)));
                    },
                    child: CachedNetworkImage(
                      imageUrl: imageData[gIndex].url!,
                      imageBuilder: (context, imageProvider) => Container(
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
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
                  );
                }),
          )
        ],
      ),
    );
  }
}
