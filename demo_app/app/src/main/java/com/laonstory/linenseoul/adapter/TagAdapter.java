package com.laonstory.linenseoul.adapter;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.laonstory.linenseoul.databinding.RvLaundryBinding;
import com.laonstory.data.model.RVTag;

import java.util.ArrayList;

public class TagAdapter extends RecyclerView.Adapter<TagAdapter.VH> {

    private RvLaundryBinding binding;
    private ArrayList<RVTag> arrTagList = new ArrayList<>();

    @NonNull
    @Override
    public VH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        binding = RvLaundryBinding.inflate(LayoutInflater.from(parent.getContext()), parent, false);
        return new VH(binding);
    }

    @Override
    public int getItemCount() {
        return arrTagList.size();
    }

    @Override
    public void onBindViewHolder(@NonNull VH holder, int position) {
        RVTag tag = arrTagList.get(position);
        holder.bind(tag, position);
    }

    public class VH extends RecyclerView.ViewHolder {
        private RvLaundryBinding binding;

        public VH(RvLaundryBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(RVTag tag, int position) {
            String num = String.valueOf(position + 1);
            binding.tvNo.setText(num);
            binding.tvItemName.setText(tag.getName());
            binding.tvCount.setText(String.valueOf(tag.getCount()));
        }
    }

    public void setArrTagList(ArrayList<RVTag> arrTagList) {
        this.arrTagList = arrTagList;
        notifyDataSetChanged();
    }
}
