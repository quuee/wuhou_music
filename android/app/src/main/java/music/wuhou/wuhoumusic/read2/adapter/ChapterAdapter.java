package music.wuhou.wuhoumusic.read2.adapter;

import android.view.View;
import android.view.ViewGroup;

import music.wuhou.wuhoumusic.read2.page.TextChapter;

public class ChapterAdapter extends EasyAdapter<TextChapter>{

    private int currentSelected = 0;
    @Override
    protected IViewHolder<TextChapter> onCreateViewHolder(int viewType) {
        return new ChapterHolder();
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View view = super.getView(position, convertView, parent);
        ChapterHolder holder = (ChapterHolder) view.getTag();

        if (position == currentSelected){
            holder.setSelectedChapter();
        }

        return view;
    }

    public void setChapter(int pos){
        currentSelected = pos;
        notifyDataSetChanged();
    }
}
