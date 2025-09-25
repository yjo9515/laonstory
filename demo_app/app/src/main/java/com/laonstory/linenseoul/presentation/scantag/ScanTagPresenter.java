package com.laonstory.linenseoul.presentation.scantag;


import android.util.Log;

import androidx.lifecycle.MutableLiveData;

import com.google.gson.Gson;
import com.laonstory.data.model.FactoryLaundry;
import com.laonstory.data.model.FactoryRequestDate;
import com.laonstory.data.model.FactoryResponse;
import com.laonstory.data.model.Franchise;
import com.laonstory.data.model.RVTag;
import com.laonstory.data.model.Tag;
import com.laonstory.data.model.TagType;
import com.laonstory.data.repository.FactoryRepository;
import com.laonstory.data.repository.FranchiseRepository;
import com.laonstory.data.repository.TagRepository;
import com.laonstory.linenseoul.presentation.common.BasePresenter;
import com.laonstory.linenseoul.util.CustomLog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ScanTagPresenter<V extends ScanTagContract.View> extends BasePresenter<V> implements ScanTagContract.Presenter {
    private static final String TAG = "ScanTagVM";

    private MutableLiveData<ArrayList<Tag.Data>> arrTagListLiveData =
            new MutableLiveData<>(new ArrayList<>());

    private MutableLiveData<ArrayList<RVTag>> arrRVTagListLiveData =
            new MutableLiveData<>(new ArrayList<>());

    private MutableLiveData<Boolean> isEmptyTextVisibleLiveData =
            new MutableLiveData<>(true);

    private MutableLiveData<String> totalTagLiveData =
            new MutableLiveData<>("0");

    private MutableLiveData<String> totalInputTagLiveData =
            new MutableLiveData<>("0");

    private MutableLiveData<String> totalDoneTagLiveData =
            new MutableLiveData<>("0");

    private MutableLiveData<ArrayList<String>> arrFranchiseLiveData =
            new MutableLiveData<>(new ArrayList<>());

    private MutableLiveData<ArrayList<String>> arrRequestDateListLiveData =
            new MutableLiveData<>(new ArrayList<>());
    private MutableLiveData<ArrayList<String>> factoryAllListLiveData =
            new MutableLiveData<>(new ArrayList<>());

    public MutableLiveData<String> deliveryDateLiveData =
            new MutableLiveData<>("");

    protected ArrayList<String> stringTagList = new ArrayList<>();
    private ArrayList<Franchise.Data> franchiseList = new ArrayList<>();
    private ArrayList<String> doneTagList = new ArrayList<>();

    public String getRequestDate() {
        return requestDate;
    }
    public String getRequestFactory() {
        return requestFactory;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public void setRequestFactory(String requestFactory) {
        this.requestFactory = requestFactory;
    }

    public String requestDate = "";

    public String requestFactory = "";

    public int franchiseId = -1;

    public MutableLiveData<ArrayList<RVTag>> getArrRVTagListLiveData() {
        return arrRVTagListLiveData;
    }

    public MutableLiveData<ArrayList<Tag.Data>> getArrTagListLiveData() {
        return arrTagListLiveData;
    }

    public MutableLiveData<ArrayList<String>> getArrFranchiseListLiveData() {
        return arrFranchiseLiveData;
    }

    public MutableLiveData<ArrayList<String>> getFactoryAllListLiveData() {
        return factoryAllListLiveData;
    }

    public MutableLiveData<ArrayList<String>> getArrRequestDateListLiveData() {
        return arrRequestDateListLiveData;
    }

    public MutableLiveData<Boolean> getIsEmptyTextVisibleLiveData() {
        return isEmptyTextVisibleLiveData;
    }

    public MutableLiveData<String> getTotalInputTagLiveData() {
        return totalInputTagLiveData;
    }

    public MutableLiveData<String> getTotalDoneTagLiveData() {
        return totalDoneTagLiveData;
    }

    public MutableLiveData<String> getTotalTagLiveData() {
        return totalTagLiveData;
    }

    public MutableLiveData<String> getDeliveryDateLiveData() {
        return deliveryDateLiveData;
    }


    private FranchiseRepository franchiseRepository;
    private FactoryRepository factoryRepository;

    private TagRepository tagRepository;


    public ScanTagPresenter(){
        this.franchiseRepository = new FranchiseRepository();
        this.factoryRepository = new FactoryRepository();
        this.tagRepository = new TagRepository();
    }


    public void resetTagList(boolean resetFranchise) {
        dialogMessage.postValue("");

        stringTagList = new ArrayList<>();
        doneTagList = new ArrayList<>();

        arrTagListLiveData.postValue(new ArrayList<>());
        arrRVTagListLiveData.postValue(new ArrayList<>());

        totalInputTagLiveData.postValue("0");
        totalDoneTagLiveData.postValue("0");
        totalTagLiveData.postValue("0");

        if (!Boolean.TRUE.equals(isEmptyTextVisibleLiveData.getValue())) {
            isEmptyTextVisibleLiveData.postValue(true);
        }

        if (!resetFranchise) return;

        franchiseId = -1;
        franchiseList = new ArrayList<>();
        arrFranchiseLiveData.postValue(new ArrayList<>());
    }

    public void getFranchiseList(final String text) {
        HashMap<String, String> params = new HashMap<>();
        params.put("query", text);
        franchiseRepository.callFranchiseList(text, new FranchiseRepository.FranchiseCallback() {

            @Override
            public void onSuccess(Franchise franchise) {
                franchiseList = franchise.getData();
                ArrayList<Franchise.Data> data;
                data = franchise.getData();
                ArrayList<String> arrNewFranchiseList = new ArrayList<>();

                for (Franchise.Data m :  data) {
                    arrNewFranchiseList.add(m.getName());
                }

                arrFranchiseLiveData.postValue(arrNewFranchiseList);
                CustomLog.e(TAG, "text:"+text+"franchiseList.size:"+franchiseList.size());
                if (franchiseList.size() == 1 && franchiseList.get(0).getName().equals(text)) {
                    franchiseId = franchiseList.get(0).getId();
                    getRequestDate(franchiseList.get(0).getName());
                    resetTagList(false);
                    return;
                }
                franchiseId = -1;
                arrRequestDateListLiveData.postValue(new ArrayList<>());

            }

            @Override
            public void onError(String errorMessage) {
                Log.v("조회 에러",errorMessage);
                dialogMessage.postValue(errorMessage);
            }
        });



    }
    public void getFactoryList() {
        factoryRepository.getFactoryAllList(new FactoryRepository.ResponseCallback() {
            @Override
            public void onSuccess(String response) {
                Gson gson = new Gson();
                FactoryResponse factoryResponse = gson.fromJson(response, FactoryResponse.class);

                // 파싱된 데이터를 기반으로 리스트를 생성
                ArrayList<String> factoryNames = new ArrayList<>();
                for (FactoryResponse.Factory factory : factoryResponse.data.list) {
                    factoryNames.add(factory.companyName);  // 회사 이름을 추가
                }

                // LiveData 업데이트
                factoryAllListLiveData.postValue(factoryNames);
            }

            @Override
            public void onError(String errorMessage) {
                Log.v("조회 에러",errorMessage);
                dialogMessage.postValue(errorMessage);
            }
        });

    }

    public void getRequestDate(final String franchise) {
        Log.e(TAG, "날짜 구하기 ");
        int id = -1;
        for (Franchise.Data f : franchiseList) {
            if (franchise.equals(f.getName())) {
                id = f.getId();
                break;
            }
        }
        Log.e(TAG, id+"id");
        factoryRepository.getRequestDateList(id, new FactoryRepository.FactoryRequestDateCallback() {
            @Override
            public void onSuccess(FactoryRequestDate factoryRequestDate) {
                Log.e(TAG, "날짜리턴");
                ArrayList<String> data = new ArrayList<>();

                for (FactoryRequestDate.Data d : factoryRequestDate.getData()) {
                    data.add(d.getDate());
                }
                Log.e(TAG, String.valueOf(data));
                arrRequestDateListLiveData.setValue(data);
                return;
            }

            @Override
            public void onError(String errorMessage) {
                dialogMessage.postValue(errorMessage);
            }
        });
    }

    public void onSendTagClick(String url) {
        try {
            ArrayList<Tag.Data> tagListLiveData = arrTagListLiveData.getValue();
            if (tagListLiveData == null || tagListLiveData.isEmpty()) return;

            isLoading.postValue(true);

            ArrayList<FactoryLaundry.Tag> tagList = new ArrayList<>();
            for (Tag.Data tag : tagListLiveData) {
                tagList.add(new FactoryLaundry.Tag(tag.getCode()));
            }
            Log.e(TAG, String.valueOf(franchiseId));
            Log.e(TAG, requestDate);
            Log.e(TAG, String.valueOf(tagList));
            Log.e(TAG, String.valueOf(deliveryDateLiveData));
            Log.e(TAG, getRequestFactory());

            FactoryLaundry body = new FactoryLaundry(franchiseId, requestDate, tagList,
                    deliveryDateLiveData.getValue() != null ? deliveryDateLiveData.getValue() : "", getRequestFactory());
            Log.e(TAG, "여기까지");
            factoryRepository.postFactoryLaundry(url, body, new FactoryRepository.ResponseCallback() {
                @Override
                public void onSuccess(String response) {
                    isLoading.postValue(false);
                    resetTagList(false);

                }

                @Override
                public void onError(String errorMessage) {
                    isLoading.postValue(false);
                    dialogMessage.postValue(errorMessage);
                }
            });
        }catch (Exception e){
            Log.e("에러", e.toString());
        }

    }

    public void checkDuplicate(final String tag, final String tagMode) {
        if (stringTagList.contains(tag)) return;
        Log.e("E","태그");
        ExecutorService executor = Executors.newSingleThreadExecutor();
        executor.submit(() -> {
            getTagInfo(tag, tagMode);
        });
        executor.shutdown();
    }

    private void getTagInfo(final String tagCode, final String tagMode) {
        HashMap<String, String> params = new HashMap<>();
        params.put("tagCode", tagCode);
        params.put("mode", tagMode);

        tagRepository.callTagInfo(params, new TagRepository.TagCallback() {
            @Override
            public void onSuccess(Tag tag) {
                stringTagList.add(tagCode);
                Log.e(TAG, String.valueOf(franchiseId+"/"+tag.getData().getFranchiseId()));
                if (franchiseId != tag.getData().getFranchiseId()){
                    Log.e("추가","같아야댐"); return;
                }

                if (tag.getData().getType() == TagType.OK.ordinal()) {
                    addTagToList(tag.getData());
                } else if (tag.getData().getType() == TagType.DUPLICATE.ordinal()) {
                    addDoneTagToList(tagCode);
                }
            }

            @Override
            public void onError(String errorMessage) {
                Log.v("응답 ", errorMessage);
                dialogMessage.postValue(errorMessage);
            }
        });
    }

    protected void addTagToList(Tag.Data tag) {
        Log.e("추가","태그추가");
        ArrayList<Tag.Data> tagList = arrTagListLiveData.getValue();
        if (tagList == null) return;

        if (tagList.contains(tag)) return;
        tagList.add(tag);
        arrTagListLiveData.postValue(tagList);

        totalInputTagLiveData.postValue(String.valueOf(tagList.size()));
        setTotalTag();

        if (Boolean.TRUE.equals(isEmptyTextVisibleLiveData.getValue())) {
            isEmptyTextVisibleLiveData.postValue(false);
        }

        ArrayList<RVTag> rvTagList = arrRVTagListLiveData.getValue();
        if (rvTagList == null) return;

        boolean isDuplicate = false;
        for (int i = 0; i < rvTagList.size(); i++) {
            RVTag r = rvTagList.get(i);
            if (r.getName().equals(tag.getName())) {
                isDuplicate = true;
                rvTagList.get(i).setCount(r.getCount() + 1);
                break;
            }
        }

        if (isDuplicate) {
            arrRVTagListLiveData.postValue(rvTagList);
        } else {
            rvTagList.add(new RVTag(tag.getName(), 1));
            arrRVTagListLiveData.postValue(rvTagList);
        }
    }

    private void addDoneTagToList(String tag) {
        Log.e("추가","태그추가끝");
        if (doneTagList.contains(tag)) return;
        doneTagList.add(tag);
        totalDoneTagLiveData.postValue(String.valueOf(doneTagList.size()));
        setTotalTag();
    }

    private void setTotalTag() {
        int inputTag = Integer.parseInt(totalInputTagLiveData.getValue() != null ? totalInputTagLiveData.getValue() : "0");
        int doneTag = Integer.parseInt(totalDoneTagLiveData.getValue() != null ? totalDoneTagLiveData.getValue() : "0");
        totalTagLiveData.postValue(String.valueOf(inputTag + doneTag));
    }


}
