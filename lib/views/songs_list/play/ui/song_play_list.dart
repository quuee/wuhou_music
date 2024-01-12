import 'package:flutter/material.dart';
import 'package:wuhoumusic/utils/audio_service/common.dart';

class SongPlayListPage extends StatelessWidget {
  const SongPlayListPage({super.key,required this.audioHandler});

  final WHAudioPlayerHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<QueueState>(
        stream: audioHandler.queueState,
        builder: (context, snapshot) {
          final queueState = snapshot.data ?? QueueState.empty;
          final queue = queueState.queue;
          return ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) newIndex--;
              // audioHandler.moveQueueItem(oldIndex, newIndex);
            },
            children: [
              for (var i = 0; i < queue.length; i++)
                Dismissible(
                  key: ValueKey(queue[i].id),
                  direction: DismissDirection.endToStart,
                  dismissThresholds: const {
                    DismissDirection.endToStart:
                    0.5 //左滑时，在超过 50% 的位置松开手则会触发 onDismissed（快速惯性滑动时此值无效）
                  },
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  onDismissed: (dismissDirection) {
                    audioHandler.removeQueueItemAt(i);
                  },
                  child: Material(
                    color: i == queueState.queueIndex
                        ? Colors.grey.shade300
                        : null,
                    child: ListTile(
                      title: Text(queue[i].title),
                      onTap: () => audioHandler.skipToQueueItem(i),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}


