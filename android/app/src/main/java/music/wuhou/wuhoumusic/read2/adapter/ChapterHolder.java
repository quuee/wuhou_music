package music.wuhou.wuhoumusic.read2.adapter;

import android.graphics.drawable.Drawable;
import android.widget.TextView;

import androidx.core.content.ContextCompat;

import music.wuhou.wuhoumusic.R;
import music.wuhou.wuhoumusic.read2.page.TextChapter;

public class ChapterHolder extends ViewHolderImpl<TextChapter>{

    private TextView mTvChapter;

    @Override
    public void initView() {
        mTvChapter = findById(R.id.category_tv_chapter);
    }

    @Override
    public void onBind(TextChapter value, int pos){

        Drawable drawable = ContextCompat.getDrawable(getContext(),R.drawable.selector_category_load);

        mTvChapter.setSelected(false);
        mTvChapter.setTextColor(ContextCompat.getColor(getContext(),R.color.nb_text_default));
        mTvChapter.setCompoundDrawablesWithIntrinsicBounds(drawable,null,null,null);
        mTvChapter.setText(value.getChapterTitle());
    }

    @Override
    protected int getItemLayoutId() {
        return R.layout.item_chapter;
    }

    public void setSelectedChapter(){
        mTvChapter.setTextColor(ContextCompat.getColor(getContext(),R.color.light_red));
        mTvChapter.setSelected(true);
    }
}
