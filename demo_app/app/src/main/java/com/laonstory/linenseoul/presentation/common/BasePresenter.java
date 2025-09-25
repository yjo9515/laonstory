package com.laonstory.linenseoul.presentation.common;

import android.util.Log;

import androidx.lifecycle.MutableLiveData;

import org.json.JSONObject;

// BasePresenter.java
public abstract class BasePresenter<V> {
    private static final String TAG = "BasePresenter";

    protected V view;
    protected MutableLiveData<Boolean> isLoading = new MutableLiveData<>(false);
    protected MutableLiveData<String> dialogMessage = new MutableLiveData<>("");

    public void attachView(V view) {
        this.view = view;
    }

    public void detachView() {
        this.view = null;
    }

    public MutableLiveData<Boolean> getIsLoading() {
        return isLoading;
    }

    public MutableLiveData<String> getDialogMessage() {
        return dialogMessage;
    }

    public void setErrorMessage(String errorBody) {
        Log.e(TAG, errorBody);

        try {
            String message = new JSONObject(errorBody).getString("message");
            dialogMessage.postValue(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 다른 공통 메서드들 추가 가능
}

