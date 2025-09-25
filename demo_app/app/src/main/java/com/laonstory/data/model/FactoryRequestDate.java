package com.laonstory.data.model;

import java.util.List;

public class FactoryRequestDate {
    private List<Data> data;
    private String status;

    public FactoryRequestDate(List<Data> data, String status) {
        this.data = data;
        this.status = status;
    }

    public List<Data> getData() {
        return data;
    }

    public void setData(List<Data> data) {
        this.data = data;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public static class Data {
        private String date;

        public Data(String date) {
            this.date = date;
        }

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }
    }
}
