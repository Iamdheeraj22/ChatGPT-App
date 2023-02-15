import 'package:chat_gpt_app/util/size_config.dart';
import 'package:flutter/material.dart';

class MessageUI extends StatelessWidget {
  String text;
  int type;
  MessageUI({
    Key? key,
    required this.text,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
      child: Row(
        children: [
          Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
                color: type == 1 ? Colors.redAccent : Colors.greenAccent,
                borderRadius: BorderRadius.circular(200.h)),
            child: Center(
              child: Text(
                type == 1 ? 'U' : 'B',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 24.sp,
                    color: type == 1 ? Colors.white : Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(
              text.trim().replaceAll("\n", " "),
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}
