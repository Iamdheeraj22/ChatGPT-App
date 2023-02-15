import 'dart:io';

import 'package:chat_gpt_app/provider/provider.dart';
import 'package:chat_gpt_app/util/size_config.dart';
import 'package:chat_gpt_app/with_http/text_completions/chat_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderViewModel>(
          create: (_) => ProviderViewModel(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          home: ChatScreenUI(),
          builder: (context, child) {
            SizeConfig.initialize(
                context: context,
                draftWidth: MediaQuery.of(context).size.width,
                draftHeight: MediaQuery.of(context).size.height);
            return child!;
          }),
    );
  }
}
