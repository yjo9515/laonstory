package com.laonstory.linenseoul.presentation.scantag;

import androidx.lifecycle.MutableLiveData;

public interface ScanTagContract {

    interface View {
        void setEmptyTextVisible(boolean isVisible);
    }

    interface Presenter {
        void resetTagList(boolean resetMember);
//        MutableLiveData<ArrayList<String>> getArrTagListLiveData();
        MutableLiveData<String> getTotalTagLiveData();
        MutableLiveData<Boolean> getIsEmptyTextVisibleLiveData();

    }
}
