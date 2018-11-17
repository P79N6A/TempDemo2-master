package cn.tsign.esign.quicksignsdkdemo.util.http;

import android.util.Log;

import cn.tsign.esign.quicksignsdkdemo.util.StringHelper;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.StringEntity;
import org.apache.http.protocol.HTTP;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;


/**
 * 作者：zhaobf on 2016-04-05 16:06
 * # 公司:杭州天谷信息科技有限公司
 */
public class HttpsPostJson extends BaseHttps {
    @Override
    public HttpRequestBase getHttpRequest(String path, HttpEntity stringEntity) throws UnsupportedEncodingException {
        HttpPost httpPost = new HttpPost(path);
        httpPost.setEntity(stringEntity);
        return httpPost;
    }

    @Override
    public void initHeader(HttpRequestBase httpRequest) {
        httpRequest.addHeader("Authorization", "token of yinghk"); //认证token
        httpRequest.addHeader("Content-Type", "application/json;charset=utf-8");
        httpRequest.addHeader("User-Agent", "tseal_json");
    }

    /**
     * 发送Http请求到Web站点
     *
     * @param path Web站点请求地址
     * @param json Http请求参数
     * @return Web站点响应的字符串
     */
    public String sendHttps(String path, JSONObject json) {
        Log.i(TAG, "发送 https post json 请求:" + path + "   " + json.toString());
        String result = "";
        try {
            result = super.sendHttps(path, new StringEntity(json.toString(), HTTP.UTF_8));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        Log.i(TAG, "返回 https post json 应答:" + path + "   " + (!StringHelper.isEmpty(result) ? result.replace("\r\n", "") : result));
        return result;
    }

    /**
     * 发送Http请求到Web站点
     *
     * @param path Web站点请求地址
     * @param json Http请求参数
     * @return Web站点响应的字符串
     */
    public byte[] sendHttpsRespByte(String path, JSONObject json) {
        Log.i(TAG, "发送 https post json 请求:" + path + "   " + json.toString());

        try {
            byte[] bytes = super.sendHttpsRespByte(path, new StringEntity(json.toString(), HTTP.UTF_8));
            return bytes;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        //Log.i(TAG, "返回 https post json 应答:" + path + "   " + (!StringUtils.isEmpty(result) ? result.replace("\r\n", "") : result));
        return new byte[]{};
    }
}
