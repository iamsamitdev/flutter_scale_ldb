// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/text_widgets.dart';
import 'package:flutter_scale/utils/string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: HeadingText(CustomStrings.title_lastest_news),
            ),
            SizedBox(
              height: 210,
              child: FutureBuilder(
                future: CallAPI().getLastNews(),
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.hasError){
                    return Center(
                      child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                    );
                  }else if(snapshot.connectionState == ConnectionState.done){
    
                    List<NewsModel> news = snapshot.data;
    
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: news.length,
                      itemBuilder: (context, index){
    
                        NewsModel newsModel = news[index];
    
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(
                                context, 
                                '/newsdetail',
                                arguments: {'id': newsModel.id}
                              );
                            },
                            child: Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 125.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(newsModel.imageurl),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(newsModel.topic, overflow: TextOverflow.ellipsis,),
                                          Text(newsModel.detail, overflow: TextOverflow.ellipsis,)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
    
                      }
                    );
    
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: HeadingText(CustomStrings.title_all_news),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder(
                future: CallAPI().getAllNews(),
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.hasError){
                    return Center(
                      child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                    );
                  }else if(snapshot.connectionState == ConnectionState.done){
    
                    List<NewsModel> news = snapshot.data;
    
                    // หากอ่านข้อมูลเรียบร้อยแล้ว
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        
                        NewsModel newsModel = news[index];
    
                        return ListTile(
                          leading: Image.network(newsModel.imageurl),
                          title: Text(newsModel.topic, overflow: TextOverflow.ellipsis,),
                          subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis,),
                          onTap: (){
                            Navigator.pushNamed(
                              context, 
                              '/newsdetail',
                              arguments: {'id': newsModel.id}
                            );
                          },
                        );
                      }
                    );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                  
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}