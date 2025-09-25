package com.laonstory.linenseoul.adapter;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;


import com.laonstory.data.model.Tag;
import com.laonstory.linenseoul.databinding.RvUserTagBinding;

import java.util.ArrayList;

public class UserTagAdapter extends RecyclerView.Adapter<UserTagAdapter.VH>{
    private RvUserTagBinding binding;
    ArrayList<Tag.Data> arrTagList = new ArrayList<>();

    @Override
    public VH onCreateViewHolder(ViewGroup parent, int viewType) {
        binding = RvUserTagBinding.inflate(LayoutInflater.from(parent.getContext()), parent, false);
        return new VH(binding);
    }

    @Override
    public int getItemCount() {
        return arrTagList.size();
    }

    @Override
    public void onBindViewHolder(VH holder, int position) {
        Tag.Data tag = arrTagList.get(position);
        holder.bind(tag, position);
    }

    public class VH extends RecyclerView.ViewHolder {
        private RvUserTagBinding binding;

        public VH(RvUserTagBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(Tag.Data tag, int position) {
            String num = String.valueOf(position + 1);
            binding.tvTag.setText(tag.getCode());
            binding.tvFranchise.setText(tag.getFranchiseName());
            binding.tvItemName.setText(tag.getName());
            binding.tvCreateDate.setText(tag.getCreatedDate());
        }
    }
}
