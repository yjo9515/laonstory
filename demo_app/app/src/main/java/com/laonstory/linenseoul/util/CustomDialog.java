package com.laonstory.linenseoul.util;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.InsetDrawable;
import android.view.View;

import androidx.appcompat.app.AlertDialog;

import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.databinding.DialogDafaultBinding;

public class CustomDialog {

    public static AlertDialog dialog = null;

    public static void showMessageDialog(
            final Activity activity,
            String message,
            String btName,
            final boolean finish,
            View.OnClickListener onOKListener,
            View.OnClickListener onCancelListener
    ) {
        if (dialog != null) {
            return;
        }

        DialogDafaultBinding binding = DialogDafaultBinding.inflate(activity.getLayoutInflater());
        dialog = new AlertDialog.Builder(activity)
                .setView(binding.getRoot())
                .setOnDismissListener(dialogInterface -> {
                    if (finish) {
                        dialog = null;
                        activity.finish();
                    } else {
                        dialog = null;
                    }
                })
                .show();

        if (dialog != null) {
            if (dialog.getWindow() != null) {
                dialog.getWindow().setBackgroundDrawable(
                        new InsetDrawable(new ColorDrawable(Color.TRANSPARENT), 24)
                );
            }
        }

        binding.tvMessage.setText(message);
        binding.btOk.setText(btName != null ? btName : activity.getString(R.string.ok));

        if (onOKListener == null) {
            binding.btOk.setOnClickListener(v -> dialog.dismiss());
            binding.btCancel.setVisibility(View.GONE);
        } else {
            binding.btOk.setOnClickListener(onOKListener);
        }

        if (onCancelListener == null) {
            binding.btCancel.setOnClickListener(v -> dialog.dismiss());
        } else {
            binding.btCancel.setOnClickListener(onCancelListener);
        }
    }
}

