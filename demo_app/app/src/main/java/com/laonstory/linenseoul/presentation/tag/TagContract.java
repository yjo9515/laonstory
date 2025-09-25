package com.laonstory.linenseoul.presentation.tag;

import androidx.lifecycle.MutableLiveData;


import com.laonstory.data.model.Tag;

import java.util.ArrayList;

public interface TagContract {

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
