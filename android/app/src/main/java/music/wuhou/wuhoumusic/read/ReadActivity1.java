package music.wuhou.wuhoumusic.read;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;

import music.wuhou.wuhoumusic.R;

public class ReadActivity1 extends AppCompatActivity {

    ReadView readView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity1_read);
        readView = findViewById(R.id.read_view);
        Intent intent = getIntent();
        String localPath = intent.getStringExtra("localPath");
        try {
//            InputStream is = getResources().openRawResource(R.raw.santi);
            assert localPath != null;
            File f = new File(localPath);
            InputStream is = new FileInputStream(f);
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


    /**
     * 随机流（RandomAccessFile）不属于IO流，支持对文件的读取和写入随机访问。\n
     *
     * 先把随机访问的文件对象看作存储在文件系统中的一个大型 byte 数组，
     * 然后通过指向该 byte 数组的光标或索引（即：文件指针 FilePointer）在该数组任意位置读取或写入任意数据。
     *
     * 1、对象声明：RandomAccessFile raf = newRandomAccessFile(File file, String mode); 其中参数 mode 的值可选 "r"：可读，"w" ：可写，"rw"：可读性；
     * 2、获取当前文件指针位置：int RandowAccessFile.getFilePointer();
     * 3、改变文件指针位置（相对位置、绝对位置）：
     *   1> 绝对位置：RandowAccessFile.seek(int index);
     *   2> 相对位置：RandowAccessFile.skipByte(int step); 相对当前位置
     * 4、给写入文件预留空间：RandowAccessFile.setLength(long len);
     */

//    public void readStr() throws IOException {
//        RandomAccessFile file = new RandomAccessFile(this.getFilesDir()+ "test.xkr","rw");
//        StrModel strModel = new StrModel();
//        strModel = eBookInit(strModel);
//        strModel.write(file);
//
//        file.seek(0);
//        StrModel strModel1 = new StrModel();
//        strModel1.read(file);
//        String ebook = "";
//        for (int i=0;i<strModel1.getListContent().size();i++){
//            ebook = ebook + "第" + strModel1.getListContent().get(i).getChapterNum() + "节"
//                    + "： " + strModel1.getListContent().get(i).getChapterName() + "\n"
//                    + getChapterStr(file,strModel1,i) +"\n";
//        }
//        //readView.setText(ebook);
//    }

//    public StrModel eBookInit(StrModel strModel){
//        long strIndex = 0;
//        strModel.setReadIndex(0);
//        ListModel listModel1 = new ListModel("作用",1,false,strIndex,chapter1.getBytes().length);
//        strIndex += chapter1.getBytes().length;
//        ListModel listModel2 = new ListModel("随机访问文件原理",2,false,strIndex,chapter2.getBytes().length);
//        strIndex += chapter2.getBytes().length;
//        ListModel listModel3 = new ListModel("相关方法说明",3,false,strIndex,chapter3.getBytes().length);
//        List<ListModel> listModels = new ArrayList<>();
//        listModels.add(listModel1);
//        listModels.add(listModel2);
//        listModels.add(listModel3);
//        strModel.setListNum(listModels.size());
//        strModel.setListContent(listModels);
//        strModel.setListSize(listModels.size());
//        strModel.setStrContent(chapter1+chapter2+chapter3);
//        return strModel;
//    }

//    public String getChapterStr (RandomAccessFile file,StrModel strModel,int i) throws IOException {
//        file.seek(strModel.getStartIndex()+strModel.getListContent().get(i).getChapterIndex());
//        byte[] buff = new byte[1024];
//        file.read(buff,0,(int)strModel.getListContent().get(i).getChapterSize());
//        return new  String(buff);
//    }
}
