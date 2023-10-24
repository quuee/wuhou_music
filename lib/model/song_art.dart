import 'dart:io';
import 'dart:typed_data';

import 'package:android_content_provider/android_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';


class SongArt extends StatefulWidget {
  const SongArt({Key? key, required this.song}) : super(key: key);

  final SongEntity song;

  @override
  State<SongArt> createState() => _SongArtState();
}

class _SongArtState extends State<SongArt> {
  CancellationSignal? _loadSignal;
  Uint8List? _bytes;
  bool loaded = false;

  static const int _artSize = 60;

  late int sdkInt;

  @override
  void initState() {
    super.initState();
    var box = Hive.box(Keys.hiveGlobalParam);
    sdkInt = int.parse(box.get(Keys.sdkInt));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchArt();
  }

  @override
  void didUpdateWidget(covariant SongArt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.song.id != oldWidget.song.id) {
      _fetchArt();
    }
  }

  int getCacheSize() {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return (_artSize * devicePixelRatio).toInt();
  }

  Future<void> _fetchArt() async {
    if (!(sdkInt >= 29)) {
      return;
    }
    _loadSignal?.cancel();
    _loadSignal = CancellationSignal();
    final cacheSize = getCacheSize();
    try {
      _bytes = await AndroidContentResolver.instance.loadThumbnail(
        uri: widget.song.uri,
        width: cacheSize,
        height: cacheSize,
        cancellationSignal: _loadSignal,
      );
    } catch (e) {
      _bytes = null;
    }
    if (mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  void dispose() {
    _loadSignal?.cancel();
    super.dispose();
  }

  Widget _buildPlaceholder() => Container(
        color: Colors.blue,
        child: const Icon(
          Icons.music_note,
          color: Colors.white,
          size: _artSize / 1.5,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (!(sdkInt >= 29)) {
      final cacheSize = getCacheSize();
      child = !loaded
          ? SizedBox.square(dimension: _artSize.toDouble())
          : _bytes == null
              ? _buildPlaceholder()
              : Image.memory(
                  _bytes!,
                  cacheHeight: cacheSize,
                  cacheWidth: cacheSize,
                );
    } else {
      Map<int,String> albumArtPaths = GetIt.I.get<Map<int,String>>();
      final artPath = albumArtPaths[widget.song.albumId];
      // final artPath = widget.song.artPath;
      var file = artPath == null ? null : File(artPath);
      if (artPath == null || !file!.existsSync()) {
        child = _buildPlaceholder();
      } else {
        final cacheSize = getCacheSize();
        child = Image.file(
          file,
          cacheHeight: cacheSize,
          cacheWidth: cacheSize,
        );
      }
    }
    return SizedBox.square(
      dimension: _artSize.toDouble(),
      child: child,
    );
  }
}
