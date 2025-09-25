package com.laonstory.linenseoul.adapter;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;


import com.laonstory.data.model.Tag;
import com.laonstory.linenseoul.databinding.RvCheckTagBinding;

import java.util.ArrayList;


public class CheckTagAdapter extends RecyclerView.Adapter<CheckTagAdapter.VH> {
    ArrayList<Tag.Data> arrTagList = new ArrayList<>();

    @NonNull
    @Override
    public VH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        RvCheckTagBinding binding = RvCheckTagBinding.inflate(LayoutInflater.from(parent.getContext()), parent, false);
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
        notifyDataSetChanged();
    }

    class VH extends RecyclerView.ViewHolder {
        private final RvCheckTagBinding binding;

        VH(RvCheckTagBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        void bind(Tag.Data tag, int position) {
            String num = String.valueOf(position + 1);
            binding.tvNo.setText(num);
            binding.tvTag.setText(tag.getCode());
            binding.tvMember.setText(tag.getFranchiseName());
            binding.tvItemName.setText(tag.getName());
            binding.tvDate.setText(tag.getCreatedDate());
            // binding.tvDate.setText(CustomFormat.toDate(tag.getCreatedDate()));
        }
    }

}
