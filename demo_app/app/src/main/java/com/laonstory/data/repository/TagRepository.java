package com.laonstory.data.repository;

import static com.laonstory.linenseoul.domain.ApiService.NETWORK_NOT_CONNECTED;

import android.util.Log;

import androidx.lifecycle.MutableLiveData;

import com.google.gson.Gson;
import com.laonstory.data.model.Asset;
import com.laonstory.data.model.ErrorResponse;
import com.laonstory.data.model.Franchise;
import com.laonstory.data.model.Login;
import com.laonstory.data.model.Tag;
import com.laonstory.data.model.TagData;
import com.laonstory.data.model.UserInfo;
import com.laonstory.linenseoul.domain.ApiClient;
import com.laonstory.linenseoul.domain.ApiService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class TagRepository {
    private ApiService apiService = ApiClient.getApiService();

    private ArrayList<Franchise.Data> franchiseList = new ArrayList<>();
    private MutableLiveData<List<String>> arrFranchiseLiveData = new MutableLiveData<>();
    private MutableLiveData<List<String>> arrAssetLiveData = new MutableLiveData<>();
    private List<Asset.Data> assetList = new ArrayList<>();

    private int franchiseId = -1;

    public void callTagInfo(HashMap params, final TagCallback callback) {
        Log.v("repository", "진입점");
        Call<ResponseBody> request = apiService.callTagInfo(UserInfo.getToken(),params);
        try {
            request.enqueue(
                    new Callback<ResponseBody>() {
                        @Override
                        public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                                if (response.isSuccessful()) {
                                    try {
                                        String responseBody = response.body().string();
                                        Log.v("응답 ", responseBody);
                                        Gson gson = new Gson();
                                        Tag tag = gson.fromJson(responseBody, Tag.class);
                                        callback.onSuccess(tag);;
                                    } catch (IOException e) {
                                        callback.onError("에러가 발생했습니다.");
                                    }
                                }else{
                                    try {
                                        Log.v("응답 ", "에러발생");
//                                        String str =  response.errorBody().string();
                                        Gson gson = new Gson();
                                        String str = gson.fromJson(response.errorBody().string(), ErrorResponse.class).getMessage();
                                        callback.onError(str);
                                        Log.v("응답 ", str);
                                    } catch (IOException e) {
                                        callback.onError(NETWORK_NOT_CONNECTED);
                                    }
                                }
                        }

                        @Override
                        public void onFailure(Call<ResponseBody> call, Throwable t) {
                            Log.v("api 에러",t.getMessage());
                            callback.onError(t.getMessage());
                        }
                    });
        }catch (Exception e){
            Log.v("api 에러",e.toString());
            callback.onError(e.getMessage());
        }
    }

    public void callAddTag(TagData tagdata,final ResponseCallback callback) {

        Call<ResponseBody> request = apiService.callAddTag(UserInfo.getToken(), tagdata);
        try {
            request.enqueue(
                    new Callback<ResponseBody>() {
                        @Override
                        public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                            if (response.isSuccessful()) {
                                try {
                                    String responseBody = response.body().string();
                                    Log.v("응답 ", responseBody);
//                                    Gson gson = new Gson();
//                                    Tag tag = gson.fromJson(responseBody, Tag.class);
                                    callback.onSuccess(responseBody);
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
                            Log.v("api 에러",t.getMessage());
                            callback.onError(t.getMessage());
                        }
                    });
        }catch (Exception e){
            Log.v("api 에러",e.toString());
            callback.onError(e.getMessage());
        }
    }


    public interface TagCallback {
        void onSuccess(Tag tag);
        void onError(String errorMessage);
    }

    public interface ResponseCallback {
        void onSuccess(String response);
        void onError(String errorMessage);
    }
}
