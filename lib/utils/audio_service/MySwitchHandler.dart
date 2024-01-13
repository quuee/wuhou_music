import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

import 'common.dart';

class MySwitchHandler extends SwitchAudioHandler
    implements WHAudioPlayerHandler {
  final List<AudioHandler> handlers;
  @override
  BehaviorSubject<dynamic> customState =
      BehaviorSubject<dynamic>.seeded(CustomEvent(0));

  MySwitchHandler(this.handlers) : super(handlers.first) {
    // Configure the app's audio category and attributes for speech.
    AudioSession.instance.then((session) {
      session.configure(const AudioSessionConfiguration.speech());
    });
  }

  @override
  Future<dynamic> customAction(String name,
      [Map<String, dynamic>? extras]) async {
    switch (name) {
      case 'switchToHandler':
        stop();
        final index = extras!['index'] as int;
        inner = handlers[index];
        customState.add(CustomEvent(index));
        return null;
      default:
        return super.customAction(name, extras);
    }
  }

  @override
  Stream<QueueState> get queueState =>
      Rx.combineLatest2<List<MediaItem>, PlaybackState, QueueState>(
          queue,
          playbackState,
          (queue, playbackState) => QueueState(
                queue,
                playbackState.queueIndex,
                playbackState.shuffleMode == AudioServiceShuffleMode.all
                    ? List.generate(queue.length, (i) => i)
                    : null,
                playbackState.repeatMode,
              )).where((state) => state.shuffleIndices == null || state.queue.length == state.shuffleIndices!.length);

  @override
  Future<void> setSpeed(double speed) async {
    this.speed.add(speed);
    await inner.setSpeed(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    this.volume.add(volume);
    // await inner.setVolume(volume);
  }

  @override
  final BehaviorSubject<double> volume = BehaviorSubject.seeded(1.0);
  @override
  final BehaviorSubject<double> speed = BehaviorSubject.seeded(1.0);
}
