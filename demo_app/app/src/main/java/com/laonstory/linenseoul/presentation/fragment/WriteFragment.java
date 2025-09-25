package com.laonstory.linenseoul.presentation.fragment;

import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.annotation.Nullable;


import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.presentation.main.MainActivity;
import com.xlzn.hcpda.uhf.UHFReader;
import com.xlzn.hcpda.uhf.entity.SelectEntity;
import com.xlzn.hcpda.uhf.entity.UHFReaderResult;


public class WriteFragment extends MyFragment implements View.OnClickListener {
    private MainActivity mainActivity;
    private EditText etAddressWrite;
    private EditText etPWDWrite;
    private EditText etDataWrite;
    private EditText etLenWrite;
    private Spinner spMembankWrite;
    private Button btnWrite;
    private CheckBox cbSelectWrite;
    private SelectEntity selectEntity = null;
    private CheckBox cb_writeZh;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_add, container, false);
    }

    @Override
    public void onKeyDownTo(int keycode) {
        super.onKeyDownTo(keycode);
        if (keycode == 287 || keycode == 286) {
            write();
        }

    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mainActivity = (MainActivity) getActivity();

        btnWrite.setOnClickListener(this);
        cbSelectWrite.setOnClickListener(this);
        cb_writeZh.setOnClickListener(this);
        spMembankWrite.setSelection(1);
    }

    @Override
    public void onClick(View view) {

    }

    int dd = 201;

    public void write() {
        String hexData = etDataWrite.getText().toString();
        if (cb_writeZh.isChecked()) {
            String hexData1 = getHexData(hexData);
            etAddressWrite.setText("1");
            hexData1 = getPC(hexData1)+hexData1;
            Log.e("TAG", "最终写入: " + hexData1);
            hexData = hexData1;
        }

        String password = etPWDWrite.getHint().toString();
        if (!TextUtils.isEmpty(etPWDWrite.getText())) {
            password = etPWDWrite.getText().toString();

        }
        int address = Integer.parseInt(etAddressWrite.getHint().toString());
        if (!TextUtils.isEmpty(etAddressWrite.getText())) {
            address = Integer.parseInt(etAddressWrite.getText().toString());
        }
        int wordCount = Integer.parseInt(etLenWrite.getHint().toString());
        if (!TextUtils.isEmpty(etLenWrite.getText())) {
            wordCount = Integer.parseInt(etLenWrite.getText().toString());
        }

        wordCount = hexData.length()/4;
        Log.e("TAG", "写入长度: " + wordCount  );
        if (hexData == null || hexData.length() == 0) {
            Toast.makeText(mainActivity, R.string.no, Toast.LENGTH_SHORT).show();
            return;
        }
        if (wordCount > hexData.length() / 4) {

            return;
        }
        int membank = spMembankWrite.getSelectedItemPosition();
        UHFReaderResult<Boolean> readerResult = null;
        if (cbSelectWrite.isChecked()) {
            //查找指定标签
            readerResult = UHFReader.getInstance().write(password, membank, address, wordCount, hexData, selectEntity);
        } else {
            readerResult = UHFReader.getInstance().write(password, membank, address, wordCount, hexData, null);
        }

        if (readerResult.getResultCode() != UHFReaderResult.ResultCode.CODE_SUCCESS) {
            return;
        }
//        dd = dd + 1;
//        Log.e("TAG", "write: " + dd);
//        etDataWrite.setText("0800E"+dd);

    }

    private String getHexData(String hexData) {
        String hex = encode(hexData);
        Log.e("TAG", "getHexData: " + hex);
        int i = 13;
        Log.e("TAG", "getHexData: " + i % 4);
        if (hex.length() % 4 == 0) {
            return hex;
        } else {
            return  getS(hex);
        }

    }

    private String getS(String hex) {
        int i = hex.length() % 4;
        Log.e("TAG", "长度是: " + hex.length());
        Log.e("TAG", "要补几个0: " + i);
        StringBuilder builder = new StringBuilder();
        for (int j = 0; j < i; j++) {
            builder.append("0");
        }
        Log.e("TAG", "最终补出来: " + hex + builder);
        return hex + builder;
    }

//    private String getData(String data) {
//
//    }

    private String getPC(String data) {
        if (data.length() == 4) {
            return "0800";
        }
        if (data.length() == 8) {
            return "1000";
        }
        if (data.length() == 12) {
            return "1800";
        }
        if (data.length() == 16) {
            return "2000";
        }
        if (data.length() == 20) {
            return "2800";
        }
        if (data.length() == 24) {
            return "3000";
        }
        if (data.length() == 28) {
            return "3800";
        }
        if (data.length() == 32) {
            return "4000";
        }
        return "3000";
    }

    private static String hexString = "0123456789ABCDEFabcdef";

    /*
     * 将字符串编码成16进制数字,适用于所有字符（包括中文）
     */
    public static String encode(String str) {
        // 根据默认编码获取字节数组
        byte[] bytes = str.getBytes();
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        // 将字节数组中每个字节拆解成2位16进制整数
        for (int i = 0; i < bytes.length; i++) {
            sb.append(hexString.charAt((bytes[i] & 0xf0) >> 4));
            sb.append(hexString.charAt((bytes[i] & 0x0f) >> 0));
        }
        return sb.toString();
    }

    private void showDialog(final Context mainActivity) {
    }

}
