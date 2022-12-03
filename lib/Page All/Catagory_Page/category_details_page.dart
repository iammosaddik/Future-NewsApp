
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:updatenewsapp/Repository/category_repo.dart';

import '../../Widget/category_card_widget.dart';
import '../Home_Page/news_details_next_screen.dart';
import 'category_details_coustom_appbar.dart';


class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({Key? key, required this.newsId}) : super(key: key);

  final String newsId;

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {

  TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(child: DetailsAppbar(), preferredSize: Size.fromHeight(64)),
          body: FutureBuilder(
          future: CategoryRepo().getcategoryDetails(widget.newsId),
            builder: (_,snapshot){
          if(snapshot.hasData){
            return  ListView.builder(
                itemCount: snapshot.data?.datas?.data?.length ?? 0,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      CategoryFutureDetails(imageUrl: snapshot.data?.datas?.data?[index].image?[0] ?? '',
                          titles: snapshot.data?.datas?.data?[index].title ?? '').visible(index==0),
                      CategoryFututreCard2(titles:snapshot.data?.datas?.data?[index].title ?? '',
                        imageUrl: snapshot.data?.datas?.data?[index].image?[0] ?? '',
                        times: snapshot.data?.datas?.data?[index].date ?? '',).visible(index!=0)
                    ],
                  ).onTap(()=> NewsDetailsNextScreen(newsId: snapshot.data!.datas!.data![index].id.toString()).launch(context));
                }
                );
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
        })
      ),
    );
  }
}


