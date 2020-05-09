import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttereyertizer/model/issue_model.dart';
import 'package:fluttereyertizer/model/video_detail_page_model.dart';
import 'package:fluttereyertizer/repository/history_repository.dart';
import 'package:fluttereyertizer/util/navigator_manager.dart';
import 'package:fluttereyertizer/widget/loading_container.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';
import 'package:fluttereyertizer/widget/videl_relate_widget_item.dart';
import 'package:video_player/video_player.dart';

/**
 * 视频播放
 */
class VideoDetailPage extends StatefulWidget {
  final Item item;

  const VideoDetailPage({Key key, this.item}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  VideoPlayerController _playerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initController();
    HistoryRepository.saveWatchHistory(widget.item);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _chewieController.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _playerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void initController() {
    List<PlayInfo> playInfoList = widget.item.data.playInfo;
    if (playInfoList.length > 1) {
      for (var playInfo in playInfoList) {
        if (playInfo.type == 'high') {
          _playerController = VideoPlayerController.network(playInfo.url);
          _chewieController = ChewieController(
              videoPlayerController: _playerController, autoPlay: true);
          break;
        }
      }
    } else {
      //若无高清视频，则取默认视频地址
      _playerController =
          VideoPlayerController.network(widget.item.data.playUrl);
      _chewieController = ChewieController(
          videoPlayerController: _playerController, autoPlay: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<VideoDetailPageModel>(
      model: VideoDetailPageModel(),
      onModelInit: (model) {
        model.loadVideoRelateData(widget.item.data.id);
      },
      builder: (context, model, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          '${widget.item.data.cover.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}'))),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: '1',
                    child: Chewie(
                      controller: _chewieController,

                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: LoadingContainer(
                        loading: model.loading,
                        child: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10,top: 10),
                                child: Text(widget.item.data.title,
                                  style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10),
                                  child: Text(
                                      '#${widget.item.data.category} / ${DateUtil.formatDateMs(widget.item.data.author.latestReleaseTime, format: 'yyyy/MM/dd HH:mm')}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      right: 10),
                                  child: Text(
                                      widget
                                          .item.data.description,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14))),
                              Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: Row(
                                  children: <Widget>[
                                    FlatButton.icon(onPressed: (){},
                                      highlightColor:Colors.transparent,
                                      disabledColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      textTheme: ButtonTextTheme.normal,

                                        icon: Image.asset(
                                          'images/ic_like.png',
                                          height: 22,
                                          width: 22,
                                        ),
                                        label: Text(
                                          '${widget.item.data.consumption.collectionCount}',
                                          style: TextStyle(
                                              color: Colors
                                                  .white,
                                              fontSize: 13),
                                        ),

                                    ),
                                    FlatButton.icon(onPressed: (){},
                                      textTheme: ButtonTextTheme.normal,
                                      highlightColor:Colors.transparent,
                                      disabledColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Image.asset(
                                        'images/ic_share_white.png',
                                        height: 22,
                                        width: 22,
                                      ),
                                      label: Text(
                                        '${widget.item.data.consumption.shareCount}',
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontSize: 13),
                                      ),

                                    ),
                                    FlatButton.icon(onPressed: (){},
                                      textTheme: ButtonTextTheme.normal,
                                      highlightColor:Colors.transparent,
                                      disabledColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Image.asset(
                                        'images/icon_comment.png',
                                        height: 22,
                                        width: 22,
                                      ),
                                      label: Text(
                                        '${widget.item.data.consumption.replyCount}',
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontSize: 13),
                                      ),

                                    )

                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                  EdgeInsets.only(top: 0),
                                  child: Divider(
                                      height: 0.5,
                                      color: Colors.white)),

                              ListTile(
                                leading: ClipOval(child: CachedNetworkImage(
                                    imageUrl: widget.item
                                        .data.author.icon,
                                    errorWidget: (context,
                                        url, error) =>
                                        Image.asset(
                                            'images/img_load_fail.png'),
                                    height: 40,
                                    width: 40),),
                                title: Text(
                                    widget.item.data
                                        .author.name,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors
                                            .white)),
                                subtitle: Text(
                                    widget
                                        .item
                                        .data
                                        .author
                                        .description,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors
                                            .white)),
                                trailing: Container(
                                  padding: EdgeInsets.fromLTRB(5,2,5,2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text('+ 关注',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.black45,
                                        fontSize: 11)),
                                ),
                              ),
                              Divider(
                                  height: 0.5,
                                  color: Colors.white),

                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context,index){
                            if (model.itemList[index].type ==
                                'videoSmallCard') {
                              return VideoRelateWidgetItem(
                                  item: model.itemList[index],
                                  callback: (){
                                    _playerController.pause();
                                    NavigatorManager.to(VideoDetailPage(
                                        item: model.itemList[index]));
                                  });
                            }
                            return Padding(padding: EdgeInsets.all(10),
                              child:Text(
                                model.itemList[index].data.text,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),);
                          },childCount: model.itemList.length),)
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
