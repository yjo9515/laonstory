package com.laonstory.linenseoul.presentation.common;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Rect;
import android.os.Bundle;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AutoCompleteTextView;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.ViewDataBinding;

import com.laonstory.linenseoul.util.Co;
import com.laonstory.linenseoul.util.CustomDialog;


public abstract class BaseActivity<B extends ViewDataBinding> extends AppCompatActivity {

    protected B binding;
    protected SharedPreferences pref;
    private Rect globalRect = new Rect(0, 0, 0, 0);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = getB();
        setContentView(binding.getRoot());
        pref = getSharedPreferences("prefData", Context.MODE_PRIVATE);
        setViews();
        Log.i("진입점","완료");
    }

    protected abstract B getB();

    protected abstract void setViews();

    protected void showFinishDialog() {
        if (CustomDialog.dialog != null) {
            CustomDialog.dialog.dismiss();
        }
        CustomDialog.showMessageDialog(this,
                "앱을 종료하시겠습니까?",
                null,  // btName
                true,  // finish
                v -> {
                    if (CustomDialog.dialog != null) {
                        CustomDialog.dialog.dismiss();
                    }
                    finishAffinity();
                },
                null  // onCancelListener
        );
    }


    @Override
    public boolean dispatchTouchEvent(MotionEvent ev) {
        if (ev.getAction() == MotionEvent.ACTION_UP) {
            View currentFocusView = getCurrentFocus();
            if (currentFocusView instanceof AutoCompleteTextView || currentFocusView instanceof EditText) {
                currentFocusView.getGlobalVisibleRect(globalRect);
            }

            int x = (int) ev.getX();
            int y = (int) ev.getY();

            if (!globalRect.contains(x, y)) {
                if (currentFocusView != null) {
                    Co.hideKeyboard(currentFocusView);
                }
            }
        }
        return super.dispatchTouchEvent(ev);
    }
}
