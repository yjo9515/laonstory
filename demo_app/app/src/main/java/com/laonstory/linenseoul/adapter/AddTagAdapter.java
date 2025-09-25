package com.laonstory.linenseoul.adapter;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import androidx.recyclerview.widget.RecyclerView;
import com.laonstory.linenseoul.databinding.RvAddTagBinding;
import java.util.ArrayList;

public class AddTagAdapter extends RecyclerView.Adapter<AddTagAdapter.VH> {

    private RvAddTagBinding binding;
    private ArrayList<String> arrTagList = new ArrayList<>();

    @Override
    public VH onCreateViewHolder(ViewGroup parent, int viewType) {
        binding = RvAddTagBinding.inflate(LayoutInflater.from(parent.getContext()), parent, false);
        return new VH(binding);
    }

    @Override
    public void onBindViewHolder(VH holder, int position) {
        String tag = arrTagList.get(position);
        holder.bind(tag, position);
    }

    @Override
    public int getItemCount() {
        return arrTagList.size();
    }


    public void setArrTagList(ArrayList<String> arrTagList) {
        this.arrTagList = arrTagList;
        Log.e("태그","태그어뎁터 추가");
        notifyDataSetChanged();
    }

    public class VH extends RecyclerView.ViewHolder {

        private RvAddTagBinding binding;

        public VH(RvAddTagBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(String tag, int position) {
            String num = String.valueOf(position + 1);
            binding.tvNo.setText(num);
            binding.tvTag.setText(tag);
        }
    }
}

