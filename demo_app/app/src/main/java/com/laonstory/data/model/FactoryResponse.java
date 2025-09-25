package com.laonstory.data.model;

import java.util.ArrayList;
import com.google.gson.annotations.SerializedName;

public class FactoryResponse {
    @SerializedName("status")
    public String status;

    @SerializedName("data")
    public Data data;

    public class Data {
        @SerializedName("currentPage")
        public int currentPage;

        @SerializedName("totalPage")
        public int totalPage;

        @SerializedName("totalCount")
        public int totalCount;

        @SerializedName("list")
        public ArrayList<Factory> list;
    }

    public class Factory {
        @SerializedName("id")
        public int id;

        @SerializedName("username")
        public String username;

        @SerializedName("companyName")
        public String companyName;

        @SerializedName("companyPhone")
        public String companyPhone;

        @SerializedName("totalBillingAmount")
        public int totalBillingAmount;

        @SerializedName("totalLaundryAmount")
        public int totalLaundryAmount;

        @SerializedName("status")
        public String status;

        @SerializedName("manger")
        public Manager manager;
    }

    public class Manager {
        @SerializedName("id")
        public int id;

        @SerializedName("username")
        public String username;

        @SerializedName("nickname")
        public String nickname;

        @SerializedName("phone")
        public String phone;

        @SerializedName("name")
        public String name;

        @SerializedName("lastLoginDate")
        public String lastLoginDate;
    }
}

