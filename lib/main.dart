
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'Authentication/spelas_screen.dart';


void main(){
  bool ddegbug = true;
  if(ddegbug==false){
    runApp(const MyApp());
  }else{
    runApp(DevicePreview(builder: (context)=> const MyApp(),));
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: const SpelasScreen(),
      builder: EasyLoading.init(),
    );
  }
}
