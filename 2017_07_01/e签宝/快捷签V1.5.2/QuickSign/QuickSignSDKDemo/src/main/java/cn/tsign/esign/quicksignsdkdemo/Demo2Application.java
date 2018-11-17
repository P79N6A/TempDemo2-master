package cn.tsign.esign.quicksignsdkdemo;

import android.app.Application;

import cn.tsign.esign.quicksignsdkdemo.util.AppException;

/**
 * 作者：zhaobf on 2016-05-06 16:15
 * # 公司:杭州天谷信息科技有限公司
 */
public class Demo2Application extends Application {

    /**
     *
     */
    @Override
    public void onCreate() {
        super.onCreate();

        //捕获程序中未处理的异常
        Thread.setDefaultUncaughtExceptionHandler(new AppException());
    }


}
