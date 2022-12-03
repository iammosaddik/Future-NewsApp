import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:updatenewsapp/Model/Category%20Model/Category_news_model.dart';
import 'package:updatenewsapp/Repository/category_repo.dart';

import '../../Constant Data/app_color.dart';
import 'category_details_page.dart';
import 'category_page_coustom_appbar.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  TextEditingController textController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CategoryAppbar(), preferredSize: Size.fromHeight(64)),
        body: SingleChildScrollView(
          child: FutureBuilder<CategoryNewsModel>(
            future: CategoryRepo().getcategory(),
              builder: (_,snapshot){
            if(snapshot.hasData){
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0
                  ),
                  itemCount: snapshot.data?.datas?.data?.length ?? 0,
                  itemBuilder: (_,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: (()=> CategoryDetailsPage(newsId: snapshot.data!.datas!.data![index].id.toString(),).launch(context)),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  gradient: ThemeColor().gradientColor(),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage(snapshot.data?.datas?.data?[index].image?? ''),fit: BoxFit.fill),
                              ),
                            ),
                             Positioned(
                                bottom: 10,
                                right: 10,
                                child: Text(snapshot.data?.datas?.data?[index].name.toString() ?? '', style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),))
                          ],
                        ),
                      ),
                    );
                  });
            }
            else{
              return  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 10,),
                  Text('Loading...', style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),)
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
