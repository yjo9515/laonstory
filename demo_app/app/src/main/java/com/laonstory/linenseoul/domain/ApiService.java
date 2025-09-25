package com.laonstory.linenseoul.domain;



import android.util.Log;

import com.laonstory.data.model.Asset;
import com.laonstory.data.model.FactoryLaundry;
import com.laonstory.data.model.FactoryRequestDate;
import com.laonstory.data.model.Franchise;
import com.laonstory.data.model.Tag;
import com.laonstory.data.model.TagData;
import com.laonstory.data.model.User;
import com.laonstory.data.model.UserInfo;

import java.util.HashMap;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.Headers;
import retrofit2.http.POST;
import retrofit2.http.GET;
import retrofit2.http.QueryMap;
import retrofit2.http.Url;
// Retrofit 인터페이스, restApi 정의하는곳



public interface ApiService {

     String NETWORK_NOT_CONNECTED = "네트워크에 연결되어 있지 않습니다.\n연결 후 다시 시도해 주세요.";
     String LOGIN = "auth/login";
     String FRANCHISE_LIST_URL = "tag/franchise";
     String FRANCHISE_ASSET_URL = "tag/franchise/asset";

     String FACTORY_ALL_URL = "admin/factory";
     String FACTORY_COMPLETE_URL = "tag/factory/complete";
     String FACTORY_REQUEST_URL = "tag/factory";
     String TAG_INFO_URL = "tag/admin";

     String ADMIN_TAG_URL = "tag";


     String FACTORY_REQUEST_DATE_URL = "tag/factory/date";



    @Headers("Content-Type: application/json;charset=UTF-8")
    @POST(LOGIN)
    Call<ResponseBody> login(@Body User user);
//    Call<String> login(@Query("username") String username, @Query("password") String password );


    @Headers("Content-Type: application/json;charset=UTF-8")
    @GET(FRANCHISE_LIST_URL)
    Call<ResponseBody> getFranchiseList(
            @Header("Authorization") String token,
            @QueryMap HashMap<String, String> params
    );



    public static void getAssetList(int id, Callback<ResponseBody> callback) {
        String url = FRANCHISE_ASSET_URL + "/" + id;
        ApiClient.getApiService().callFranchiseAssetAPI("Bearer " + UserInfo.getToken(), url).enqueue(callback);
    }

    public static void getRequestDateList(int id, Callback<ResponseBody> callback) {
        String url = FACTORY_REQUEST_DATE_URL + "/" + id;
        Log.e("토큰",UserInfo.getToken());
        ApiClient.getApiService().callRequestDate(UserInfo.getToken(), url).enqueue(callback);
    }

    @Headers("Content-Type: application/json;charset=UTF-8")
    @GET(FRANCHISE_LIST_URL)
    Call<Franchise> callFranchiseListAPI(
            @Header("Authorization") String token,
            @QueryMap HashMap<String, String> params
    );

    @GET
    Call<ResponseBody> callFranchiseAssetAPI(
            @Header("Authorization") String token,
            @Url String url
    );

    @GET(TAG_INFO_URL)
    Call<ResponseBody> callTagInfo(
            @Header("Authorization") String token,
            @QueryMap HashMap<String, String> params
    );

    @POST(ADMIN_TAG_URL)
    Call<ResponseBody> callAddTag(
            @Header("Authorization") String token,
            @Body TagData body
    );

    @POST
    Call<ResponseBody> callFactoryLaundry(
            @Url String url,
            @Header("Authorization") String token,
            @Body FactoryLaundry body
    );

    @GET
    Call<ResponseBody> callRequestDate(
            @Header("Authorization") String token,
            @Url String url
    );

    @GET(FACTORY_ALL_URL)
    Call<ResponseBody> callFactoryRequestAPI(
            @Header("Authorization") String token
    );
}
