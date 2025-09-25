package com.laonstory.linenseoul.presentation.menu;

import android.content.Intent;

import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.databinding.ActivityMenuBinding;
import com.laonstory.linenseoul.presentation.common.BaseActivity;
import com.laonstory.linenseoul.presentation.main.MainActivity;


public class MenuActivity extends BaseActivity<ActivityMenuBinding> implements MenuContract.View{
    @Override
    protected ActivityMenuBinding getB() {
        return ActivityMenuBinding.inflate(getLayoutInflater());
    }

    @Override
    protected void setViews() {
        binding.btAddTag.setOnClickListener(v -> {
            Intent intent = new Intent(this, MainActivity.class);
            intent.putExtra(getString(R.string.extra_fragment_position), 0);
            startActivity(intent);
                }
        );

        binding.btCheckTag.setOnClickListener(v -> {
                    Intent intent = new Intent(this, MainActivity.class);
                    intent.putExtra(getString(R.string.extra_fragment_position), 1);
                    startActivity(intent);
                }
        );

        binding.btReceiveReceiving.setOnClickListener(v -> {
                    Intent intent = new Intent(this, MainActivity.class);
                    intent.putExtra(getString(R.string.extra_fragment_position), 2);
                    startActivity(intent);
                }
        );

        binding.btLaundryComplete.setOnClickListener(v -> {
                    Intent intent = new Intent(this, MainActivity.class);
                    intent.putExtra(getString(R.string.extra_fragment_position), 3);
                    startActivity(intent);
                }
        );
    }


    @Override
    public void onBackPressed() {
        showFinishDialog();
    }
}
