package com.laonstory.linenseoul.presentation.fragment;



import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
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

public class ReadFragment extends MyFragment implements View.OnClickListener {

    private MainActivity mainActivity;
    private EditText etAddressRead;
    private EditText etPWDRead;
    private EditText etDataRead;
    private EditText etLenRead;
    private Spinner spMembankRead;
    private Button btnRead;
    private CheckBox cbSelectRead;
    private SelectEntity selectEntity = null;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_read, container, false);
    }

    @Override
    public void onKeyDownTo(int keycode) {
        super.onKeyDownTo(keycode);
        if (keycode == 287 || keycode == 286) {
            read();
            Log.e("TAG", "onKeyDownTo: read"  );
        }

    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mainActivity = (MainActivity) getActivity();

        btnRead.setOnClickListener(this);
        cbSelectRead.setOnClickListener(this);
        spMembankRead.setSelection(1);

    }

    @Override
    public void onClick(View view) {
        Log.v("찍기","시작");
//        switch (view.getId()) {
//            case R.id.btnRead:
//              read();
//                break;
//            case R.id.cbSelectRead:
//                if (cbSelectRead.isChecked()) {
//                    showDialog(mainActivity);
//                }
//                break;
//        }
    }

    public void read() {
        String password = etPWDRead.getHint().toString();
        if (!TextUtils.isEmpty(etPWDRead.getText())) {
            password = etPWDRead.getText().toString();

        }
        int address = Integer.parseInt(etAddressRead.getHint().toString());
        if (!TextUtils.isEmpty(etAddressRead.getText())) {
            address = Integer.parseInt(etAddressRead.getText().toString());
        }
        int wordCount = Integer.parseInt(etLenRead.getHint().toString());
        if (!TextUtils.isEmpty(etLenRead.getText())) {
            wordCount = Integer.parseInt(etLenRead.getText().toString());
        }

        int membank = spMembankRead.getSelectedItemPosition();
        UHFReaderResult<String> readerResult = null;
        if (cbSelectRead.isChecked()) {
            //查找指定标签
            readerResult = UHFReader.getInstance().read(password, membank, address, wordCount, selectEntity);
        } else {
            readerResult = UHFReader.getInstance().read(password, membank, address, wordCount, null);
        }
        if (readerResult.getResultCode() != UHFReaderResult.ResultCode.CODE_SUCCESS) {
            etDataRead.setText("");

            return;
        }

        etDataRead.setText(readerResult.getData());
    }

    private void showDialog(final Context mainActivity) {
    }



}