package com.xuri.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
* @ClassName: DateUtil
* @Description: TODO(时间公共类)
* @author: 王东
* @date: 2015-9-6 下午3:58:16
*/
public class DateUtil {
	/**
	* @Title: getRecentDate
	* @Description: TODO(获取当前时间)
	* @param: @param format 时间格式yyyy-MM-dd HH:mm:ss
	* @author: 王东
	* @date: 2015-9-6 下午4:00:58 
	*/
	public static String getRecentDate(String format) {
		try {
			String time = "";
			java.util.Date now = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat(format);
			time = formatter.format(now);
			return time;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	* @Title: TimeToNum
	* @Description: TODO(格式转换"2010-02-05 02:54"类型的字符串转换为"201002050254")
	* @param: @param times
	* @author: 王东
	* @date: 2015-9-6 下午4:01:25 
	*/
	public static String TimeToNum(String times) {
		String result = "";
		if (times != null && !times.equals("")) {
			String temp = times.replaceAll("-", "");
			temp = temp.replaceAll(":", "");
			result = temp.replaceAll(" ", "");
		}
		return result;
	}
	
	/**
	* @Title: NumToTime
	* @Description: TODO(格式转换 把字符串"201002050254"转换为时间字符串"2010-02-05 02:54")
	* @param: @param times
	* @author: 王东
	* @date: 2015-9-6 下午4:01:25 
	*/
	public static String NumToTime(String num) {
		String result = "";
		if (num != null && !num.equals("")) {
			StringBuffer sb = new StringBuffer("");
			sb.append(num.subSequence(0, 4));
			sb.append("-");
			sb.append(num.subSequence(4, 6));
			sb.append("-");
			sb.append(num.subSequence(6, 8));
			sb.append(" ");
			sb.append(num.substring(8, 10));
			sb.append(":");
			sb.append(num.substring(10));
			result = String.valueOf(sb);
		}
		return result;
	}
	
    /**
    * @Title: getPreviousMonthFirst
    * @Description: TODO(上个月的第一天)
    * @param: @return 设定文件
    * @author: 王东
    * @date: 2015-9-6 下午4:02:19 
    */
	public static String getPreviousMonthFirst() {
		String str = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar lastDate = Calendar.getInstance();
		lastDate.set(Calendar.DATE, 1);// 设为当前月的1号
		lastDate.add(Calendar.MONTH, -1);// 减一个月，变为下月的1号

		str = sdf.format(lastDate.getTime());
		return str;
	}
	
	/**
	* @Title: daysBetween
	* @Description: TODO(计算两个日期之间相差的天数)
	* @param: @param smdate 较小的时间
	* @param: @param bdate 较大的时间
	* @author: 王东
	* @date: 2015-9-6 下午4:03:54 
	*/
	public static long daysBetween(String smdateStr, String bdateStr) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date smdate = sdf.parse(smdateStr);
			Date bdate = sdf.parse(bdateStr);

			smdate = sdf.parse(sdf.format(smdate));
			bdate = sdf.parse(sdf.format(bdate));
			Calendar cal = Calendar.getInstance();
			cal.setTime(smdate);
			long time1 = cal.getTimeInMillis();
			cal.setTime(bdate);
			long time2 = cal.getTimeInMillis();
			long between_days = time2 - time1;
			
			return between_days;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	* @Title: daysBetween
	* @Description: TODO(计算两个日期之间相差的天数)
	* @param: @param smdate 较小的时间
	* @param: @param bdate 较大的时间
	* @author: 王东
	* @date: 2015-9-6 下午4:03:54 
	*/
	public static int daysBetweenDay(String smdateStr, String bdateStr) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date smdate = sdf.parse(smdateStr);
			Date bdate = sdf.parse(bdateStr);

			smdate = sdf.parse(sdf.format(smdate));
			bdate = sdf.parse(sdf.format(bdate));
			Calendar cal = Calendar.getInstance();
			cal.setTime(smdate);
			long time1 = cal.getTimeInMillis();
			cal.setTime(bdate);
			long time2 = cal.getTimeInMillis();
			long between_days = (time2 - time1) / (1000 * 3600 * 24);

			return Integer.parseInt(String.valueOf(between_days));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	  * 得到几天前的时间
	  */

	 public static Date getDateBefore(Date d, int day) {
	  Calendar now = Calendar.getInstance();
	  now.setTime(d);
	  now.set(Calendar.DATE, now.get(Calendar.DATE) - day);
	  return now.getTime();
	 }
	 
	/**
	* @Title: getDateAfter
	* @Description: TODO(获得几天后的日期)
	* @param: @param smdate 较小的时间
	* @param: @param bdate 较大的时间
	* @author: 王东
	* @date: 2015-9-6 下午4:03:54 
	*/
	public static String getDateAfter(String dayStr, int day) {
		try {
			SimpleDateFormat sdf = null;
			if(dayStr.length() == 10) {
				sdf = new SimpleDateFormat("yyyy-MM-dd");
			} else if(dayStr.length() == 19) {
				sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			}
			Date d = sdf.parse(dayStr);
			
			Calendar now = Calendar.getInstance();
			now.setTime(d);
			now.set(Calendar.DATE, now.get(Calendar.DATE) + day);
			return sdf.format(now.getTime());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	/**
	* @Title: compare_date
	* @Description: TODO(日期比较大小)
	* @param: @param smdate 较小的时间
	* @param: @param bdate 较大的时间
	* @author: 王东
	* @date: 2015-9-6 下午4:03:54 
	*/
	public static int compare_date(String DATE1, String DATE2) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		try {
			Date dt1 = df.parse(DATE1);
			Date dt2 = df.parse(DATE2);
			if (dt1.getTime() > dt2.getTime()) {
				System.out.println("dt1 在dt2前");
				return 1;
			} else if (dt1.getTime() < dt2.getTime()) {
				System.out.println("dt1在dt2后");
				return -1;
			} else {
				return 0;
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return 0;
	}
	/** 
     * 取得当前时间戳（精确到秒） 
     * @return 
     */  
    public static String timeStamp(){  
        long time = System.currentTimeMillis();  
        String t = String.valueOf(time/1000);  
        return t;  
    }

	public static String dealTimeQian(String time) {
    	String pattern = "yyyy-MM-dd HH:mm:ss";
    	if(time!=null&&!"".equals(time)&&!time.contains(" ")){
			pattern = "yyyy-MM-dd";
		}
		SimpleDateFormat df = new SimpleDateFormat(pattern);
		java.util.Date now;
		try {
			now = df.parse(getRecentDate(pattern));
			java.util.Date date = df.parse(time);
			long l = now.getTime() - date.getTime();
			long day = l / (24 * 60 * 60 * 1000);
			long hour = (l / (60 * 60 * 1000) - day * 24);
			long min = ((l / (60 * 1000)) - day * 24 * 60 - hour * 60);
			long s = (l / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);

			StringBuffer sb = new StringBuffer();
			if (day > 0) {
				time = time.substring(5, 10);
				time = time.replace("-", "月");
				sb.append(time);
			} else if (hour > 0)
				sb.append(hour + "小时前");
			else if (min > 0)
				sb.append(min + "分钟前");
			else
				sb.append(s + "秒前");
			return sb.toString();
		} catch (ParseException e) {
			e.printStackTrace();
			return "";
		}
	}
}
