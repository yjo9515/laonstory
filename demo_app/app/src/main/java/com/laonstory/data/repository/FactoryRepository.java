package com.laonstory.data.repository;

import static com.laonstory.linenseoul.domain.ApiService.FACTORY_REQUEST_DATE_URL;
import static com.laonstory.linenseoul.domain.ApiService.NETWORK_NOT_CONNECTED;
import static com.laonstory.linenseoul.domain.ApiService.TAG_INFO_URL;

import android.util.Log;

import com.google.gson.Gson;
import com.laonstory.data.model.ErrorResponse;
import com.laonstory.data.model.FactoryLaundry;
import com.laonstory.data.model.FactoryRequestDate;
import com.laonstory.data.model.UserInfo;
import com.laonstory.linenseoul.domain.ApiClient;
import com.laonstory.linenseoul.domain.ApiService;

import java.io.IOException;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class FactoryRepository {

    private ApiService apiService = ApiClient.getApiService();


    public void getFactoryAllList(final  ResponseCallback callback){
        Call<ResponseBody> request = apiService.callFactoryRequestAPI(UserInfo.getToken());
        request.enqueue(new Callback<ResponseBody>(){
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                if(response.isSuccessful()) {
                    try {
                        Log.e(TAG_INFO_URL, response.body().toString());
                        String responseBody = response.body().string();
                        callback.onSuccess(responseBody);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }else{
                    try {
//                                        String str =  response.errorBody().string();
                        Log.e("뭐지", String.valueOf(response.code()));
                        Log.e("뭐지", String.valueOf(response.errorBody().string()));
//                        Gson gson = new Gson();
//                        String str = gson.fromJson(response.errorBody().string(), ErrorResponse.class).getMessage();
//                        Log.e("뭐지", String.valueOf(response.code()));
//                        Log.e("뭐지", str);
                        callback.onError(response.errorBody().string());
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
    }

    public void getRequestDateList(int id, final FactoryRequestDateCallback callback){
        try {
            String url = FACTORY_REQUEST_DATE_URL + "/" + id;
            Log.e("url", url);
            ApiService.getRequestDateList(
                    id,
                    new Callback<ResponseBody>() {
                        @Override
                        public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                            if(response.isSuccessful()){
                                try {
                                    String responseBody = response.body().string();
                                    Gson gson = new Gson();
                                    FactoryRequestDate factoryRequestDate = gson.fromJson(responseBody, FactoryRequestDate.class);
                                    Log.e("뭐지", responseBody);
                                    callback.onSuccess(factoryRequestDate);
                                } catch (IOException e) {
                                    throw new RuntimeException(e);
                                }

                            }else{
                                try {
//                                        String str =  response.errorBody().string();
                                    Gson gson = new Gson();
                                    String str = gson.fromJson(response.errorBody().string(), ErrorResponse.class).getMessage();
                                    Log.e("뭐지", String.valueOf(response.code()));
                                    Log.e("뭐지", str);
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
                    }
            );
//            Call<ResponseBody> request = apiService.callRequestDate(UserInfo.getToken(), url);
//
//            request.enqueue(
//                    new Callback<ResponseBody>() {
//                        @Override
//                        public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
//                            if(response.isSuccessful()){
//                                try {
//                                    String responseBody = response.body().string();
//                                    Gson gson = new Gson();
//                                    FactoryRequestDate factoryRequestDate = gson.fromJson(responseBody, FactoryRequestDate.class);
//                                    callback.onSuccess(factoryRequestDate);
//                                }catch (IOException e) {
//                                    callback.onError("에러가 발생했습니다.");
//                                }
//                            }else{
//                                try {
////                                        String str =  response.errorBody().string();
//                                    Gson gson = new Gson();
//                                    String str = gson.fromJson(response.errorBody().string(), ErrorResponse.class).getMessage();
//                                    Log.e("뭐지", response.errorBody().toString());
//                                    Log.e("뭐지", str);
//                                    callback.onError(str);
//                                } catch (IOException e) {
//                                    callback.onError(NETWORK_NOT_CONNECTED);
//                                }
//                            }
//                        }
//
//                        @Override
//                        public void onFailure(Call<ResponseBody> call, Throwable t) {
//                            Log.v("api 에러",t.getMessage());
//                            callback.onError(t.getMessage());
//                        }
//                    }
//            );
        }catch (Exception e){
            Log.v("api 에러",e.toString());
            callback.onError(e.getMessage());
        }
    }

    public void postFactoryLaundry(String url, FactoryLaundry body, final ResponseCallback callback){
        try {
            Call<ResponseBody> request = apiService.callFactoryLaundry(url,UserInfo.getToken(),body);
            request.enqueue(
                    new Callback<ResponseBody>() {
                        @Override
                        public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                            if(response.isSuccessful()){
                                try {
                                    String responseBody = response.body().string();
                                    Log.v("api 성공",responseBody.toString());
                                    callback.onSuccess(responseBody);
                                }catch (IOException e) {
                                    callback.onError("에러가 발생했습니다.");
                                }
                            }else{
                                try {
//                                        String str =  response.errorBody().string();
                                    Gson gson = new Gson();
                                    String str = gson.fromJson(response.errorBody().string(), ErrorResponse.class).getMessage();
                                    Log.e("뭐지", response.errorBody().toString());
                                    Log.e("뭐지", str);
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
                    }
            );
        }catch (Exception e){
            Log.v("api 에러",e.toString());
            callback.onError(e.getMessage());
        }

    }



    public interface FactoryRequestDateCallback {
        void onSuccess(FactoryRequestDate factoryRequestDate);
        void onError(String errorMessage);
    }

    public interface ResponseCallback {
        void onSuccess(String response);
        void onError(String errorMessage);
    }
}
