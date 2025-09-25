package com.laonstory.linenseoul.adapter;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;


import com.laonstory.data.model.Tag;
import com.laonstory.linenseoul.databinding.RvEditDeleteTagBinding;

import java.util.ArrayList;

public class EditDeleteTagAdapter extends RecyclerView.Adapter<EditDeleteTagAdapter.VH> {

    ArrayList<Tag.Data> arrTagList = new ArrayList<>();

    @NonNull
    @Override
    public VH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        RvEditDeleteTagBinding binding = RvEditDeleteTagBinding.inflate(
                LayoutInflater.from(parent.getContext()), parent, false);
        return new VH(binding);
    }

    @Override
    public void onBindViewHolder(@NonNull VH holder, int position) {
        Tag.Data tag = arrTagList.get(position);
        holder.bind(tag, position);
    }

    @Override
    public int getItemCount() {
        return arrTagList.size();
    }

    public void setTagList(ArrayList<Tag.Data> tagList) {
        this.arrTagList = tagList;
        notifyDataSetChanged(); // 데이터 변경 시 어댑터에 알림
    }

    public static class VH extends RecyclerView.ViewHolder {
        private final RvEditDeleteTagBinding binding;

        public VH(@NonNull RvEditDeleteTagBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(Tag.Data tag, int position) {
            String num = String.valueOf(position + 1);
            binding.tvNo.setText(num);
            binding.tvTag.setText(tag.getCode());
            binding.tvItemName.setText(tag.getName());
        }
    }
}
