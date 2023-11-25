package music.wuhou.wuhoumusic;

import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import music.wuhou.wuhoumusic.read.ReadActivity;

public class JumpChannel implements MethodChannel.MethodCallHandler{
    String channelName = "music.wuhou.wuhoumusic.book.read.android";

    private MethodChannel methodChannel;

    private FlutterActivity mActivity;


    public JumpChannel(BinaryMessenger binaryMessenger, FlutterActivity mActivity){
        this.methodChannel = new MethodChannel(binaryMessenger,channelName);
        this.methodChannel.setMethodCallHandler(this);
        this.mActivity = mActivity;
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

        if(call.method.equals("open")){
            Intent intent = new Intent(mActivity, ReadActivity.class);
            mActivity.startActivity(intent);
        }else {
            result.notImplemented();
        }

    }


}
