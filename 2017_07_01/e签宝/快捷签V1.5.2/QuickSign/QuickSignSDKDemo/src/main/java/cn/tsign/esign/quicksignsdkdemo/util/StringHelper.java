package cn.tsign.esign.quicksignsdkdemo.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringHelper {

    /**
     * @func 去掉空格
     * @param str
     * @return
     */
    public static String replaceBlankAndBreakLine(String str) {
        String dest = "";
        if (str != null) {
            Pattern p = Pattern.compile("\\s");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }


	/**
	 * 检查字符串是否为空串
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		return (null == str || "".equals(str) || "null".equals(str));
	}




}
