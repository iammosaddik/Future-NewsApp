import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:updatenewsapp/Page%20All/Home_Page/home_page_appbar_coustom.dart';
import '../../Repository/news_repo.dart';
import '../../Widget/news_card_widget.dart';
import 'news_details_next_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController textController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: HomePageCoustomAppbar(), preferredSize: Size.fromHeight(64)),
        body: FutureBuilder(
            future: NewsRepo().getNews(),
            builder: (_,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data?.datas?.data?.length?? 0,
                    itemBuilder: (_,index){
                      return Column(
                        children: [
                          FeaturesNewsCard(imageUrl: snapshot.data?.datas?.data?[index].image?[0] ?? 'images/news.jpeg',
                              titles: snapshot.data?.datas?.data?[index].title?? '').visible(index==0),
                          NewsCard(imageUrl: snapshot.data?.datas?.data?[index].image?[0] ?? '',
                            titles: snapshot.data?.datas?.data?[index].title?? '',
                            time: snapshot.data?.datas?.data?[index].date ?? '',).visible(index!=0),
                        ],
                      ).onTap(()=>NewsDetailsNextScreen(newsId: snapshot.data!.datas!.data![index].id.toString(),).launch(context)
                      );
                    });
              }else{
                return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(width: 10,),
                        Text('Loading...', style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}


