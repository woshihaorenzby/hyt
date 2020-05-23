package com.xuri.main.wxMobileSale.action;

import com.xuri.main.video.service.VideoService;
import com.xuri.main.wx.utils.GetWxOrderno;
import com.xuri.system.service.BaseService;
import com.xuri.util.*;
import com.xuri.vo.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author 黄森泽
 * @Title: VideoAction
 * @Description: TODO 视频列表
 * @date 2016-4-25
 */
public class WxMobileSaleAction extends BaseAction {

    private static final long serialVersionUID = 8109868459302222569L;
    private WxMobileSale mobileSale;
    private Page page;
    private List<WxMobileSale> mobileSaleList;
    private MessageVo messageVo = new MessageVo();
    private String shareDesc1;
    private Integer hasSale;
    private String ids;
    private String typeName;
    private String redirectURL;
    private Qr qr;



    @Autowired
    private BaseService baseService;
    @Autowired
    private VideoService videoService;

    public String wxShow() {
        return "wxShow";
    }

    public String editPage() {
        try {

            if (mobileSale.getId() != null && mobileSale.getId().length() > 0) {
                mobileSale = baseService.selectById(mobileSale);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "editPage";
    }

    /**
     * @Description: TODO 视频列表
     * @author 黄森泽
     */
    public String list() {
        try {
            page = baseService.selectPageList(page, mobileSale);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "page";
    }

    /**
     * @Description: TODO 保存
     * @author 黄森泽
     */
    public String save() {
        try {
            if (mobileSale.getId() == null || mobileSale.getId().length() == 0) {
                baseService.insert(mobileSale);
            } else {
                baseService.update(mobileSale);
            }
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }
    /**
     * @Description: 做卖出操作
     * @author 黄森泽
     */
    public String doSalse() {
        try {
            if (mobileSale.getId() == null || mobileSale.getId().length() == 0) {
                baseService.insert(mobileSale);
            } else {
                mobileSale.setHasSale(1);
                baseService.update(mobileSale);
            }
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }
    /**
     * @Description: TODO 删除
     * @author 黄森泽
     */
    public String delete() {
        try {
            if(ids!=null&&ids!=""){
               String[] _ids =  ids.split(",");
                for (String id: _ids) {
                    WxMobileSale wxMobileSale = new WxMobileSale();
                    wxMobileSale.setId(id);
                    baseService.delete(wxMobileSale);
                }
            }
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }


    /**
     * @Author wangd
     * @Description TODO 微信首页显示列表
     * @Date 2019/5/23 22:45
     * @Param video.typeName 分类名称
     * @Return java.lang.String
     **/
    public String wxMobileSaleMainList() {
        try {
            if (mobileSale == null)
                mobileSale = new WxMobileSale();
            if(page==null)
                page = new Page();
            if(mobileSale.getIds()!=null&mobileSale.getIds()!=""){
                mobileSale.set_ids(Arrays.asList(mobileSale.getIds().split(",")));
            }
            mobileSale.getPreference();
            String law = mobileSale.getLaw();
            if(law!=null){
                String l = GetWxOrderno.getLetter(law);

                List<String> lawList = this.getLawList(l);
                if(law.contains("中间")){
                    mobileSale.setDobleLikeLaw(lawList);
                }else{
                    mobileSale.setStartLikeLaw(lawList);
                }
            }
            page = baseService.selectPageList(page, mobileSale);
            mobileSaleList = (List<WxMobileSale>) page.getData();
            if(mobileSaleList.size()>1){
                mobileSaleList = (List<WxMobileSale>) page.getData();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxMobileSaleList";
    }

    /**
     * @Description: TODO 显示视频详情
     * @author 王东
     */
    public String wxMobileSaleDetail() {
        try {
            mobileSale = baseService.selectById(mobileSale);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxMobileSaleDetail";
    }


    /**
     * 收藏夹
     *
     * @return
     */
    public String wxCollectionNums() {
        return "wxCollectionNums";
    }

    /**
     * @Description: TODO 累积访问量
     * @author 周博宇
     */
    public String wxConsultation() {
        List<Qr> qrs = null;
        try {
            qrs = baseService.selectList(qr);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(qrs!=null&&qrs.size()>0&&qrs.get(0)!=null){
            this.qr = qrs.get(0);
        }
        return "wxConsultation";
    }
    /**
     * @Description: TODO 累积访问量
     * @author 周博宇
     */
    public String wxGoToHtml() {
        this.redirectURL= "/WebRoot/file/htm/"+this.typeName;
        return "wxGoToHtml";
    }
    /**
     * zhouboyu
     * 手机号导入
     * @return
     */
    public String mobileSale_import() {
        try {
        } catch (Exception e) {
            e.printStackTrace();
        }
        messageVo.setCode("1");
        return "messageVo";
    }

    /**
     * 获取规律数字集合
     * @param str
     * @return
     */
    public List<String> getLawList(String str){
        List<String> list =new ArrayList<>();
        Integer a = 0;
        Integer[] arr = new Integer[]{a,a+1,a+2,a+3,a+4};
        char x = 'B';
        int flag = 1;
        while (x<='E'){
            if(str.indexOf(x)>0){
                arr[flag] = arr[flag-1]+1;
            }else{
                arr[flag] = arr[flag-1];
            }
            flag++;
            x++;
        }
        List<Integer> markers= new ArrayList<>();
        for (char as:str.toCharArray()) {
            int index = 0;
            switch (as){
                case 'A':
                    index=0;
                    break;
                case 'B':
                    index=1;
                    break;
                case 'C':
                    index=2;
                    break;
                case 'D':
                    index=3;
                    break;
                case 'E':
                    index=4;
                    break;
            }
            markers.add(index);
        }
        while (arr[arr.length-1]<=9){
            StringBuffer sb = new StringBuffer();
            for (Integer index : markers){
                sb.append(arr[index]);
            }
            list.add(sb.toString());
            for (int i=0;i<arr.length;i++){
                arr[i] = arr[i]+1;
            }
        }
        return list;
    }
    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

    public WxMobileSale getMobileSale() {
        return mobileSale;
    }

    public void setMobileSale(WxMobileSale mobileSale) {
        this.mobileSale = mobileSale;
    }

    public List<WxMobileSale> getMobileSaleList() {
        return mobileSaleList;
    }

    public void setMobileSaleList(List<WxMobileSale> mobileSaleList) {
        this.mobileSaleList = mobileSaleList;
    }

    public MessageVo getMessageVo() {
        return messageVo;
    }

    public void setMessageVo(MessageVo messageVo) {
        this.messageVo = messageVo;
    }

    public String getShareDesc1() {
        return shareDesc1;
    }

    public void setShareDesc1(String shareDesc1) {
        this.shareDesc1 = shareDesc1;
    }

    public Integer getHasSale() {
        return hasSale;
    }

    public void setHasSale(Integer hasSale) {
        this.hasSale = hasSale;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getRedirectURL() {
        return redirectURL;
    }

    public void setRedirectURL(String redirectURL) {
        this.redirectURL = redirectURL;
    }

    public Qr getQr() {
        return qr;
    }

    public void setQr(Qr qr) {
        this.qr = qr;
    }
}

