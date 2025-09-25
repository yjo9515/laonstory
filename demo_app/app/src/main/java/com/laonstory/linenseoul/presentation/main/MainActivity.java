package com.laonstory.linenseoul.presentation.main;

import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Environment;
import android.provider.Settings;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentPagerAdapter;
import androidx.viewpager.widget.ViewPager;

import com.google.android.material.tabs.TabLayout;
import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.databinding.ActivityMainBinding;
import com.laonstory.linenseoul.presentation.common.BaseActivity;
import com.laonstory.linenseoul.presentation.fragment.AddFragment;
import com.laonstory.linenseoul.presentation.fragment.CheckFragment;
import com.laonstory.linenseoul.presentation.fragment.ConfigFragment;
import com.laonstory.linenseoul.presentation.fragment.FactoryCompleteFragment;
import com.laonstory.linenseoul.presentation.fragment.FactoryRequestFragment;
import com.laonstory.linenseoul.presentation.fragment.ReadFragment;
import com.laonstory.linenseoul.presentation.fragment.WriteFragment;
import com.laonstory.linenseoul.util.CustomFormat;
import com.laonstory.linenseoul.util.CustomLog;
import com.laonstory.linenseoul.util.Utils;
import com.xlzn.hcpda.jxl.FileImport;
import com.xlzn.hcpda.uhf.UHFReader;
import com.xlzn.hcpda.uhf.entity.UHFReaderResult;
import com.xlzn.hcpda.uhf.entity.UHFTagEntity;
import com.xlzn.hcpda.uhf.enums.ConnectState;
import com.xlzn.hcpda.uhf.interfaces.OnInventoryDataListener;


import java.io.File;
import java.security.Key;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MainActivity extends BaseActivity<ActivityMainBinding> implements MainContract.View, OnInventoryDataListener {
    private String TAG = "TAG";
    private List<Fragment> datas = new ArrayList<>();
    private List<String> titles = new ArrayList<>();

    private int fragmentPosition = 0;

    FragmentPagerAdapter fragmentPagerAdapter;
    ViewPager viewPager;
    public List<UHFTagEntity> tagEntityList = new ArrayList<>();

    //탭화면 구조
    private ArrayList<Fragment> arrFragment = new ArrayList<Fragment>() {{
        add(new AddFragment());
        add(new CheckFragment());
        add(new FactoryRequestFragment());
        add(new FactoryCompleteFragment());

    }};

    @RequiresApi(api = Build.VERSION_CODES.R)



    @Override
    protected ActivityMainBinding getB() {
        return ActivityMainBinding.inflate(getLayoutInflater());
    }

    @Override
    protected void setViews() {
        try {

            //탭 위치 받기

            fragmentPosition = getIntent().getIntExtra(getString(R.string.extra_fragment_position), 0);

            initRFIDReader();

            binding.btBack.setOnClickListener(v -> {
                onBackPressed();
            });

            if (fragmentPosition >= 0 && fragmentPosition < arrFragment.size()) {
                getSupportFragmentManager().beginTransaction().replace(R.id.frame_layout, arrFragment.get(fragmentPosition)).commit();
            } else {
                // 올바르지 않은 포지션에 대한 예외 처리
                Log.e(TAG, "Invalid fragment position: " + fragmentPosition);
            }

            binding.tabLayout.selectTab(binding.tabLayout.getTabAt(fragmentPosition));

            binding.tabLayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
                @Override
                public void onTabReselected(TabLayout.Tab tab) {
                    // Do nothing
                }

                @Override
                public void onTabUnselected(TabLayout.Tab tab) {
                    // Do nothing
                }

                @Override
                public void onTabSelected(TabLayout.Tab tab) {
                    if (tab != null) {
                        fragmentPosition = tab.getPosition();
                        getSupportFragmentManager().beginTransaction()
                                .replace(R.id.frame_layout, arrFragment.get(fragmentPosition))
                                .commit();
                    }
                }
            });
        }catch (Exception e){
            Log.v("에러",e.toString());
        }

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Utils.releaseSoundPool();
        close();
    }

    public void readTag(){
        Log.e("연결진입", "연결진입");
        if(UHFReader.getInstance().getConnectState() == ConnectState.DISCONNECT){
            Log.e("연결실패", "연결시도");
            UHFReader.getInstance().connect(MainActivity.this);
            return;
        }
        if(UHFReader.getInstance().getConnectState() == ConnectState.CONNECTED){
            Log.e("연결완료", "태그읽기");
            UHFReader.getInstance().startInventory();
        }

    }


    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event){
        Log.e("hhhh", "onKeyup: " + keyCode );
        if (event.getRepeatCount() == 0 && keyCode == 11 ||keyCode == 293 || keyCode == 290 || keyCode == 287 || keyCode == 286 || keyCode == 288) {
            UHFReader.getInstance().stopInventory();
        }
        return super.onKeyUp(keyCode,event);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        Log.e("hhhh", "onKeyDown: " + keyCode );

        if (event.getRepeatCount() == 0 && keyCode == 11 ||keyCode == 293 || keyCode == 290 || keyCode == 287 || keyCode == 286 || keyCode == 288) {

            if(UHFReader.getInstance().getConnectState() == ConnectState.DISCONNECT){
                Log.e("연결실패", "연결시도");
                UHFReader.getInstance().connect(MainActivity.this);
                UHFReader.getInstance().startInventory();
            }else if(UHFReader.getInstance().getConnectState() == ConnectState.CONNECTED){
                Log.e("연결완료", "태그읽기");
                UHFReader.getInstance().startInventory();
            }

            Log.e("인벤토리", UHFReader.getInstance().startInventory().getData().toString());
            if(UHFReader.getInstance().startInventory().getData() != false){

                return super.onKeyDown(keyCode, event);
//                MyFragment myFragment = (MyFragment) fragmentPagerAdapter.getItem(viewPager.getCurrentItem());
//                myFragment.onKeyDownTo(keyCode);
//                Log.e("hhhh", myFragment.toString() );

            }
//            readTag();

        }

        return super.onKeyDown(keyCode, event);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();

        return true;
    }


    @Override
    protected void onPause() {
        super.onPause();
        close();
    }


    @Override
    protected void onResume() {
        super.onResume();
//        new OpenTask().execute();
    }
    public static String getDBFileDir() {
        String DBFilePath = Environment.getExternalStorageDirectory().getPath() + "/scanData/";
        File f = new File(DBFilePath);
        f.mkdirs();
        return DBFilePath;
    }

    public String getDate() {
        @SuppressLint("SimpleDateFormat") SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        return simpleDateFormat.format(new Date());
    }

    public String getDate2() {
        @SuppressLint("SimpleDateFormat") SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(new Date());
    }


    private void close() {
        UHFReader.getInstance().disConnect();
    }

    private void requestPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // 先判断有没有权限
            if (Environment.isExternalStorageManager()) {
                //自动获取权限
            } else {
                //跳转到设置界面引导用户打开
                Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                intent.setData(Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, 0);
            }
        } else {
            //自动获取权限
        }
    }

    @Override
    public void onStart(){
        super.onStart();
        Log.e(TAG,"리스너 셋팅");
         UHFReader.getInstance().setOnInventoryDataListener(this);
    }


    @Override
    public void onInventoryData(List<UHFTagEntity> tagEntityList) {
        Log.e("태그", "태그읽어옴");
        if (tagEntityList != null && !tagEntityList.isEmpty()) {
            for (UHFTagEntity data : tagEntityList) {
                CustomLog.e(TAG, "onReaderReadTag: " + data);

                if (!CustomFormat.isTagValid(data.getEcpHex())) {
                    continue;  // 유효하지 않은 태그는 건너뜁니다.
                }

                String tag = data.getEcpHex().substring(4);

                switch (fragmentPosition) {
                    case 0: {
                        AddFragment fragment = (AddFragment) arrFragment.get(fragmentPosition);
                        if (fragment.isVisible()) {
                            fragment.onTagRead(tag);
                        }
                        break;
                    }
                    case 1: {
                        CheckFragment fragment = (CheckFragment) arrFragment.get(fragmentPosition);
                        if (fragment.isVisible()) {
                            fragment.onTagRead(tag);
                        }
                        break;
                    }
                    case 2: {
                        FactoryRequestFragment fragment = (FactoryRequestFragment) arrFragment.get(fragmentPosition);
                        if (fragment.isVisible()) {
                            fragment.onTagRead(tag);
                        }
                        break;
                    }
                    case 3: {
                        FactoryCompleteFragment fragment = (FactoryCompleteFragment) arrFragment.get(fragmentPosition);
                        if (fragment.isVisible()) {
                            fragment.onTagRead(tag);
                        }
                        break;
                    }
                }
            }
        }

    }

    public class OpenTask extends AsyncTask<String, Integer, UHFReaderResult> {
        ProgressDialog progressDialog;

        @Override
        protected UHFReaderResult doInBackground(String... params) {
            return UHFReader.getInstance().connect(MainActivity.this);
        }


        @Override
        protected void onPreExecute() {
            // TODO Auto-generated method stub
            super.onPreExecute();
            progressDialog = new ProgressDialog(MainActivity.this);
            progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);

            progressDialog.setCanceledOnTouchOutside(false);
            progressDialog.show();
        }
    }


    public class ExPortTask extends AsyncTask<String, Integer, Boolean> {
        ProgressDialog progressDialog;

        @Override
        protected Boolean doInBackground(String... params) {
            return FileImport.daochu(params[0],   tagEntityList);
        }

        @Override
        protected void onPostExecute(Boolean result) {
            super.onPostExecute(result);
            if (result) {
                Toast.makeText(getApplicationContext(), "내보내기 성공", Toast.LENGTH_SHORT).show();
//                 new InventoryFragment().clear();
            } else {
            }
//            progressDialog.cancel();
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();

//            progressDialog = new ProgressDialog(getApplicationContext());
//            progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
//            progressDialog.setMessage("导出中...");
//            progressDialog.setCanceledOnTouchOutside(false);
//            progressDialog.show();
        }
    }

    private void initRFIDReader() {
        try {
            UHFReader.getInstance().setPower(33);
            if(UHFReader.getInstance().getConnectState() != ConnectState.CONNECTED){
                UHFReader.getInstance().disConnect();
            }
            Log.e(TAG, "reader listener removed..");

        } catch (Exception e) {
            Log.e(TAG, "ATRfidReaderException..:"+e);
        }
    }

    public void showLoading(boolean isVisible) {
        binding.rlLoading.setVisibility(isVisible ? View.VISIBLE : View.GONE);
    }

}