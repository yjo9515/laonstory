package com.laonstory.linenseoul.presentation.fragment;

import static com.laonstory.linenseoul.domain.ApiService.FACTORY_REQUEST_URL;
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

import com.laonstory.data.model.LaundryMode;
import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.adapter.AddTagAdapter;
import com.laonstory.linenseoul.adapter.TagAdapter;
import com.laonstory.linenseoul.databinding.FragmentAddBinding;
import com.laonstory.linenseoul.databinding.FragmentFactoryRequestBinding;
import com.laonstory.linenseoul.domain.ApiService;
import com.laonstory.linenseoul.presentation.main.MainActivity;
import com.laonstory.linenseoul.presentation.scantag.ScanTagContract;
import com.laonstory.linenseoul.presentation.scantag.ScanTagPresenter;
import com.laonstory.linenseoul.util.CustomDialog;

import java.util.ArrayList;


public class FactoryRequestFragment extends ScanTagFragment<FragmentFactoryRequestBinding, ScanTagPresenter> implements ScanTagContract.View {
    private final TagAdapter tagAdapter = new TagAdapter();
    private ScanTagPresenter scanTagPresenter = new ScanTagPresenter();

    @Override
    public void setViews() {
        try{
            binding.setVm(scanTagPresenter);
            binding.rv.setAdapter(tagAdapter);
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

            binding.getVm().getFactoryList();

            binding.factoryAll.setOnItemSelectedListener(factorySelectedListener);


//            binding.rv.setItemAnimator(null);
//
//
            binding.btOk.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Log.e("클릭","ㅇㅇㅇ");
                    CustomDialog.showMessageDialog(
                            requireActivity(),
                            getString(R.string.ask_factory_request),
                            "ok",
                            false,
                            new View.OnClickListener(
                            ){
                                @Override
                                public void onClick(View v) {
                                    if (CustomDialog.dialog != null) {
                                        CustomDialog.dialog.dismiss();
                                    }
                                    scanTagPresenter.onSendTagClick(FACTORY_REQUEST_URL);
                                }
                            },
                            null

                    );
                }
            });

            binding.tvReset.setOnClickListener(v -> {
                scanTagPresenter.resetTagList(false);
            });
        }catch (Exception e){
            Log.v("에러",e.toString());
        }
    }

    @Override
    public void setObservers() {
        Log.e("태그","옵저버 셋팅");
        scanTagPresenter.getDialogMessage().observe(
                getViewLifecycleOwner(),
                new Observer<String>() {
                    @Override
                    public void onChanged(String t) {
                        Log.e("추가","바뀜");
                        if (t != null && !t.isEmpty()) {
                            CustomDialog.showMessageDialog(
                                    requireActivity(),
                                    t,
                                    "확인",
                                    false,
                                    new View.OnClickListener() {
                                        @Override
                                        public void onClick(View v) {
                                            if (CustomDialog.dialog != null) {
                                                CustomDialog.dialog.dismiss();
                                            }
                                        }
                                    },
                                    null
                            );
                            scanTagPresenter.getDialogMessage().postValue("");
                        }
                    }
                }
        );

        scanTagPresenter.getTotalTagLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<String>() {
                    @Override
                    public void onChanged(String t) {
                        if (t != null && !t.equals("0")) {
                            if (soundManager != null) {
                                soundManager.play();
                            }
                        }
                    }
                }
        );

        scanTagPresenter.getArrFranchiseListLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<String>>() {
                    @Override
                    public void onChanged(ArrayList<String> t) {
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

        scanTagPresenter.getIsLoading().observe(
                getViewLifecycleOwner(),
                new Observer<Boolean>() {
                    @Override
                    public void onChanged(Boolean t) {
                        if (t != null) {
                            ((MainActivity) requireActivity()).showLoading(t);
                        }
                    }
                }
        );

        scanTagPresenter.getFactoryAllListLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<String>>() {
                    @Override
                    public void onChanged(ArrayList<String> t) {
                        if (t != null) {
                            Log.e("샐랙트 변화",t.toString());
                            ArrayAdapter<String> adapter = new ArrayAdapter<>(
                                    requireContext(),
                                    R.layout.drop_down_item,
                                    t
                            );
                            binding.factoryAll.setAdapter(adapter);

                        }
                    }
                }
        );

    }

    @Override
    public void onViewStateRestored(@Nullable Bundle savedInstanceState) {
        super.onViewStateRestored(savedInstanceState);
        binding.acFranchise.setText("");
        scanTagPresenter.resetTagList(false);
    }


    @Override
    public void onTagRead(String tag) {
        Log.e("태그","받아서 등록"+tag);
        scanTagPresenter.checkDuplicate(tag, String.valueOf(LaundryMode.REQUEST.ordinal()));
    }


    private final TextWatcher acTextChangedListener = new TextWatcher() {
        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
            if(s != null && !s.toString().isEmpty()){
                Log.v("로그",s.toString());
                scanTagPresenter.getFranchiseList(s.toString());
            }
        }

        @Override
        public void afterTextChanged(Editable s) {
        }


        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
    };

//    private final TextWatcher factoryTextChangedListener = new TextWatcher() {
//        @Override
//        public void onTextChanged(CharSequence s, int start, int before, int count) {
//            if(s != null && !s.toString().isEmpty()){
//                Log.v("로그",s.toString());
//                scanTagPresenter.getFactoryAllList(s.toString());
//            }
//        }
//
//        @Override
//        public void afterTextChanged(Editable s) {
//        }
//
//
//        @Override
//        public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
//    };

    private AdapterView.OnItemSelectedListener factorySelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onNothingSelected(AdapterView<?> parent) {
            // 아무것도 선택되지 않았을 때 처리

        }

        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            if (parent != null) {
                String selectedFactory = parent.getItemAtPosition(position).toString();
                Log.e("선택",selectedFactory);
                scanTagPresenter.setRequestFactory(selectedFactory);
            }
        }
    };



    @Override
    protected FragmentFactoryRequestBinding getBinding(LayoutInflater inflater, ViewGroup container) {
        return FragmentFactoryRequestBinding.inflate(getLayoutInflater());
    }

    @Override
    protected ScanTagPresenter createPresenter() {
        return new ScanTagPresenter();
    }

    @Override
    public void setEmptyTextVisible(boolean isVisible) {

    }



}