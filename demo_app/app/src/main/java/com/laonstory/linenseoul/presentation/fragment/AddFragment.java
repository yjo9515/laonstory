package com.laonstory.linenseoul.presentation.fragment;

import static com.laonstory.linenseoul.util.Co.hideKeyboard;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;

import androidx.annotation.Nullable;
import androidx.core.content.res.ResourcesCompat;
import androidx.lifecycle.Observer;

import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.adapter.AddTagAdapter;
import com.laonstory.linenseoul.databinding.FragmentAddBinding;
import com.laonstory.linenseoul.presentation.add.AddContract;
import com.laonstory.linenseoul.presentation.add.AddPresenter;
import com.laonstory.linenseoul.presentation.main.MainActivity;
import com.laonstory.linenseoul.util.CustomDialog;

import java.util.ArrayList;


public class AddFragment extends TagFragment<FragmentAddBinding, AddPresenter> implements AddContract.View {
    private final AddTagAdapter addTagAdapter = new AddTagAdapter();

//    private AddPresenter addPresenter = createPresenter();
private AddPresenter addPresenter = new AddPresenter();

    @Override
    public void setViews() {
        try{
            binding.setVm(addPresenter);
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

            binding.spItemName.setOnItemSelectedListener(itemSelectedListener);
            binding.rv.setAdapter(addTagAdapter);
            binding.rv.setItemAnimator(null);


            binding.btAdd.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    CustomDialog.showMessageDialog(
                            requireActivity(),
                            getString(R.string.ask_admin_add_tag),
                            "ok",
                            false,
                            new View.OnClickListener() {
                                @Override
                                public void onClick(View v) {
                                    if (CustomDialog.dialog != null) {
                                        CustomDialog.dialog.dismiss();
                                    }
                                    addPresenter.callTagAPI();
                                }
                            },null
                    );
                }
            });
            binding.tvReset.setOnClickListener(v -> {
                addPresenter.resetTagList(false);
            });
        }catch (Exception e){
            Log.v("에러",e.toString());
        }
    }

    @Override
    public void setObservers() {
        Log.e("태그","옵저버 셋팅");

        addPresenter.getArrFranchiseLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<String>>() {
                    @Override
                    public void onChanged(ArrayList<String> t) {
                        Log.e("가맹점 조회",t.toString());
                            if (t != null) {
                                ArrayAdapter<String> adapter = new ArrayAdapter<>(
                                        requireContext(),
                                        R.layout.drop_down_item,
                                        t
                                );
                                binding.acFranchise.setAdapter(adapter);

                                if (!t.isEmpty() && !binding.acFranchise.getText().toString().isEmpty()) {
                                    Log.e("가맹점 조회",binding.acFranchise.getText().toString());
                                    if (t.size() == 1 && t.get(0).equals(binding.acFranchise.getText().toString())) {
                                        return;
                                    }
                                    binding.acFranchise.showDropDown();
                                }
                            }
                    }
                }

        );
        addPresenter.getArrItemLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<String>>() {
                    @Override
                    public void onChanged(ArrayList<String> t) {
                        Log.e("조회데이터",t.toString());
                        if(t != null){
                            if(binding.acFranchise.getText().toString().isEmpty()){
                                binding.spItemName.setAdapter(
                                        new ArrayAdapter<String>(
                                                requireContext(),
                                                R.layout.drop_down_item,
                                                new ArrayList<>()
                                        )
                                );
                                return;
                            }
                            binding.spItemName.setAdapter(new ArrayAdapter<>(
                                    requireContext(),
                                    R.layout.drop_down_item,
                                    t
                            ));

                        }
                    }
                }
        );

        addPresenter.getDialogMessage().observe(
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
                            addPresenter.getDialogMessage().postValue("");
                        }
                    }
                }
        );

        addPresenter.getArrTagListLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<String>>() {
                    @Override
                    public void onChanged(ArrayList<String> t) {
                        if(!t.isEmpty()){
                            Log.e("옵저버","태그데이터바뀜");
                            Log.e("옵저버",t.toString());
                            Log.e("옵저버",addPresenter.getIsEmptyTextVisibleLiveData().getValue().toString());
                            Log.e("옵저버", String.valueOf(addTagAdapter.getItemCount()));
                            Log.e("옵저버", String.valueOf(addPresenter.getTotalTagLiveData().getValue()));
                            soundManager.play();
                            addTagAdapter.getItemCount();
                            addTagAdapter.notifyDataSetChanged();

                            addTagAdapter.setArrTagList(t);
                        }
                    }
                }
        );


        addPresenter.getIsLoading().observe(
                getViewLifecycleOwner(),
                new Observer<Boolean>() {
                    @Override
                    public void onChanged(Boolean o) {
                        if(o != null){
                            ((MainActivity) requireActivity()).showLoading(o);
                        }
                    }
                }
        );
    }

    @Override
    public void onViewStateRestored(@Nullable Bundle savedInstanceState) {
        super.onViewStateRestored(savedInstanceState);
        binding.acFranchise.setText("");
        addPresenter.resetTagList(false);
    }


    @Override
    public void onTagRead(String tag) {
        Log.e("태그","받아서 등록"+tag);
        addPresenter.addTagToList(tag);
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
            if(s != null && !s.toString().isEmpty()){
                Log.v("로그",s.toString());
                addPresenter.getFranchiseList(s.toString());
            }
        }

        @Override
        public void afterTextChanged(Editable s) {
        }


        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
    };

    private final AdapterView.OnItemSelectedListener itemSelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onNothingSelected(AdapterView<?> parent) {
            // 아무것도 선택되지 않았을 때의 동작을 구현합니다.
        }

        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            Log.e("아이템 선택됨",parent.toString());
            if (parent != null) {
                String selectedItem = parent.getItemAtPosition(position).toString();
                addPresenter.setAssetId(selectedItem);
            }
        }
    };

    @Override
    protected FragmentAddBinding getBinding(LayoutInflater inflater, ViewGroup container) {
        return FragmentAddBinding.inflate(getLayoutInflater());

    }

    @Override
    protected AddPresenter createPresenter() {
        return new AddPresenter();
    }

    @Override
    public void setEmptyTextVisible(boolean isVisible) {

    }



}