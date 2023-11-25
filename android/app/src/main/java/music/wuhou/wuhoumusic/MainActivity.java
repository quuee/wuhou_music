package music.wuhou.wuhoumusic;


import androidx.annotation.NonNull;

import com.ryanheise.audioservice.AudioServiceActivity;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * https://pub.dev/packages/audio_service
 * 自定义自己的活动： 1、继承AudioServiceActivity 2、AudioServiceFragmentActivity
 */
public class MainActivity extends AudioServiceActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new JumpChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),this);

    }

}
