package com.laonstory.linenseoul.util;

import android.content.Context;
import android.media.AudioAttributes;
import android.media.SoundPool;

import com.laonstory.linenseoul.R;


public class SoundManager {

    private SoundPool soundPool;
    private final int soundIdBeep = 1;
    private boolean isReady = false;
    private final Context mContext;

    public SoundManager(Context context) {
        this.mContext = context;
    }

    public void start() {
        AudioAttributes audioAttributes = new AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                .build();

        soundPool = new SoundPool.Builder()
                .setAudioAttributes(audioAttributes)
                .setMaxStreams(8)
                .build();

        soundPool.load(mContext, R.raw.beep, 1);
        soundPool.setOnLoadCompleteListener(new SoundPool.OnLoadCompleteListener() {
            @Override
            public void onLoadComplete(SoundPool soundPool, int sampleId, int status) {
//                CustomLog.e("MySoundManager", "status: " + status);
                isReady = true;
            }
        });
    }

    public void play() {
        if (isReady && soundPool != null) {
            soundPool.play(soundIdBeep, 0.2f, 0.2f, 1, 0, 1f);
        }
    }

    public void stop() {
        if (soundPool != null) {
            soundPool.release();
            isReady = false;
            soundPool = null;
        }
    }

}
