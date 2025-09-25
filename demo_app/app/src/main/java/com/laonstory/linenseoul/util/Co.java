package com.laonstory.linenseoul.util;

import android.content.Context;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

public class Co {
    public static final long LOADING_TIME = 1000L;
    public static final int CLICK_IGNORE_TIME = 500;

    public static void hideKeyboard(View view) {
        if (view != null) {
            InputMethodManager imm = (InputMethodManager) view.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
            if (imm != null) {
                imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
                view.clearFocus();
            }
        }
    }

}
