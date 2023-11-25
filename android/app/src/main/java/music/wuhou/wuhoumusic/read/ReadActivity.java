package music.wuhou.wuhoumusic.read;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import music.wuhou.wuhoumusic.R;

public class ReadActivity extends AppCompatActivity {

    ReadView readView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_read);
        readView = findViewById(R.id.read_view);

        try {
            InputStream is = getResources().openRawResource(R.raw.santi);
            String text = readTextFromSDcard(is);
            readView.setText(text);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        readView.setOnItemSelectListener(index -> {
            if (index==0){
                readView.PageDn();
            }else {
                readView.PageUp();
            }
        });
    }

    private String readTextFromSDcard(InputStream is) throws Exception {
        InputStreamReader reader = new InputStreamReader(is);
        BufferedReader bufferedReader = new BufferedReader(reader);
        StringBuilder buffer = new StringBuilder();
        String str;
        while ((str = bufferedReader.readLine()) != null) {
            buffer.append(str);
            buffer.append("\n");
        }
        return buffer.toString();
    }
}
