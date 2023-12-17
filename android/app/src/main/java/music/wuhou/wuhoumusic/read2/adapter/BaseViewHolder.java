package music.wuhou.wuhoumusic.read2.adapter;

import android.view.View;

import androidx.recyclerview.widget.RecyclerView;


public class BaseViewHolder<T> extends RecyclerView.ViewHolder{

    public IViewHolder<T> holder;

    public BaseViewHolder(View itemView, IViewHolder<T> holder) {
        super(itemView);
        this.holder = holder;
        holder.initView();
    }
}
