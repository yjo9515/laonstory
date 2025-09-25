package com.laonstory.data.model;

import java.util.ArrayList;

public class TagData {
    private int assetId;
    private int frId;
    private ArrayList<Data> tagList;

    public TagData(int assetId, int frId, ArrayList<Data> tagList) {
        this.assetId = assetId;
        this.frId = frId;
        this.tagList = tagList;
    }

    public int getAssetId() {
        return assetId;
    }

    public void setAssetId(int assetId) {
        this.assetId = assetId;
    }

    public int getFrId() {
        return frId;
    }

    public void setFrId(int frId) {
        this.frId = frId;
    }

    public ArrayList<Data> getTagList() {
        return tagList;
    }

    public void setTagList(ArrayList<Data> tagList) {
        this.tagList = tagList;
    }

    public static class Data {
        private String code;

        public Data(String code) {
            this.code = code;
        }

        public String getCode() {
            return code;
        }

        public void setCode(String code) {
            this.code = code;
        }
    }
}
