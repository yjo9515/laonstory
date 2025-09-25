package com.laonstory.linenseoul.presentation.common;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.Nullable;
import androidx.databinding.ViewDataBinding;
import androidx.fragment.app.Fragment;


public abstract class BaseFragment<B extends ViewDataBinding, P extends BasePresenter> extends Fragment {

    protected B binding;
    protected P presenter;

    protected abstract B getBinding(LayoutInflater inflater, ViewGroup container);
    protected abstract P createPresenter();

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        binding = getBinding(inflater, container);
        presenter = createPresenter(); // Presenter 초기화
        presenter.attachView(this);

        binding.setLifecycleOwner(getViewLifecycleOwner());
        return binding.getRoot();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        createPresenter().detachView(); // View 해제
    }
}

