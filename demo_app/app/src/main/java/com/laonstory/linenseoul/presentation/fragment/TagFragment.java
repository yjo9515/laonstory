package com.laonstory.linenseoul.presentation.fragment;

import android.os.Bundle;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.Nullable;
import androidx.databinding.ViewDataBinding;

import com.laonstory.linenseoul.presentation.common.BaseFragment;
import com.laonstory.linenseoul.presentation.tag.TagContract;
import com.laonstory.linenseoul.presentation.tag.TagPresenter;
import com.laonstory.linenseoul.util.SoundManager;


public abstract class TagFragment<B extends ViewDataBinding,P extends TagPresenter> extends BaseFragment<B,P> implements TagContract.View {
    protected SoundManager soundManager;

    // Abstract methods to be implemented in subclasses
    public abstract void setViews();
    public abstract void setObservers();



    public abstract void onTagRead(String tag);

//    @Override
//    public void onCreate(@Nullable Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        // Presenter가 null인지 확인하고 초기화하는 로직
//        if (presenter == null) {
//            presenter = createPresenter();
//            presenter.attachView(this);
//        }
//    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        binding = getBinding(inflater, container);

        if (getContext() != null) {
            soundManager = new SoundManager(getContext());
            soundManager.start();
        }
        if (presenter == null) {
            presenter = createPresenter();
            presenter.attachView(this);
        }

        return binding.getRoot();
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        setViews();
        setObservers();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        if (soundManager != null) {
            soundManager.stop();
        }
    }


}