package com.laonstory.linenseoul.presentation.fragment;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.annotation.Nullable;


import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.presentation.main.MainActivity;
import com.xlzn.hcpda.uhf.UHFReader;
import com.xlzn.hcpda.uhf.entity.UHFReaderResult;
import com.xlzn.hcpda.uhf.enums.UHFSession;
import com.xlzn.hcpda.utils.LoggerUtils;


public class ConfigFragment extends MyFragment implements View.OnClickListener {

    private MainActivity mainActivity;
    private Button btnGetPower, btnSetPower, btnGetFrequencyBand, btnSetFrequencyBand, btnSetSession, btnGetSession;
    Button btnGetFrequencyPoint, btnSetFrequencyPoint, bt_setRFLink, bt_getRFLink;
    private Spinner spFrequencyBand, spPower, spSession, spPoint, spRFLink;
    private CheckBox cbTID, cbEPC, cbA, cbAB;
    int point = 902750;
    int link = 2;
    String sp_path = "pda";

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_config, container, false);
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mainActivity = (MainActivity) getActivity();

        assert mainActivity != null;

    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);

        if (isVisibleToUser) {
            getFrequencyBand();
            getPower();
            getSession();
        }
    }


    @Override
    public void onClick(View view) {



    }

    public boolean getFrequencyBand() {
        //    北美（902-928）	0x01
        //    中国1（920-925）	0x06
        //    欧频（865-867）	0x08
        //    中国2（840-845）	0x0a
        //    全频段（840-960）	0xff
        UHFReaderResult<Integer> result = UHFReader.getInstance().getFrequencyRegion();
        if (result.getResultCode() == UHFReaderResult.ResultCode.CODE_SUCCESS) {
            switch (result.getData()) {
                case 0x01:
                    spFrequencyBand.setSelection(0);
                    break;
                case 0x06:
                    spFrequencyBand.setSelection(1);
                    break;
                case 0x08:
                    spFrequencyBand.setSelection(2);
                    break;
                case 0x0a:
                    spFrequencyBand.setSelection(3);
                    break;
                case 0xff:
                    spFrequencyBand.setSelection(4);
                    break;
            }
            return true;
        }
        return false;
    }

    private void setFrequencyBand() {
        int value = 1;
        switch (spFrequencyBand.getSelectedItemPosition()) {
            case 0:
                value = 0x01;
                break;
            case 1:
                value = 0x06;
                break;
            case 2:
                value = 0x08;
                break;
            case 3:
                value = 0x0a;
                break;
            case 4:
                value = 0xff;
                break;
        }
        UHFReaderResult<Boolean> result = UHFReader.getInstance().setFrequencyRegion(value);
    }

    private void setPower() {
        int power = spPower.getSelectedItemPosition() + 5;
        if (power == 6) {
            power = 0;
        }
        LoggerUtils.d("CHLOG", power + "");
        Log.e("TAG", "setPower: " + power);
//        UHFReaderResult<Boolean> result = UHFReader.getInstance().setPower(1);
        UHFReaderResult<Boolean> result = UHFReader.getInstance().setPower(spPower.getSelectedItemPosition() + 5);
//        UHFReaderResult<Boolean> result = UHFReader.getInstance().setPower(power);
    }

    private boolean getPower() {
        UHFReaderResult<Integer> result = UHFReader.getInstance().getPower();
        if (result.getResultCode() == UHFReaderResult.ResultCode.CODE_SUCCESS) {
            spPower.setSelection(result.getData() - 5);
//            spPower.setSelection(result.getData() - 6);
            Log.e("TAG", "getPower: " + result.getData());
            return true;
        }
        return false;
    }

    private boolean getSession() {
        UHFReaderResult<UHFSession> result = UHFReader.getInstance().getSession();
        if (result.getResultCode() == UHFReaderResult.ResultCode.CODE_SUCCESS) {
            spSession.setSelection(result.getData().getValue());
            return true;
        }
        return false;
    }

    private void setSession() {
        UHFReaderResult<Boolean> result = UHFReader.getInstance().setSession(UHFSession.getValue(spSession.getSelectedItemPosition()));
    }
}
