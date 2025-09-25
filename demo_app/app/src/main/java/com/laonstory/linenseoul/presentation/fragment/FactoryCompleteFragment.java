package com.laonstory.linenseoul.presentation.fragment;

import static com.laonstory.linenseoul.domain.ApiService.FACTORY_COMPLETE_URL;
import static com.laonstory.linenseoul.domain.ApiService.FACTORY_REQUEST_URL;
import static com.laonstory.linenseoul.util.Co.hideKeyboard;

import android.app.DatePickerDialog;
import android.os.Bundle;
import android.os.SystemClock;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.widget.ArrayAdapter;

import androidx.annotation.Nullable;
import androidx.core.content.res.ResourcesCompat;
import androidx.lifecycle.Observer;

import com.laonstory.data.model.LaundryMode;
import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.adapter.TagAdapter;
import com.laonstory.linenseoul.databinding.FragmentFactoryCompleteBinding;
import android.widget.AdapterView;
import android.widget.DatePicker;
import android.widget.Toast;

import com.laonstory.linenseoul.presentation.main.MainActivity;
import com.laonstory.linenseoul.presentation.scantag.ScanTagContract;
import com.laonstory.linenseoul.presentation.scantag.ScanTagPresenter;
import com.laonstory.linenseoul.util.Co;
import com.laonstory.linenseoul.util.CustomDialog;
import com.laonstory.linenseoul.util.CustomFormat;

import java.util.ArrayList;
import java.util.Calendar;


public class FactoryCompleteFragment extends ScanTagFragment<FragmentFactoryCompleteBinding, ScanTagPresenter> implements ScanTagContract.View {
    private final TagAdapter tagAdapter = new TagAdapter();
    private ScanTagPresenter scanTagPresenter = new ScanTagPresenter();

    long lastClickTime = 0;

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


            binding.spRequestDate.setOnItemSelectedListener(dateSelectedListener);

            binding.rlDeliveryDate.setOnClickListener(new View.OnClickListener(

            ) {
                @Override
                public void onClick(View v) {
                    showDatePicker();
                }
            });

            binding.btOk.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Log.e("클릭","ㅇㅇㅇ");
                    CustomDialog.showMessageDialog(
                            requireActivity(),
                            getString(R.string.ask_factory_complete),
                            "ok",
                            false,
                            new View.OnClickListener(
                            ){
                                @Override
                                public void onClick(View v) {
                                    if (CustomDialog.dialog != null) {
                                        CustomDialog.dialog.dismiss();
                                    }
                                    scanTagPresenter.onSendTagClick(FACTORY_COMPLETE_URL);
                                }
                            },
                            null

                    );
                }
            });

            binding.tvReset.setOnClickListener(v -> {
                scanTagPresenter.resetTagList(false);
            });

            initDate();
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

        scanTagPresenter.getArrRequestDateListLiveData().observe(
                getViewLifecycleOwner(),
                new Observer<ArrayList<String>>() {
                    @Override
                    public void onChanged(ArrayList<String> t) {
                        if( t != null){
                            ArrayAdapter<String> adapter = new ArrayAdapter<>(
                                    requireContext(),
                                    R.layout.drop_down_item,
                                    t
                            );
                            binding.spRequestDate.setAdapter(adapter);
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

    @Override
    protected FragmentFactoryCompleteBinding getBinding(LayoutInflater inflater, ViewGroup container) {
        return FragmentFactoryCompleteBinding.inflate(getLayoutInflater());
    }

    @Override
    protected ScanTagPresenter createPresenter() {
        return new ScanTagPresenter();
    }

    @Override
    public void setEmptyTextVisible(boolean isVisible) {

    }

    private void showDatePicker() {
        // 중복 클릭 방지
        if ((SystemClock.elapsedRealtime() - lastClickTime) < Co.CLICK_IGNORE_TIME) {
            return;
        }
        lastClickTime = SystemClock.elapsedRealtime();

        // 배달 날짜 가져오기
        String deliveryDate = binding.tvDeliveryDate.getText().toString();
        String[] splitDate = deliveryDate.split("-");

        Log.e("date", deliveryDate);
        Log.e("date", splitDate.toString());

        // 날짜 값이 올바른지 확인
        if (splitDate.length == 3 &&
                !splitDate[0].isEmpty() &&
                !splitDate[1].isEmpty() &&
                !splitDate[2].isEmpty()) {

            // DatePickerDialog 생성
            DatePickerDialog datePickerDialog = new DatePickerDialog(
                    requireActivity(),
                    R.style.DatePickerTheme,
                    new DatePickerDialog.OnDateSetListener() {
                        @Override
                        public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                            String date = year + "-" +
                                    CustomFormat.toTwoDigits(month + 1) + "-" +
                                    CustomFormat.toTwoDigits(dayOfMonth);

                            // LiveData 값을 업데이트
                            scanTagPresenter.getDeliveryDateLiveData().setValue(date);
                        }
                    },
                    Integer.parseInt(splitDate[0]),  // 연도
                    Integer.parseInt(splitDate[1]) - 1,  // 월 (0부터 시작)
                    Integer.parseInt(splitDate[2])  // 일
            );

            // DatePickerDialog 표시
            datePickerDialog.show();
        } else {
            // 날짜 형식이 잘못된 경우 처리
            Toast.makeText(requireActivity(), "올바른 날짜 형식이 아닙니다.", Toast.LENGTH_SHORT).show();
        }
    }



    private AdapterView.OnItemSelectedListener dateSelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onNothingSelected(AdapterView<?> parent) {
            // 아무것도 선택되지 않았을 때의 처리
        }

        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            if (parent != null) {
                scanTagPresenter.setRequestDate(parent.getItemAtPosition(position).toString());
            }
        }
    };
    private void initDate() {
        Calendar calendar = Calendar.getInstance();
        String currentDate = calendar.get(Calendar.YEAR) + "-" +
                CustomFormat.toTwoDigits(calendar.get(Calendar.MONTH) + 1) + "-" +
                CustomFormat.toTwoDigits(calendar.get(Calendar.DAY_OF_MONTH));
        Log.e("업데이트 전", currentDate);
        // LiveData 값 설정
        scanTagPresenter.deliveryDateLiveData.postValue(currentDate);
        scanTagPresenter.getDeliveryDateLiveData().postValue(currentDate);
        Log.e("오늘날짜", scanTagPresenter.deliveryDateLiveData.getValue().toString());
    }

}