package com.liang.code;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.http.HttpStatus;

import java.io.Serializable;

/**
 * 构造公共返回数据
 *
 * @param <T>
 */
public class ReturnT<T> implements Serializable {
    // 成功（200）
    public static final HttpStatus SUCCESS_CODE = HttpStatus.OK;
    // 失败（500）
    public static final HttpStatus FALIED_CODE = HttpStatus.INTERNAL_SERVER_ERROR;

    // 状态码
    private int code;
    // 提示信息
    private String msg;
    // 数据信息
    private T data;

    public ReturnT() {
    }

    public ReturnT(HttpStatus code, String msg) {
        this.code = code.value();
        this.msg = msg;
        this.data = null;
    }

    public ReturnT(int code, String msg) {
        this.code = code;
        this.msg = msg;
        this.data = null;
    }

    public ReturnT(HttpStatus code, String msg, T data) {
        this.code = code.value();
        this.msg = msg;
        this.data = data;
    }

    public ReturnT(String msg, T data) {
        this(HttpStatus.OK, msg, data);
    }

    public ReturnT(T data) {
        this.code = HttpStatus.OK.value();
        this.data = data;
        this.msg = null;
    }

    @JsonIgnore
    public boolean isSuccess() {
        return this.code >= 200 && this.code < 300;
    }

    public int getCode() {
        return code;
    }

    public ReturnT<T> setCode(HttpStatus code) {
        this.code = code.value();
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public ReturnT<T> setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public T getData() {
        return data;
    }

    public ReturnT<T> setData(T data) {
        this.data = data;
        return this;
    }

    public static ReturnT success(String msg) {
        return new ReturnT(SUCCESS_CODE, msg);
    }

    public static ReturnT fail(String msg) {
        return new ReturnT(FALIED_CODE, msg);
    }

    public static ReturnT fail(HttpStatus code, String msg) {
        return new ReturnT(code, msg);
    }

    @Override
    public String toString() {
        return "ReturnT{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", data=" + data +
                '}';
    }
}
