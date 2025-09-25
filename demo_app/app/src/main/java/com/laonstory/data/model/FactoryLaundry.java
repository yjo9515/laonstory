package com.laonstory.data.model;

import java.util.List;

public class FactoryLaundry {

    private int frId;
    private String startDate;
    private List<Tag> tagList;
    private String endDate;

    private String factory;

    public FactoryLaundry(int frId, String startDate, List<Tag> tagList, String endDate, String factory) {
        this.frId = frId;
        this.startDate = startDate;
        this.tagList = tagList;
        this.endDate = endDate;
        this.factory = factory;
    }

    public FactoryLaundry(int frId, String startDate, List<Tag> tagList, String factory) {
        this(frId, startDate, tagList, "", factory); // Default endDate as an empty string
    }

    public int getFrId() {
        return frId;
    }

    public void setFrId(int frId) {
        this.frId = frId;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public List<Tag> getTagList() {
        return tagList;
    }

    public void setTagList(List<Tag> tagList) {
        this.tagList = tagList;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public static class Tag {
        private String code;

        public Tag(String code) {
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


