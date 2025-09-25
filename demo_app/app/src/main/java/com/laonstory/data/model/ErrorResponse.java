package com.laonstory.data.model;

import java.util.List;

public class ErrorResponse {

    private String message;

    private int status;

    private List errors;

    private String code;

    public ErrorResponse(String message, int status, List errors, String code) {
        this.message = message;
        this.status = status;
        this.errors = errors;
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List getErrors() {
        return errors;
    }

    public void setErrors(List errors) {
        this.errors = errors;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
