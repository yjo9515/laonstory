package com.laonstory.data.model;

public class UserInfo {

    private static String token = "";
    private static int id = -1;
    private static String name = "";
    private static String userName = "";
    private static String nickName = "";
    private static String type = "";
    private static String phone = "";

    public static String getToken() {
        return token;
    }

    public static void setToken(String token) {
        UserInfo.token = token;
    }

    public static int getId() {
        return id;
    }

    public static void setId(int id) {
        UserInfo.id = id;
    }

    public static String getName() {
        return name;
    }

    public static void setName(String name) {
        UserInfo.name = name;
    }

    public static String getUserName() {
        return userName;
    }

    public static void setUserName(String userName) {
        UserInfo.userName = userName;
    }

    public static String getNickName() {
        return nickName;
    }

    public static void setNickName(String nickName) {
        UserInfo.nickName = nickName;
    }

    public static String getType() {
        return type;
    }

    public static void setType(String type) {
        UserInfo.type = type;
    }

    public static String getPhone() {
        return phone;
    }

    public static void setPhone(String phone) {
        UserInfo.phone = phone;
    }

}

