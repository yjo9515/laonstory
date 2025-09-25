package com.laonstory.data.repository;

import static com.laonstory.linenseoul.domain.ApiService.NETWORK_NOT_CONNECTED;

import android.content.SharedPreferences;
import android.util.Log;

import androidx.lifecycle.MutableLiveData;

import com.google.gson.Gson;
import com.laonstory.data.model.Asset;
import com.laonstory.data.model.ErrorResponse;
import com.laonstory.data.model.Franchise;
import com.laonstory.data.model.Login;
import com.laonstory.data.model.Tag;
import com.laonstory.data.model.UserInfo;
import com.laonstory.linenseoul.R;
import com.laonstory.linenseoul.domain.ApiClient;
import com.laonstory.linenseoul.domain.ApiService;
import com.laonstory.linenseoul.util.CustomDialog;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class FranchiseRepository {
    private ApiService apiService = ApiClient.getApiService();

    public void callFranchiseList(String text, final FranchiseCallback callback) {
        HashMap<String, String> params = new HashMap<>();
        params.put("query", String.valueOf(text));
        Log.v("보낸 쿼리 ", params.get("query"));
        apiService.getFranchiseList(UserInfo.getToken(),params).enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {

                    if (response.isSuccessful()) {
                        try {
                            String responseBody = response.body().string();
                            Log.v("응답 ", responseBody);
                            Gson gson = new Gson();
                            Franchise franchise = gson.fromJson(responseBody, Franchise.class);
                            callback.onSuccess(franchise);;
                        } catch (IOException e) {
                            callback.onError("에러가 발생했습니다.");
                        }
                    }else{
                        try {
//                                        String str =  response.errorBody().string();
                            Gson gson = new Gson();
                            String str = gson.fromJson(response.errorBody().string(), ErrorResponse.class).getMessage();
                            callback.onError(str);
                        } catch (IOException e) {
                            callback.onError(NETWORK_NOT_CONNECTED);
                        }
                    }

            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {
                Log.e("TAG", "onFailure: " + (t != null ? t.getMessage() : "Unknown error"));
            }
        });
    }

    public void getAssetList(int franchiseId, final AssetCallback callback) {
        ApiService.getAssetList(
                franchiseId,
                new Callback<ResponseBody>() {
                    @Override
                    public void onFailure(Call<ResponseBody> call, Throwable t) {
                        Log.e("실패", "onFailure: " + (t != null ? t.getMessage() : "Unknown error"));
                    }

                    @Override
                    public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                        if (response.isSuccessful()) {
                            try {

                                String responseBody = response.body().string();
                                Log.v("응답 ", responseBody);
                                Gson gson = new Gson();
                                Asset asset = gson.fromJson(responseBody, Asset.class);
                                callback.onSuccess(asset);;
                            } catch (IOException e) {
                                callback.onError("에러가 발생했습니다.");
                            }
                        }else{
                            try {
//                                        String str =  response.errorBody().string();
                                Gson gson = new Gson();
                                String str = gson.fromJson(response.errorBody().string(), ErrorResponse.class).getMessage();
                                callback.onError(str);
                            } catch (IOException e) {
                                callback.onError(NETWORK_NOT_CONNECTED);
                            }
                        }
                    }
                }
        );
    }
    public interface FranchiseCallback {
        void onSuccess(Franchise franchise);
        void onError(String errorMessage);
    }

    public interface AssetCallback {
        void onSuccess(Asset asset);
        void onError(String errorMessage);
    }
}
