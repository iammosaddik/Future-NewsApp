import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:updatenewsapp/Authentication/sign_in.dart';
import 'package:updatenewsapp/Authentication/slider_page.dart';
import '../Constant Data/app_color.dart';
import '../Page All/bottomnafigationbar.dart';
class SpelasScreen extends StatefulWidget {
  const SpelasScreen({Key? key}) : super(key: key);

  @override
  State<SpelasScreen> createState() => _SpelasScreenState();
}

class _SpelasScreenState extends State<SpelasScreen> {


  Future<void> goToSilider()async{
    final prefes = await SharedPreferences.getInstance();
    String token = prefes.getString('token')!;
    if(token.isEmptyOrNull){
     await Future.delayed(const Duration(seconds: 3)).then((value) => const SliderPage().launch(context,isNewTask: true));
    }else{
      await Future.delayed(const Duration(seconds: 3)).then((value) => const HomeBottomNavigationBar().launch(context, isNewTask: true));
    }
}

@override
  void initState() {
   goToSilider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: Center(
        child: CircleAvatar(
          radius: 100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                image: NetworkImage('https://media3.s-nbcnews.com/i/newscms/2018_21/2442281/og-nbcnews1200x630_c986de7e1bb6ad2281723b692aa61990.png'),fit: BoxFit.fill,
              ),
            ),
          )
        ),
      ),
    );
  }
}
