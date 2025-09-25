package com.laonstory.linenseoul.presentation.fragment;

import static com.laonstory.linenseoul.util.Co.hideKeyboard;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.widget.ArrayAdapter;

import androidx.annotation.Nullable;
import androidx.core.content.res.ResourcesCompat;
import androidx.lifecycle.Observer;

import com.laonstory.data.model.Tag;
import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.adapter.CheckTagAdapter;
import com.laonstory.linenseoul.databinding.FragmentCheckBinding;
import com.laonstory.linenseoul.presentation.check.CheckContract;
import com.laonstory.linenseoul.presentation.check.CheckPresenter;
import com.laonstory.linenseoul.util.CustomDialog;

import java.util.ArrayList;


public class CheckFragment extends TagFragment<FragmentCheckBinding, CheckPresenter> implements CheckContract.View {

    private CheckTagAdapter checkTagAdapter = new CheckTagAdapter();

    private CheckPresenter checkPresenter =  new CheckPresenter();


    @Override
    public void setViews() {
        try{
            binding.setVm(checkPresenter);
            binding.setLifecycleOwner(this);
            Log.v("시작","처음");
            binding.acFranchise.addTextChangedListener(acTextChangedListener);
            binding.acFranchise.setOnEditorActionListener((v, actionId, event) -> {
                if (actionId == EditorInfo.IME_ACTION_DONE) {
                    hideKeyboard(v);
                }
                return false;
            });
            binding.acFranchise.setDropDownBackgroundDrawable(ResourcesCompat.getDrawable(
                    getResources(),
                    R.drawable.rounded_side_stoke_gray,
                    null
            ));

            binding.rv.setAdapter(checkTagAdapter);
            binding.rv.setItemAnimator(null);

            binding.tvReset.setOnClickListener(v -> {
                checkPresenter.resetTagList(false);
            });
        }catch (Exception e){
            Log.v("에러",e.toString());
        }
    }

    @Override
    public void setObservers() {
        Log.e("태그","옵저버 셋팅");

        checkPresenter.getArrFranchiseLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<String>>() {
                    @Override
                    public void onChanged(ArrayList<String> t) {
                        Log.e("데이터","조회데이터바뀜");
                        Log.e("데이터",t.toArray().toString());
                            if (t != null) {
                                ArrayAdapter<String> adapter = new ArrayAdapter<>(
                                        requireContext(),
                                        R.layout.drop_down_item,
                                        t
                                );
                                binding.acFranchise.setAdapter(adapter);

                                if (!t.isEmpty() && !binding.acFranchise.getText().toString().isEmpty()) {
                                    if (t.size() == 1 && t.get(0).equals(binding.acFranchise.getText().toString())) {
                                        return;
                                    }
                                    binding.acFranchise.showDropDown();
                                }
                            }
                    }
                }

        );

        checkPresenter.getDialogMessage().observe(
                getViewLifecycleOwner(),
                new Observer<String>() {
                    @Override
                    public void onChanged(String t) {
                        if(t !=null && !t.isEmpty()){
                            soundManager.play();
                            CustomDialog.showMessageDialog(
                                    requireActivity(),
                                    t,
                                    null,
                                    false,null,null
                            );
                            checkPresenter.getDialogMessage().postValue("");
                        }
                    }
                }
        );

        checkPresenter.getArrTagListLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<Tag.Data>>() {
                    @Override
                    public void onChanged(ArrayList<Tag.Data> t) {
                        if(!t.isEmpty()){
                            Log.e("옵저버","태그데이터바뀜");
                            soundManager.play();
                        }
                    }
                }
        );
    }

    @Override
    public void onViewStateRestored(@Nullable Bundle savedInstanceState) {
        super.onViewStateRestored(savedInstanceState);
        binding.acFranchise.setText("");
        checkPresenter.resetTagList(false);
    }


    @Override
    public void onTagRead(String tag) {
        Log.e("태그","받아서 등록"+tag);
        checkPresenter.checkDuplicate(tag);
    }

//    @Override
//    public void setAdapter(ArrayList<String> franchiseList) {
//        binding.acFranchise.setAdapter(new ArrayAdapter<>(
//                requireContext(),
//                R.layout.drop_down_item,
//                franchiseList
//        ));
//    }

    @Override
    public void showDropDown() {
        binding.acFranchise.showDropDown();
    }

    @Override
    public void showMessageDialog(String message) {
        Log.d("d", "showMessageDialog: "+message);
    }

    @Override
    public void playSound() {
        soundManager.play();
    }

    @Override
    public void clearFranchiseText() {
        binding.acFranchise.setText("");
    }

    @Override
    public void removeTextChangedListener() {
        binding.acFranchise.removeTextChangedListener(acTextChangedListener);
    }

    private final TextWatcher acTextChangedListener = new TextWatcher() {
        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
            if(s != null){
                Log.v("로그",s.toString());
                checkPresenter.getFranchiseList(s.toString());
            }
        }

        @Override
        public void afterTextChanged(Editable s) {
        }


        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
    };

    @Override
    protected FragmentCheckBinding getBinding(LayoutInflater inflater, ViewGroup container) {
        return FragmentCheckBinding.inflate(getLayoutInflater());

    }

    @Override
    protected CheckPresenter createPresenter() {
        return new CheckPresenter();
    }

    @Override
    public void setEmptyTextVisible(boolean isVisible) {

    }



}