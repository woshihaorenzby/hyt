package com.xuri.main.wxMobileSale.action;

import com.xuri.main.video.service.VideoService;
import com.xuri.main.wx.utils.GetWxOrderno;
import com.xuri.system.service.BaseService;
import com.xuri.util.*;
import com.xuri.vo.*;
import org.springframework.beans.factory.annotation.Autowired;

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


    @Autowired
    private BaseService baseService;
    @Autowired
    private VideoService videoService;

    public String wxShow() {
        return "show";
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
                if(law.contains("中间")){

                }
                String l = GetWxOrderno.extractEn(law);

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
            System.out.println("我是好人");
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

}

