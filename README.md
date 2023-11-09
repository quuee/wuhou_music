
## 歌单目前以本地为主
同步歌单必须联网。数据库唯一标识两端必须统一。之后再做两端歌单统一。

## app端 待完成
- [x] 本地歌单
- [x] 展示歌曲封面  audio_service示例中的方法不太行，试试on_audio_query  (插件和示例方法都不行，估计歌曲都不带元信息，所以查不到，只能网络下载了)
- [x] 创建歌单时 选择图片 如何回显图片(在dialog中)  
- [x] 侧滑删除 将歌曲从歌单删除  
- [x] 歌单列表 不存在的歌曲 灰色显示(目前播放还是会加入播放列表，但是不存在会跳过)  
- [x] 歌单列表 没有点击样式了
- [x] 多选歌曲 添加到歌单
- [x] 歌词(读取已存在本地歌词)
- [x] 本地音乐 增加tab 单曲 歌手 文件夹  
- [x] 主题切换
- [x] 添加歌曲页面 已存在歌单的歌曲灰色显示，不能勾选
- [x] 添加歌曲页面 搜素当前本地歌曲
- [ ] just_audio 播放错误处理
- [ ] 均衡器  
- [ ] 本地不存在 在线播放
- [ ] 网络搜索 可搜歌名歌词歌手相关视频
- [ ] 歌曲分类 语种 粤语日语 国风 
- [ ] 本地 云端 歌单同步统一标识 
- [x] 账户密码登录
- [x] token过期重新登录

## 服务端
- [ ] 歌曲 歌词 封面 下载
- [ ] 歌曲文件 上传 云存储
- [ ] 视频
- [ ] 歌单同步到服务端
- [ ] 微信qq其他登录
- [ ] 个人存储空间  
- [ ] 支持用户自己搭建云盘等存储空间 
- [ ] minio 搭建，自定义访问策略  
- [ ] meiliSearch 

## hive BUG2
只要box更新或删除 一个值，其他地方取值就为空。debug时，是有值put进去，但是取为空。关闭应用重新查询又有修改后的值。  


## BUG
每次点击不同的歌单，后台会在通知栏创建很多个播放通知界面  
写一个工厂方法类 解决。
```dart
//原先没有工厂类 多个歌单切歌就会创建多个通知栏，难道init方法在插件中调用多次。但是插件中代码onMethodCall在收到configure才初始化
//或者时因为每次从GetIt取audioHandler，都在重新初始化audioHandler
final audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: AudioServiceConfig(
    androidNotificationChannelId: 'wuhou.music.channel.audio',
    androidNotificationChannelName: 'wuhou music',
    // androidNotificationIcon: 'drawable/ic_stat_music_note',
    androidShowNotificationBadge: true,
    androidStopForegroundOnPause: false,
  ),
);
GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
static final AudioPlayerHandler audioPlayerHandler = GetIt.I<AudioPlayerHandler>();

// 查看get_it文档，并不是传实例进去。
GetIt.instance.registerSingleton<AppModel>(AppModelImplementation());
GetIt.I.registerLazySingleton<RESTAPI>(() => RestAPIImplementation());

//应该注册完之后 测试是否是单例
```

## flutter中 key GlobalKey

## getx 
状态管理 路由
### controller
controller onStart (内部调用，不可覆盖)之后调用oninit
controller onInit 和界面无关，初始化成员属性  
StatefulWidget initState  
StatefulWidget build  
controller onReady 界面加载完成了，可以操作界面相关 处理异步事件 网络请求  
controller onClose （页面退出前）关闭流对象、动画、释放内存、数据持久化 （如果页面销毁了controller还在就不会走oninit onready，但是widget还是会走build）  
controller deleted (内部调用，不可覆盖)  

## 下拉上拉库 
pull_to_refresh_flutter3 子组件有图片刷新就会ui变形，而且不维护了  
easy_refresh 完美

## android 查询媒体文件 类ContentResolver
MediaStore.Audio.Media.EXTERNAL_CONTENT_URI：存储在手机外部存储器上的音频文件Uri路径。  
MediaStore.Audio.Media.INTERNAL_CONTENT_URI：存储在手机内部存储器上的音频文件Uri路径。  
MediaStore.Images.Media.EXTERNAL_CONTENT_URI：存储在手机外部存储器上的图片文件Uri路径。  
MediaStore.Images.Media.INTERNAL_CONTENT_URI：存储在手机内部存储器上的图片文件Uri路径。  
MediaStore.Video.Media.EXTERNAL_CONTENT_URI：存储在手机外部存储器上的视频文件Uri路径。  
MediaStore.Video.Media.INTERNAL_CONTENT_URI：存储在手机内部存储器上的视频文件Uri路径。

Image(图片)	content://media/external/images/media	MediaStore.Images.Media.EXTERNAL_CONTENT_URI	Pictures	DCIM、Pictures  
Audio(音频)	content://media/external/audio/media	MediaStore.Audio.Media.EXTERNAL_CONTENT_URI	Music	Alarms、Music、Notifications、Podcasts、Ringtones  
Video(视频)	content://media/external/video/media	MediaStore.Video.Media.EXTERNAL_CONTENT_URI	Movies	DCIM 、Movies  
Download(下载文件)	content://media/external/downloads	MediaStore.Downloads.EXTERNAL_CONTENT_URI	Download	Download

查询方法：query  
Uri：这个Uri代表要查询的内容提供者的Uri。上文说到多媒体类型的Uri一般都直接从MediaStore里取得，例如我要取所有图片的信息，就必须利用MediaStore.Images.Media.EXTERNAL_CONTENT_URI这个Uri。  
projection： 代表告诉Provider要返回的字段内容（列Column），用一个String数组来表示。用null表示返回Provider的所有字段内容（列Column）。  
selection：相当于SQL语句中的where子句，就是代表查询条件。null表示不进行添加筛选查询。  
selectArgs：如果selection里有？这个符号时，这里可以以实际值代替这个问号。如果Selections这个没有？的话，那么这个String数组可以为null。  
sortOrder：说明查询结果按什么来排序。相当于SQL语句中的Order by，升序 asc /降序 desc，null为默认排序
![示例](./document/contentResolver.query.png)

类型：MimeType  
Image(图片)	content://media/external/images/media	MediaStore.Images.Media.EXTERNAL_CONTENT_URI	image/*	Pictures	DCIM、Pictures  
Audio(音频)	content://media/external/audio/media	MediaStore.Audio.Media.EXTERNAL_CONTENT_URI	audio/*	Music	Alarms、Music、Notifications、Podcasts、Ringtones  
Video(视频)	content://media/external/video/media	MediaStore.Video.Media.EXTERNAL_CONTENT_URI	video/*	Movies	DCIM 、Movies  
Files(下载)	content://media/external/downloads	MediaStore.Downloads.EXTERNAL_CONTENT_URI	file/*	Download	Download

音频文件比较常见的列名有:  
MediaStore.Audio.Media.TITLE：歌名  
MediaStore.Audio.Media.ARTIST：歌手  
MediaStore.Audio.Media.DURATION：总时长  
MediaStore.Audio.Media.DATA：地址  
MediaStore.Audio.Media.SIZE：大小

音频文件所有字段：
_id//主键id
_data//路径
_size//大小
format
parent
date_added//添加日期
date_modified//修改日期
mime_type//文件类型
title
description
_display_name
picasa_id
orientation
latitude
longitude
datetaken
mini_thumb_magic
bucket_id
bucket_display_name
isprivate
title_key
artist_id
album_id
composer
track
year
is_ringtone
is_music
is_alarm
is_notification
is_podcast
album_artist
duration
bookmark
artist
album
resolution
tags
category
language
mini_thumb_data
name
media_type
old_id
is_drm
width
height
title_resource_uri


视频文件比较常见的列名有:  
MediaStore.Video.Media.TITLE 名称  
MediaStore.Video.Media.DURATION 总时长  
MediaStore.Video.Media.DATA 地址  
MediaStore.Video.Media.SIZE 大小  
MediaStore.Video.Media.WIDTH：视频的宽度，以像素为单位。  
MediaStore.Video.Media.HEIGHT：视频的高度，以像素为单位

图片文件比较常见的列名有:  
MediaStore.Images.Media._ID：磁盘上文件的路径  
MediaStore.Images.Media.DATA：磁盘上文件的路径  
MediaStore.Images.Media.DATE_ADDED：文件添加到media provider的时间（单位秒）  
MediaStore.Images.Media.DATE_MODIFIED：文件最后一次修改单元的时间  
MediaStore.Images.Media.DISPLAY_NAME：文件的显示名称  
MediaStore.Images.Media.HEIGHT：图像/视频的高度，以像素为单位  
MediaStore.Images.Media.MIME_TYPE：文件的MIME类型  
MediaStore.Images.Media.SIZE：文件的字节大小  
MediaStore.Images.Media.TITLE：标题  
MediaStore.Images.Media.WIDTH：图像/视频的宽度，以像素为单位。 

