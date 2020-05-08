import 'package:flutter/cupertino.dart';
import 'package:fluttereyertizer/provider/category_page_model.dart';
import 'package:fluttereyertizer/widget/category_widget_item.dart';
import 'package:fluttereyertizer/widget/loading_container.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<CategoryPageModel>(
      model: CategoryPageModel(),
      onModelInit: (model){
        model.loadData();
      },
      builder: (context,model,child){

        return LoadingContainer(
          loading: model.loading,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Color(0xfff2f2f2)),
            child: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5
            ) ,
                itemBuilder: (context,index){
              return CategoryWidgetItem(categoryModel: model.list[index],);
                },
            itemCount: model.list.length,),

          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}