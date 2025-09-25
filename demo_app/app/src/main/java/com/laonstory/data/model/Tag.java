package com.laonstory.data.model;

public class Tag {

    private Data data;
    private String status;

    public Tag(Data data, String status) {
        this.data = data;
        this.status = status;
    }

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public static class Data {
        private String code;
        private String createdDate;
        private int franchiseId;
        private String franchiseName;
        private int id;
        private String name;
        private int type;

        public Data(String code, String createdDate, int franchiseId, String franchiseName, int id, String name, int type) {
            this.code = code;
            this.createdDate = createdDate;
            this.franchiseId = franchiseId;
            this.franchiseName = franchiseName;
            this.id = id;
            this.name = name;
            this.type = type;
        }

        public String getCode() {
            return code;
        }

        public void setCode(String code) {
            this.code = code;
        }

        public String getCreatedDate() {
            return createdDate;
        }

        public void setCreatedDate(String createdDate) {
            this.createdDate = createdDate;
        }

        public int getFranchiseId() {
            return franchiseId;
        }

        public void setFranchiseId(int franchiseId) {
            this.franchiseId = franchiseId;
        }

        public String getFranchiseName() {
            return franchiseName;
        }

        public void setFranchiseName(String franchiseName) {
            this.franchiseName = franchiseName;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getType() {
            return type;
        }

        public void setType(int type) {
            this.type = type;
        }
    }
}
