package com.laonstory.linenseoul.presentation.check;


import static com.laonstory.linenseoul.domain.ApiService.NETWORK_NOT_CONNECTED;

import android.util.Log;

import androidx.lifecycle.MutableLiveData;


import com.laonstory.data.model.Tag;
import com.laonstory.data.model.UserInfo;
import com.laonstory.data.repository.FranchiseRepository;
import com.laonstory.data.repository.TagRepository;
import com.laonstory.linenseoul.presentation.tag.TagPresenter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CheckPresenter extends TagPresenter {
    private static final String TAG = "CheckPresenter";

    private final MutableLiveData<ArrayList<Tag.Data>> arrTagListLiveData = new MutableLiveData<>(new ArrayList<>());
    private final MutableLiveData<ArrayList<Tag.Data>> arrFilterListLiveData = new MutableLiveData<>(new ArrayList<>());
    private final ArrayList<String> stringTagList = new ArrayList<>();

    private String franchise = "";

    public MutableLiveData<ArrayList<Tag.Data>> getArrTagListLiveData() {
        return arrTagListLiveData;
    }


    public MutableLiveData<ArrayList<Tag.Data>> getArrFilterListLiveData() {
        return arrFilterListLiveData;
    }
    private TagRepository tagRepository;

    public CheckPresenter() {
        this.tagRepository = new TagRepository();
    }

    @Override
    public MutableLiveData<Boolean> getIsEmptyTextVisibleLiveData() {
        return super.getIsEmptyTextVisibleLiveData();
    }

    @Override
    public MutableLiveData<String> getTotalTagLiveData() {
        return super.getTotalTagLiveData();
    }

    @Override
    public void resetTagList(boolean resetMember) {
        super.resetTagList(resetMember);

        arrTagListLiveData.postValue(new ArrayList<>());
        stringTagList.clear();
    }

    public void checkDuplicate(String tag) {
        if (stringTagList.contains(tag)) return;
        // 비동기 작업을 위한 ExecutorService 생성
        ExecutorService executorService = Executors.newSingleThreadExecutor();

// 비동기 작업 수행
        executorService.submit(() -> getTagInfo(tag));

    }

    private void getTagInfo(String tagCode) {
        HashMap<String, String> params = new HashMap<>();
        params.put("tagCode", tagCode);
        Log.v("token", UserInfo.getToken());
        Log.v("params", params.toString());
        Log.e("api","서버 태그정보 가져오기");
        tagRepository.callTagInfo(params, new TagRepository.TagCallback() {
            @Override
            public void onSuccess(Tag tag) {
                Log.e(TAG,"api성공");
                addTagToList(tag.getData());
                stringTagList.add(tagCode);
            }

            @Override
            public void onError(String errorMessage) {
                Log.v("태그",errorMessage);

                dialogMessage.postValue(errorMessage);
            }
        });
    }

    private void addTagToList(Tag.Data tag) {
        if (!arrTagListLiveData.getValue().contains(tag)) {
            arrTagListLiveData.getValue().add(tag);
            arrTagListLiveData.postValue(arrTagListLiveData.getValue());
            getFilterList();
            Boolean isVisible = getIsEmptyTextVisibleLiveData().getValue();
            Log.d(TAG, "업데이트된 태그 리스트: " + arrTagListLiveData.getValue());
            Log.d(TAG, "업데이트된 태그 리스트: " + getArrTagListLiveData().getValue());
            if (isEmptyTextVisibleLiveData.getValue() != null ) {
                Log.e(TAG,"테그" + isVisible.toString());
                isEmptyTextVisibleLiveData.postValue(false);
            }
        }
    }

    @Override
    public void getFranchiseList(String text) {
        Log.v(TAG, text);
        franchise = text;
        getFilterList();

        HashMap<String, String> params = new HashMap<>();
        params.put("query",text);
//        franchiseRepository.callFranchiseList(text);
    }

    private void getFilterList() {
        ArrayList<Tag.Data> tagList = arrTagListLiveData.getValue();
        if (tagList != null) {
            if (franchise.isEmpty()) {
                arrFilterListLiveData.postValue(tagList);
                totalTagLiveData.postValue(String.valueOf(tagList.size()));
            } else {
                ArrayList<Tag.Data> filterList = new ArrayList<>();
                for (Tag.Data tag : tagList) {
                    if (tag.getFranchiseName().startsWith(franchise)) {
                        filterList.add(tag);
                    }
                }
                arrFilterListLiveData.postValue(filterList);
                totalTagLiveData.postValue(String.valueOf(filterList.size()));
            }
        }
    }
}
