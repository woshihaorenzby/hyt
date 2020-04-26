package com.xuri.main.video.action;

import java.util.List;

import com.xuri.util.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.main.video.service.VideoService;
import com.xuri.system.service.BaseService;
import com.xuri.vo.Adv;
import com.xuri.vo.HyView;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import com.xuri.vo.Type;
import com.xuri.vo.User;
import com.xuri.vo.Video;
import com.xuri.vo.WxSign;

/**
 * @author 黄森泽
 * @Title: VideoAction
 * @Description: TODO 视频列表
 * @date 2016-4-25
 */
public class VideoAction extends BaseAction {

    private static final long serialVersionUID = 8109868459302222569L;
    private Video video;
    private Page page;
    private List<Type> typeList;
    private Adv adv;
    private User user;
    private WxSign wxSign;
    private HyView hyView;
    private String share;
    private List<Video> videoList;
    private String typeName;//1：跳转指定分类
    private MessageVo messageVo = new MessageVo();
    private String userId;
    private String shareDesc;

    @Autowired
    private BaseService baseService;
    @Autowired
    private VideoService videoService;

    public String show() {
        return "show";
    }

    public String editPage() {
        try {
            Type type = new Type();
            type.setTypeLei("1");
            typeList = baseService.selectList(type);
            if (video.getId() != null && video.getId().length() > 0) {
                video = baseService.selectById(video);
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
			/*String syInsert = "";
			if(getSession().getAttribute("syInsert") != null) {//防止空指针
				syInsert = getSession().getAttribute("syInsert").toString();
			}
			if(syInsert.equals("0")) {
				video.setSyInsert(syInsert);
				video.setUserId(getSession().getAttribute("id").toString());
			}*/
            if (video.getSyInsert().equals("0")) {
                video.setUserId(getSession().getAttribute("id").toString());
            }
            page = baseService.selectPageList(page, video);
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
            if (video.getId() == null || video.getId().length() == 0) {
                video.setSyInsert(getSession().getAttribute("syInsert").toString());
                video.setUserId(getSession().getAttribute("userId").toString());
                baseService.insert(video);
            } else {
                baseService.update(video);
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
            baseService.delete(video);
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 显示视频界面
     * @author 王东
     */
    public String wxVideo() {
        try {
            Type type = new Type();
            type.setTypeLei("1");
            typeList = baseService.selectList(type);//查询类别
            user = new User();
            user.setId(getSession().getAttribute("id").toString());
            user = baseService.selectById(user);//查询最新的用户信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxVideo";
    }

    /**
     * @Author wangd
     * @Description TODO 微信首页显示列表
     * @Date 2019/5/23 22:45
     * @Param video.typeName 分类名称
     * @Return java.lang.String
     **/
    public String wxVideoMainList() {
        try {
            if (video == null) video = new Video();
            if (!StringUtils.isBlank(video.getTypeName())) page.setPageRecordCount(5);
            page = baseService.selectPageList(page, video);

            videoList = (List<Video>) page.getData();
            for (int i = 0, si = videoList.size(); i < si; i++) {
                videoList.get(i).setShowTime(DateUtil.dealTimeQian(videoList.get(i).getCreateTime()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "videoList";
    }

    /**
     * @Description: TODO 显示视频详情
     * @author 王东
     */
    public String wxVideoDetail() {
        try {
            wxSign = WxUtil.sign(HttpUtil.getUrl(request));

            if (share == null || share.equals("0")) {//不是分享的，根据session的用户id查询广告
                userId = request.getSession().getAttribute("id").toString();
            } else {//分享的根据分享人id查询
                userId = user.getId();
            }
            video = baseService.selectById(video);
            if(video!=null) {
                String artCon = video.getArticleContent();
                if(artCon!=null && artCon.length()>100) {
                    artCon = artCon.substring(0, 100);
                }
                shareDesc = Html2Text.getContent(artCon);
                shareDesc = shareDesc.replaceAll(" ", "");
                shareDesc = shareDesc.replaceAll("　", "");
                shareDesc = shareDesc.trim();
                if(shareDesc.length()>15) {
                    shareDesc = shareDesc.substring(0, 15) + "...";
                }
            }
            adv = new Adv();
            adv.setUseTag("1");
            adv.setUserId(userId);
            adv = baseService.selectById(adv);//查询广告
            user = new User();
            user.setId(userId);
            user = baseService.selectById(user);//查询最新的用户信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxVideoDetail";
    }

    /**
     * @Description: TODO 累积访问量
     * @author 王东
     */
    public String wxVideoView() {
        try {
            videoService.insertVideoView(hyView);
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

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public MessageVo getMessageVo() {
        return messageVo;
    }

    public void setMessageVo(MessageVo messageVo) {
        this.messageVo = messageVo;
    }

    public List<Type> getTypeList() {
        return typeList;
    }

    public void setTypeList(List<Type> typeList) {
        this.typeList = typeList;
    }

    public Adv getAdv() {
        return adv;
    }

    public void setAdv(Adv adv) {
        this.adv = adv;
    }

    public WxSign getWxSign() {
        return wxSign;
    }

    public void setWxSign(WxSign wxSign) {
        this.wxSign = wxSign;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public HyView getHyView() {
        return hyView;
    }

    public void setHyView(HyView hyView) {
        this.hyView = hyView;
    }

    public String getShare() {
        return share;
    }

    public void setShare(String share) {
        this.share = share;
    }

    public List<Video> getVideoList() {
        return videoList;
    }

    public void setVideoList(List<Video> videoList) {
        this.videoList = videoList;
    }

    public String getTypeName() {
        return typeName == null ? "" : typeName.trim();
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getShareDesc() {
        return shareDesc;
    }

    public void setShareDesc(String shareDesc) {
        this.shareDesc = shareDesc;
    }
}
