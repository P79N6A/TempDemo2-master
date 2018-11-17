package cn.tsign.esign.quicksignsdkdemo.util.http;

import cn.tsign.esign.quicksignsdkdemo.util.StringHelper;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.HttpHostConnectException;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;
import java.util.Map;



/**
 * 作者：zhaobf on 2016-04-05 15:59
 * # 公司:杭州天谷信息科技有限公司
 */
public class BaseHttps implements HttpListener {
    /**
     * 是否输出网络请求日志
     */
    protected boolean OutPutLog = false;
    protected final static int mTimeout = 60000;
    public final static String UTF_8 = "utf-8";
    protected HttpListener listener = null;
    protected String TAG = this.getClass().getSimpleName();


    @Override
    public HttpRequestBase getHttpRequest(String path, HttpEntity stringEntity) throws UnsupportedEncodingException {
        throw new RuntimeException(this.getClass().getSimpleName() + "must Impl " + HttpListener.class.getCanonicalName());
    }

    @Override
    public void initHeader(HttpRequestBase httpRequest) {
        throw new RuntimeException(this.getClass().getSimpleName() + "must Impl " + HttpListener.class.getCanonicalName());
    }

    /**
     * @param stringEntity
     * @return
     */
    public String getMsgString(HttpEntity stringEntity) {
        String para = "参数解析失败";
        try {
            para = EntityUtils.toString(stringEntity);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return para;
    }

    public String MapToString(Map<String, String> map) {
        JSONObject mJson = new JSONObject();
        if (map != null && !map.isEmpty()) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                try {
                    mJson.put(entry.getKey(), entry.getValue());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }
        return mJson.toString();
    }

    /**
     * 发送Http请求到Web站点
     *
     * @param path         Web站点请求地址
     * @param stringEntity Http请求参数
     * @return Web站点响应的字符串
     */
    public String sendHttps(String path, HttpEntity stringEntity) {
        String result = "";
        HttpClient client = null;

        try {
            path = StringHelper.replaceBlankAndBreakLine(path);
            //  FileUtils.writeFile(Environment.getExternalStorageDirectory() +"/tsign/log" + DateUtil.DateToString(new Date()) + ".txt", DateUtil.DateToString(new Date(), "yyyy-MM-dd HH:mm:ss") + "---------请求：" + path + "\r\n", true);
            HttpRequestBase httpRequest = getHttpRequest(path, stringEntity);

            initHeader(httpRequest);

            HttpParams httpParameters = new BasicHttpParams();
            HttpConnectionParams.setConnectionTimeout(httpParameters, mTimeout);
            HttpConnectionParams.setSoTimeout(httpParameters, mTimeout);
            client = new HttpsClient().initHttpClient(httpParameters);
            HttpResponse httpResponse = client.execute(httpRequest);

            int statusCode = httpResponse.getStatusLine().getStatusCode();
            //Log.d("TAG", "http返回：" + statusCode + "   path  " + path);
            if (statusCode == 200) {
//                InputStream inputStream = httpResponse.getEntity().getContent();

                result = EntityUtils.toString(httpResponse.getEntity(), UTF_8);
//                result = changeInputStream(inputStream, UTF_8);
            } else {
                InputStream inputStream = httpResponse.getEntity().getContent();
                result = changeInputStream(inputStream, UTF_8);

                JSONObject obj = new JSONObject();

                try {
                    obj.put("errCode", -2);
                    obj.put("msg", result);
                    obj.put("errShow", false);
                    obj.put("statusCode", statusCode);
                    result = obj.toString();
                } catch (JSONException ee) {
                    ee.printStackTrace();
                }
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            result = MakeJSONError(false, e.getMessage());
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            result = MakeJSONError(false, e.getMessage());
        } catch (UnknownHostException e) {
            e.printStackTrace();
            result = MakeJSONError(true, "无法连接到服务器");
        } catch (IOException e) {
            e.printStackTrace();
            if (e instanceof HttpHostConnectException) {
                result = MakeJSONError(true, "服务器连接失败");//原先是"网络连接失败" ,, 现在改成"服务器连接失败"
            } else if (e instanceof ConnectTimeoutException) {
                result = MakeJSONError(true, "网络连接超时");
            } else if (e instanceof SocketTimeoutException) {
                result = MakeJSONError(true, "等待应答信息超时");
            } else {
                result = MakeJSONError(false, e.getMessage());
            }
        } catch (Exception e) {
            result = MakeJSONError(false, e.getMessage());
        }
        // FileUtils.writeFile(Environment.getExternalStorageDirectory() + "/tsign/log" + DateUtil.DateToString(new Date()) + ".txt", DateUtil.DateToString(new Date(), "yyyy-MM-dd HH:mm:ss") + "---------应答：" + result + "\r\n", true);
        return result;
    }


    /**
     * 把Web站点返回的响应流转换为字符串格式
     *
     * @param inputStream 响应流
     * @param encode      编码格式
     * @return 转换后的字符串
     */
    protected String changeInputStream(InputStream inputStream, String encode) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] data = new byte[1024];
        int len;
        String result = "";
        if (inputStream != null) {
            try {
                while ((len = inputStream.read(data)) != -1) {
                    outputStream.write(data, 0, len);
                }
                result = new String(outputStream.toByteArray(), encode);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String MakeJSONError(boolean show, String msg) {
        JSONObject obj = new JSONObject();
        try {
            obj.put("errCode", -1);
            obj.put("errShow", show);
            obj.put("msg", msg);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return obj.toString();
    }


    /**
     * 发送Http请求到Web站点
     *
     * @param path         Web站点请求地址
     * @param stringEntity Http请求参数
     * @return Web站点响应的字符串
     */
    public byte[] sendHttpsRespByte(String path, HttpEntity stringEntity) {
        HttpClient client = null;

        try {
            path = StringHelper.replaceBlankAndBreakLine(path);
            //  FileUtils.writeFile(Environment.getExternalStorageDirectory() +"/tsign/log" + DateUtil.DateToString(new Date()) + ".txt", DateUtil.DateToString(new Date(), "yyyy-MM-dd HH:mm:ss") + "---------请求：" + path + "\r\n", true);
            HttpRequestBase httpRequest = getHttpRequest(path, stringEntity);

            initHeader(httpRequest);

            HttpParams httpParameters = new BasicHttpParams();
            HttpConnectionParams.setConnectionTimeout(httpParameters, mTimeout);
            HttpConnectionParams.setSoTimeout(httpParameters, mTimeout);
            client = new HttpsClient().initHttpClient(httpParameters);
            HttpResponse httpResponse = client.execute(httpRequest);

            int statusCode = httpResponse.getStatusLine().getStatusCode();
            //Log.d("TAG", "http返回：" + statusCode + "   path  " + path);
            if (statusCode == 200) {
//                InputStream inputStream = httpResponse.getEntity().getContent();
                return EntityUtils.toByteArray(httpResponse.getEntity());
//                result = changeInputStream(inputStream, UTF_8);
            } else {
                return new byte[]{};
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
        }
        return new byte[]{};
    }
}
