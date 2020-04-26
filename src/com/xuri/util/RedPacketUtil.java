package com.xuri.util;

import java.text.DecimalFormat;
import java.util.Random;

public class RedPacketUtil {
	
	/**
	 * @Description: TODO 生成每份红包的金额
	 * @param @param money 一共多少钱
	 * @param @param num 多少份
	 * @param @return 红包的数组
	 * @return double[]
	 * @author 王东
	 * @date 2016-3-16
	 */
	public static double[] getMoney(double money, int num){
        Random r = new Random();
        DecimalFormat format = new DecimalFormat(".##");
       
        double middle = Double.parseDouble(format.format(money/num));
        double [] dou = new double[num];
        double redMoney = 0;
        double nextMoney = money;
        double sum = 0;
        int index = 0;
        for(int i=num;i>0;i--){
            if(i == 1){
                dou[index] = nextMoney;
            }else{
                while(true){
                    String str = format.format(r.nextDouble()*nextMoney);
                    redMoney = Double.parseDouble(str);
                    if(redMoney>0 && redMoney < middle){
                        break;
                    }
                }
                nextMoney = Double.parseDouble(format.format(nextMoney - redMoney));
                sum  = sum + redMoney;
                dou[index] = redMoney;
                middle = Double.parseDouble(format.format(nextMoney/(i-1)));
                index++;
            }
        }
        return dou;
    }
}
