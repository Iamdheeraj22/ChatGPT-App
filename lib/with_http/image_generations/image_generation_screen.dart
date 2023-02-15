import 'package:chat_gpt_app/provider/provider.dart';
import 'package:chat_gpt_app/util/size_config.dart';
import 'package:chat_gpt_app/with_http/image_generations/image_generation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageGenerationsScreen extends StatefulWidget {
  ImageGenerationsScreen({Key? key}) : super(key: key);

  @override
  State<ImageGenerationsScreen> createState() => _ImageGenerationsScreenState();
}

class _ImageGenerationsScreenState extends State<ImageGenerationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderViewModel>(builder: (context, v, child) {
      return Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              ListView.builder(
                  itemCount: v.imageGenerationsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ImageGenerationWidget(
                        model: v.imageGenerationsList[index],
                      )),
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Card(
                          child: TextFormField(
                        controller: v.imageTextController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 20.w),
                            hintText: 'Write a text'),
                      )),
                    ),
                    Visibility(
                      visible: v.getIsShow,
                      child: InkWell(
                        onTap: () async {
                          v.generateImages(context);
                        },
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 10.h),
                              child: Icon(Icons.send)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
