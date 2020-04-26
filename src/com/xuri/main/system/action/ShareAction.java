package com.xuri.main.system.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.main.system.service.ShareService;
import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import com.xuri.vo.Share;

/**
 * @Title: ShareAction
 * @Description: TODO 分享
 */
public class ShareAction extends BaseAction {

    private static final long serialVersionUID = 4005569440552492024L;
    private Share share;
    private List<Share> shareList;
    private Page page;
    private MessageVo messageVo = new MessageVo();

    @Autowired
    private BaseService baseService;
    @Autowired
    private ShareService shareService;

    /**
     * @Description: TODO 分享列表
     */
    public String list() {
        try {
            share = new Share();
            share.setUserId(request.getSession().getAttribute("id").toString());
            page = baseService.selectPageList(page, share);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "page";
    }

    /**
     * @Description: TODO 保存
     */
    public String wxSave() {
        try {
            if (share.getUserId()!=null && share.getUserId().length()>0) {//说明登录了，才会有分享记录
                shareService.insertShare(share);
                messageVo.setCode("1");
            } else {
                messageVo.setCode("0");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }
    /**
     * @Description: TODO 点击量
     */
    public String wxShareDelete() {
        try {
            if (share.getId()!=null && share.getId().length()>0) {
                baseService.delete(share);
                messageVo.setCode("1");
            } else {
                messageVo.setCode("0");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }
    /**
     * @Description: TODO 点击量
     */
    public String wxShareView() {
        try {
            if (share.getUserId()!=null && share.getUserId().length()>0) {
                share.setViewNum("1");
                baseService.update(share);
                messageVo.setCode("1");
            } else {
                messageVo.setCode("0");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    public MessageVo getMessageVo() {
        return messageVo;
    }

    public void setMessageVo(MessageVo messageVo) {
        this.messageVo = messageVo;
    }

    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

    public Share getShare() {
        return share;
    }

    public void setShare(Share share) {
        this.share = share;
    }

    public List<Share> getShareList() {
        return shareList;
    }

    public void setShareList(List<Share> shareList) {
        this.shareList = shareList;
    }
}
