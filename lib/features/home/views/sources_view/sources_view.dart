import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/apis/api_service.dart';
import 'package:news/apis/articlesResponse/Article.dart';
import 'package:news/apis/sources_response/Source.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/features/home/views/sources_view/article_item.dart';
import 'package:news/features/home/views/sources_view/articles_viewModel.dart';
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart';
import 'package:news/models/category_model.dart';
import 'package:provider/provider.dart';

class SourcesView extends StatefulWidget {
  SourcesView({super.key, required this.category});

  CategoryModel category;

  @override
  State<SourcesView> createState() => _SourcesViewState();
}

class _SourcesViewState extends State<SourcesView> {
  late SourcesViewModel sourcesViewModel;
  late ArticlesViewModel articlesViewModel;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  void fetchData()async{
  sourcesViewModel =  SourcesViewModel();
  articlesViewModel = ArticlesViewModel();
  await  sourcesViewModel.loadSources(widget.category);
  articlesViewModel.loadArticles(sourcesViewModel.sources[0]);
  }




  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>sourcesViewModel),
        ChangeNotifierProvider(create: (context)=> articlesViewModel),
      ],
      child: Column(
        children: [
          Consumer<SourcesViewModel>(builder: (context,viewModel, _ ){
         
            if(viewModel.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }
            if(viewModel.errorMessage.isNotEmpty){
              return Center(child: Text(viewModel.errorMessage),);
            }
            List<Source> sources = sourcesViewModel.sources;
            return DefaultTabController(
                        length: sources.length,
                        child: TabBar(
                          onTap: (index){
                            articlesViewModel.loadArticles(viewModel.sources[index]);
                          },
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent,
                          indicatorColor: ColorsManager.white,
                          isScrollable: true,
                          labelStyle: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                          unselectedLabelStyle: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white,
                          ),
                          tabs: sources.map((source) => Tab(text: source.name)).toList(),
                        ),


                    );
          }),
          Expanded(
            child: Consumer<ArticlesViewModel>(builder: (_,viewModel, _ ){
              print("Ana da5ale el articles Builder");
              if(viewModel.isLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              if(viewModel.errorMessage.isNotEmpty){
                return Center(child: Text(viewModel.errorMessage),);
              }
              List<Article> articles = viewModel.articles;
              return ListView.separated(
                  itemBuilder: (context, index)=> ArticleItem(article: articles[index]),
                  separatorBuilder: (context, index)=> SizedBox(height: 16.h,), itemCount: articles.length);
            
            }),
          )

        ],
      ),
    );
  }
}
