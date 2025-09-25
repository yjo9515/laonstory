package com.laonstory.linenseoul.presentation.add;

import androidx.lifecycle.MutableLiveData;

import com.laonstory.data.model.Tag;

import java.util.ArrayList;

public interface AddContract {

    interface View {
        void showMessageDialog(String message);
        void playSound();
        void clearFranchiseText();
        void removeTextChangedListener();
    }


    interface Presenter {
        void checkDuplicate(String tag);
        void getFranchiseList(String text);
        void resetTagList(boolean resetMember);
        MutableLiveData<ArrayList<String>> getArrTagListLiveData();
        MutableLiveData<ArrayList<Tag.Data>> getArrFilterListLiveData();
        MutableLiveData<String> getTotalTagLiveData();

    }
}
