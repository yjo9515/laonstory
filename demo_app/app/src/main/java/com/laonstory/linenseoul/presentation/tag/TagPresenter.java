package com.laonstory.linenseoul.presentation.tag;


import androidx.lifecycle.MutableLiveData;


import com.laonstory.data.model.Franchise;
import com.laonstory.linenseoul.presentation.common.BasePresenter;

import java.util.ArrayList;

public abstract class TagPresenter<V extends TagContract.View> extends BasePresenter<V> implements TagContract.Presenter {
    private static final String TAG = "TagPresenter";
    protected MutableLiveData<ArrayList<String>> arrFranchiseLiveData = new MutableLiveData<>(new ArrayList<>());
    protected MutableLiveData<String> totalTagLiveData = new MutableLiveData<>("0");
    protected MutableLiveData<Boolean> isEmptyTextVisibleLiveData = new MutableLiveData<>(true);

    protected String franchise = "";
    protected ArrayList<Franchise.Data> franchiseList = new ArrayList<Franchise.Data>();

    public MutableLiveData<ArrayList<String>> getArrFranchiseLiveData() {
        return arrFranchiseLiveData;
    }

    public MutableLiveData<String> getTotalTagLiveData() {
        return totalTagLiveData;
    }

    public MutableLiveData<Boolean> getIsEmptyTextVisibleLiveData() {

        return isEmptyTextVisibleLiveData;
    }


    public abstract void getFranchiseList(String text);

    @Override
    public void resetTagList(boolean resetMember) {
        if (view != null) {

        }

        totalTagLiveData.postValue("0");

        Boolean isVisible = isEmptyTextVisibleLiveData.getValue();
        if (isVisible != null && !isVisible) {
            isEmptyTextVisibleLiveData.postValue(true);
        }

        if (!resetMember) return;

        franchise = "";
        franchiseList = new ArrayList<Franchise.Data>();
        arrFranchiseLiveData.postValue(new ArrayList<>());
    }
}
