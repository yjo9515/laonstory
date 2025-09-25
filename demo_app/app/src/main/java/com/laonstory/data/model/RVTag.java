package com.laonstory.data.model;

public class RVTag {
    private String name;
    private int count;

    public RVTag(String name, int count) {
        this.name = name;
        this.count = count;
    }

    // Getter and Setter methods
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
