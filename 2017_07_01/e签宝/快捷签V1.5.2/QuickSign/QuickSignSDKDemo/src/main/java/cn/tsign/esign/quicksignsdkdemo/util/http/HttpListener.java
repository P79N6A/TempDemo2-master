package cn.tsign.esign.quicksignsdkdemo.util.http;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpRequestBase;

import java.io.UnsupportedEncodingException;

/**
 * 作者：zhaobf on 2016-04-05 16:00
 * # 公司:杭州天谷信息科技有限公司
 */
public interface HttpListener {
    HttpRequestBase getHttpRequest(String path, HttpEntity stringEntity) throws UnsupportedEncodingException;

    void initHeader(HttpRequestBase httpRequest);

}
