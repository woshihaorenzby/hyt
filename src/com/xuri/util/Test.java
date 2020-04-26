package com.xuri.util;

/**
 * @author Administrator
 * @className Test
 * @description TODO
 * @date 2019/6/19 1:07
 **/
public class Test {
    public static void main(String[] args) {
        try{
            String text = Html2Text.getContent("<p>&nbsp;<span style=\"font-size:20px\">&nbsp; &nbsp; &nbsp; &nbsp;</span></p><p><span style=\"font-size:20px\">　　北京时间5月31日报道 Kim Wright，55岁，来自英国约克郡，是三个孩子的祖母，她在开始练习70公斤级举重后成功减重20Kg，现成为英国年龄最大的比基尼模特。</span></p><p><span style=\"font-size:20px\">　　Kim2011年与丈夫离婚，当时她的身高是153厘米、体重约70公斤，且疯狂地迷恋披萨、三明治、薯片、快餐等。Kim称，那时自信心一直处于低谷，在看到自己以前一张身穿比基尼的&ldquo;肥胖&rdquo;照片时，她励志要做出些改变。</span></p><p><img alt=\"\" src=\"http://wd.cd08.com:80/hyt/file/ckeditorImg/20160601145842.jpg\" style=\"height:501px; width:582px\" /></p><p><span style=\"font-size:20px\">决心减肥的Kim开始用鸡肉、蔬菜、鸡蛋等代替以往的快餐食品，她每天会吃6餐，一周吃的鸡蛋数量可达80个。因为偶然机会拿到了健身房8节免费一对一训练课程，Kim开始在健身房练习70公斤级别举重。在之后的8个月时间里，Kim边控制饮食边健身，成功减掉了20公斤。&ldquo;虽然一开始很多人都觉得这个老太太是不是疯了，但是在自己真正做到了之后，大家还是很佩服我的！&rdquo; &nbsp; 成功瘦身后，Kim在12岁得外孙女Melis和4岁外孙女Sofia的鼓励下去参加了比基尼竞赛，尽管她是这个竞赛数十年来年龄最大的参赛模特，但Kim还是征服了评委，成功获得了第二名。Kim称自己在穿上比基尼的时候浑身都充满着力量，现在这位55岁奶奶自信满满，她的下一个目标是在9月份的UKBFF比基尼大赛中再次拿的名次。&nbsp;</span></p>");
            text = text.replaceAll(" ", "");
            text = text.replaceAll("　", "");
            text = text.trim();
            System.out.println(text.trim());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
