package com.laonstory.linenseoul.presentation.login;

import android.content.Intent;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.laonstory.data.model.Login;
import com.laonstory.data.model.UserInfo;
import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.databinding.ActivityLoginBinding;
import com.laonstory.linenseoul.presentation.common.BaseActivity;;
import com.laonstory.linenseoul.presentation.menu.MenuActivity;
import com.laonstory.linenseoul.util.Co;
import com.laonstory.linenseoul.util.CustomFormat;

import org.json.JSONArray;
import org.json.JSONObject;


public class LoginActivity extends BaseActivity<ActivityLoginBinding> implements LoginContract.View {

    private EditText id;
    private EditText pw;
    private Button login;
    LoginContract.Presenter presenter;
    private static final String TAG = "LoginA";
    private final Handler mHandler = new Handler(Looper.getMainLooper());

    @Override
    protected ActivityLoginBinding getB() {
        return ActivityLoginBinding.inflate(getLayoutInflater());
    }

    @Override
    protected void setViews() {
        id = findViewById(R.id.id);
        pw = findViewById(R.id.pw);
        login = findViewById(R.id.login);
        presenter = new LoginPresenter( this);

        binding.pw.setOnEditorActionListener((v, actionId, event) -> {
            if (actionId == EditorInfo.IME_ACTION_DONE) {
                presenter.login(id.getText().toString(), pw.getText().toString());
                Co.hideKeyboard(this.getCurrentFocus());
            }
            return false;
        });

        binding.login.setOnClickListener(v -> presenter.login(id.getText().toString(), pw.getText().toString()));

    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        showFinishDialog();
    }

//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        presenter = new LoginPresenter( this);
//    }

    @Override
    public void onLoginSuccess(Login login) {
        Log.i("token",login.getData().getToken());
        pref.edit().putString(getString(R.string.pref_access_token), login.getData().getToken()).apply();
        UserInfo.setToken(login.getData().getToken());
        saveUserInfoJson();
        Intent intent = new Intent(this, MenuActivity.class);
        startActivity(intent);
        //현재 액티비티 종료
        finish();
    }

    private void saveUserInfoJson() {
        try {
            JSONObject json = new JSONObject();
            json.put("id", UserInfo.getUserName());
            json.put("date", CustomFormat.getDate());
            json.put("token", UserInfo.getToken());

            String userList = pref.getString(getString(R.string.pref_user_list), "");

            if (userList == null || userList.isEmpty()) {
                JSONArray jsonArray = new JSONArray();
                jsonArray.put(json);
                pref.edit().putString(getString(R.string.pref_user_list), jsonArray.toString()).apply();
                return;
            }

            JSONArray jsonArray = new JSONArray(userList);
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject obj = jsonArray.getJSONObject(i);
                String name = obj.getString("id");
                if (UserInfo.getUserName().equals(name)) {
                    jsonArray.remove(i);
                    break;
                }
            }
            jsonArray.put(json);
            pref.edit().putString(getString(R.string.pref_user_list), jsonArray.toString()).apply();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onLoginError(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }
}
