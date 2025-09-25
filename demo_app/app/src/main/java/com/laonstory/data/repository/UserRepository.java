package com.laonstory.data.repository;

import android.util.Log;

import com.google.gson.Gson;
import com.laonstory.data.model.Login;

import com.laonstory.data.model.User;
import com.laonstory.linenseoul.domain.ApiClient;
import com.laonstory.linenseoul.domain.ApiService;

import java.io.IOException;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class UserRepository {

    private ApiService apiService = ApiClient.getApiService();

    public void login(String id, String pw, final LoginCallback callback) {
        User user = new User(id, pw);
        Log.v("유저정보","id : "+user.getUsername()+"pw : "+user.getPassword());
        Call<ResponseBody> request = apiService.login(user);
//        Call<String> request = apiService.login(user.getUsername(),user.getPassword());
        request.enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                if (response.isSuccessful()) {
                    try {
                        String responseBody = response.body().string();
                        Log.v("응답 ",responseBody);
                        Gson gson = new Gson();
                        Login login =
                                gson.fromJson(responseBody, Login.class);
                        callback.onSuccess(login);
                    } catch (IOException e) {
                        callback.onError("에러가 발생했습니다.");
                    }
                } else {
                    try {
                        String str =  response.errorBody().string();
                        callback.onError(str);
                    } catch (IOException e) {
                        callback.onError("에러가 발생했습니다.");
                    }
                }
            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {
                Log.v("api 에러",t.getMessage());
                callback.onError(t.getMessage());
            }
        });

    }

    public interface LoginCallback {
        void onSuccess(Login login);
        void onError(String errorMessage);
    }
}
