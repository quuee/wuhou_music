const hiveBoxes = [
  // 全局变量
  {'name': 'globalParam', 'limit': false},
  // 歌单
  {'name': 'songList', 'limit': false},
  // 缓存播放队列
  {'name': 'cache', 'limit': false},
  // 用户信息
  {'name': 'userInfo', 'limit': false},
];

class Keys {
  static final String hiveGlobalParam = 'globalParam';
  static final String sdkInt = 'sdkInt';

  static final String hiveSongList = 'songList'; // 相当于数据库或者表
  static final String localSongList = 'localSongList'; // key

  static final String hiveCache = 'cache';
  static final String lastQueue = 'lastQueue';
  static final String lastIndex = 'lastIndex';
  static final String lastPos = 'lastPos';

  static final String hiveUserInfo = 'userInfo';
  static final String token = 'token';

}
