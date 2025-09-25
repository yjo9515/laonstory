package com.laonstory.linenseoul.presentation.add;

import static com.laonstory.linenseoul.domain.ApiService.getAssetList;

import android.util.Log;

import androidx.lifecycle.MutableLiveData;


import com.laonstory.data.model.Asset;
import com.laonstory.data.model.Franchise;
import com.laonstory.data.model.Tag;
import com.laonstory.data.model.TagData;
import com.laonstory.data.repository.FranchiseRepository;
import com.laonstory.data.repository.TagRepository;
import com.laonstory.linenseoul.presentation.tag.TagPresenter;

import java.util.ArrayList;
import java.util.List;

public class AddPresenter extends TagPresenter {

    private static final String TAG = "AddPresenter";

    private MutableLiveData<ArrayList<String>> arrAssetLiveData = new MutableLiveData<ArrayList<String>>() {{
//        postValue(new ArrayList<>());
        new ArrayList<>();
    }};
//    private MutableLiveData<ArrayList<String>> arrTagListLiveData = new MutableLiveData<ArrayList<String>>() {{
////        postValue(new ArrayList<>());
//        new ArrayList<>();
//    }};
    private MutableLiveData<ArrayList<String>> arrTagListLiveData = new MutableLiveData<>(new ArrayList<>());

    private ArrayList<Asset.Data> assetList = new ArrayList<>();

    private int franchiseId = -1;
    public int assetId = -1;

    private FranchiseRepository franchiseRepository;
    private TagRepository tagRepository;
    public AddPresenter() {
        this.franchiseRepository = new FranchiseRepository();
        this.tagRepository = new TagRepository();
    }

    public MutableLiveData<ArrayList<String>> getArrItemLiveData() {
        return arrAssetLiveData;
    }

    public MutableLiveData<ArrayList<String>> getArrTagListLiveData() {
        return arrTagListLiveData;
    }

    @Override
    public MutableLiveData<Boolean> getIsEmptyTextVisibleLiveData() {
        return isEmptyTextVisibleLiveData;
    }

    @Override
    public MutableLiveData<String> getTotalTagLiveData() {
        return totalTagLiveData;
    }


    public void addTagToList(String tag) {
            if(arrTagListLiveData.getValue().contains(tag)){
                return;
            }
            Log.e(TAG,"테그 리스트 반영");
            Log.e(TAG,"테그" + tag);
            Log.d(TAG, "태그 리스트: " + arrTagListLiveData.toString());
            arrTagListLiveData.getValue().add(tag);
//            getArrTagListLiveData().postValue(new ArrayList<>(tagList));
//            getArrTagListLiveData().postValue(tagList);
//            arrTagListLiveData.postValue(new ArrayList<>(tagList));
            arrTagListLiveData.postValue(arrTagListLiveData.getValue());
//            arrTagListLiveData.postValue(tagList);
            Log.d(TAG, "리스트 크기: " + arrTagListLiveData.getValue().size());
            totalTagLiveData.postValue(String.valueOf(arrTagListLiveData.getValue().size()));
//        totalTagLiveData.postValue("5");
            Log.d(TAG, "업데이트된 태그 리스트: " + arrTagListLiveData.getValue());
            Log.d(TAG, "업데이트된 태그 리스트: " + getArrTagListLiveData().getValue());

            Boolean isVisible =  getIsEmptyTextVisibleLiveData().getValue();
            if (isVisible != null) {
                Log.e(TAG,"테그" + isVisible.toString());
                isEmptyTextVisibleLiveData.postValue(false);
            }


    }

    @Override
    public void resetTagList(boolean resetMember) {
        super.resetTagList(resetMember);

        arrTagListLiveData.postValue(new ArrayList<>());

        if (!resetMember) return;

        franchiseId = -1;
        assetId = -1;
        arrAssetLiveData.postValue(new ArrayList<>());
    }

    @Override
    public void getFranchiseList(String text) {
        franchiseRepository.callFranchiseList(text, new FranchiseRepository.FranchiseCallback() {
            @Override
            public void onSuccess(Franchise franchise) {
                ArrayList<Franchise.Data> data = franchiseList;
                data = franchise.getData();
                Log.e(TAG, data.toString());
                List<String> arrNewFranchiseList = new ArrayList<>();

                for (Franchise.Data m :  data) {
                    arrNewFranchiseList.add(m.getName());
                }

                Log.e(TAG, arrNewFranchiseList.toString());

                arrFranchiseLiveData.postValue(arrNewFranchiseList);

                if (data.size() == 1 && data.get(0).getName().equals(text)) {
                    franchiseId = data.get(0).getId();
                    franchiseRepository.getAssetList(franchiseId, new FranchiseRepository.AssetCallback() {
                        @Override
                        public void onSuccess(Asset asset) {
                            assetList.clear();
                            assetList.addAll(asset.getData());

                            ArrayList<String> arrNewItemList = new ArrayList<>();
                            for (Asset.Data data : asset.getData()) {
                                arrNewItemList.add(data.getSubCategory());
                            }
                            arrAssetLiveData.postValue(arrNewItemList);
                        }

                        @Override
                        public void onError(String errorMessage) {
                            Log.v("조회 에러",errorMessage);

                            dialogMessage.postValue(errorMessage);
                        }
                    });
                    return;
                }
                franchiseId = -1;
                arrAssetLiveData.postValue(new ArrayList<>());
                Log.e(TAG, franchise.getData().toString());
            }

            @Override
            public void onError(String errorMessage) {

            }
        });


    }

    public void setAssetId(String asset) {
        for (Asset.Data a : assetList) {
            if (asset.equals(a.getSubCategory())) {
                assetId = a.getId();
                break;
            }
        }
    }

    public void callTagAPI() {
        isLoading.postValue(true);

        ArrayList<TagData.Data> tagList = new ArrayList<>();
        if (getArrTagListLiveData().getValue() != null) {
            for (String tag : getArrTagListLiveData().getValue()) {
                tagList.add(new TagData.Data(tag));
            }
        }
        TagData tagData = new TagData(assetId,franchiseId,tagList);
        tagRepository.callAddTag(tagData, new TagRepository.ResponseCallback() {
                    @Override
                    public void onSuccess(String tag) {
                        isLoading.postValue(false);
                        resetTagList(false);
                        return;
                    }

                    @Override
                    public void onError(String errorMessage) {
                        isLoading.postValue(false);
                        dialogMessage.postValue(errorMessage);
                    }
                }
        );
    }
}

