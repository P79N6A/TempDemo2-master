package cn.tsign.esign.quicksignsdkdemo.util;

import android.os.Environment;

import cn.tsign.network.util.androidCommonMaster.FileUtils;
import cn.tsign.network.util.androidCommonMaster.TimeUtils;

/**
 * 我的日志
 * 作者：zhaobf on 2016-05-03 15:36
 * # 公司:杭州天谷信息科技有限公司
 */
public class MyLog {
    public static void write(String msg) {
        String fileName = Environment.getExternalStorageDirectory() + "/tsign/log" + TimeUtils.getCurrentTimeInString(TimeUtils.DATE_FORMAT_DATE) + ".txt";
        msg ="【"+ TimeUtils.getCurrentTimeInString()+"】" + "=================================" + msg + "\r\n\r\n";
        FileUtils.writeFile(fileName, msg, true);
    }
}
