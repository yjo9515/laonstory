package com.laonstory.linenseoul.util;

import android.util.Log;

public class CustomLog {

    private static final boolean IS_DEBUG_MODE = true;

    public static void e(String tag, String msg) {
        if (IS_DEBUG_MODE) {
            Log.e(tag, msg);
        }
    }
}

