package com.xuri.main.user.action;

import com.xuri.main.Constant;
import com.xuri.main.system.service.NoticeService;
import com.xuri.main.user.service.WxUserService;
import com.xuri.system.service.BaseService;
import com.xuri.util.*;
import com.xuri.vo.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @author 王东
 * @Title: UserAction
 * @Description: TODO 用户管理
 * @date 2016-4-6
 */
public class UserAction extends BaseAction {

    private static final long serialVersionUID = 1300687846998086099L;
    private User user;
    private Page page;
    private int companyMemCount;//公司成员数量
    private WxQcTicket ticket;
    private List<Lunimg> lunimgList;
    private HyUserStat hyUserStat;
    private List<HyUserStat> userStatList;
    private Notice notice;
    private String msgcode;
    private int userNumOne;//查询一级用户数量
    private int userNumTwo;//查询二级用户数量
    private String userNextTag;//1是说明查询一级用户，2是查询二级用户
    private String memLevel;//会员等级
    private WxSign wxSign;
    private FanOrder fanOrder;
    private int oneFanMoney;//一级返利金额
    private int twoFanMoney;//二级返利金额
    private int totTiMoney;//查询总的提现金额
    private TiOrder tiOrder;
    private HySystem hySystem;
    private MessageVo messageVo = new MessageVo();
    private List<Type> typeList;
    private List<Share> shareList;
    private int totShare;
    private int totView;
    private int totZhuan;

    @Autowired
    private BaseService baseService;
    @Autowired
    private WxUserService userService;
    @Autowired
    private NoticeService noticeService;

    public String show() {
        return "show";
    }

    /**
     * @Description: TODO 用户列表
     * @author 王东
     */
    public String list() {
        try {
            if (user == null) user = new User();
            if (user.getJoinCompany() != null && user.getJoinCompany().equals("1")) {
                user.setPcomId(getSession().getAttribute("id").toString());
            }
            page = baseService.selectPageList(page, user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "page";
    }

    /**
     * @Description: TODO 保存用户信息
     * @author 王东
     */
    public String save() {
        try {
            user.setId(request.getSession().getAttribute("id").toString());
            baseService.update(user);
            messageVo.setCode("1");
        } catch (Exception e) {
            messageVo.setCode("0");
            e.printStackTrace();
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 显示用户协议界面
     * @author 王东
     */
    public String showXieYi() {
        hySystem = new HySystem();
        hySystem.setId("1");
        try {
            hySystem = baseService.selectById(hySystem);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "showXieYi";
    }

    /**
     * @Description: TODO 保存用户协议
     * @author 王东
     */
    public String saveXieYi() {
        try {
            hySystem.setId("1");
            baseService.update(hySystem);
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 显示用户协议界面
     * @author 王东
     */
    public String showOper() {
        hySystem = new HySystem();
        hySystem.setId("1");
        try {
            hySystem = baseService.selectById(hySystem);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "showOper";
    }

    /**
     * @Description: TODO 公司信息
     * @author 王东
     */
    public String companyShow() {
        user = new User();
        user.setPid(getSession().getAttribute("userId").toString());
        user.setJoinCompany("1");
        try {
            companyMemCount = baseService.selectCount(user);
        } catch (Exception e) {
            e.printStackTrace();
            companyMemCount = 0;
        }
        return "companyShow";
    }

    /**
     * @Description: TODO 保存公司信息
     * @author 王东
     */
    public String saveCompanyInf() {
        try {
            user.setId(getSession().getAttribute("userId").toString());//后台登录取得session的用户ID
            baseService.update(user);
            getSession().setAttribute("companyName", user.getCompanyName());
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 显示企业成员界面
     * @author 王东
     */
    public String companyMem() {
        return "companyMem";
    }

    public String deleteMem() {
        try {
            user.setJoinCompany("0");
            baseService.update(user);
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 显示用户统计界面
     * @author 王东
     */
    public String userStat() {
        return "userStat";
    }

    /**
     * @Description: TODO 统计数据
     * @author 王东
     */
    public String userStatData() {
        try {
            userStatList = baseService.selectList(hyUserStat);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "userStatList";
    }

    /**
     * @Description: TODO 微信用户登录跳转首页
     * @author 王东
     */
    public String wxIndex() {
        try {
//            getSession().setAttribute("id", "62");
//
//            if (getSession().getAttribute("id") == null) {// 判断没有登录
//                user = userService.selectWxLogin(request);
//            } else {
//                user = new User();
//                user.setId(getSession().getAttribute("id").toString());
//                user = baseService.selectById(user);
//                baseService.updateCustom("updateUserLogin", user);
//            }
//            if (user != null) {
//                getSession().setAttribute("id", user.getId());
//                getSession().setAttribute("pid", user.getPid());
//                getSession().setAttribute("openId", user.getOpenId());
//                getSession().setAttribute("niName", user.getNiName());
//                getSession().setAttribute("headimgurl", user.getHeadimgurl());
//                getSession().setAttribute("point", user.getPoint());
//                getSession().setAttribute("advShow", user.getAdvShow());
//                getSession().setAttribute("advClick", user.getAdvClick());
//            } else {
//                user = userService.selectWxLogin(request);
//
//                getSession().setAttribute("id", user.getId());
//                getSession().setAttribute("pid", user.getPid());
//                getSession().setAttribute("openId", user.getOpenId());
//                getSession().setAttribute("niName", user.getNiName());
//                getSession().setAttribute("headimgurl", user.getHeadimgurl());
//                getSession().setAttribute("point", user.getPoint());
//                getSession().setAttribute("advShow", user.getAdvShow());
//                getSession().setAttribute("advClick", user.getAdvClick());
//            }
//
            Lunimg lunimg = new Lunimg();
            lunimg.setDisplay("1");
            lunimgList = baseService.selectList(lunimg);
            //notice = noticeService.selectTopNotice();
            Type ty = new Type();
            ty.setTypeLei("1");
            ty.setTopShow("1");
            typeList = baseService.selectList(ty);
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
        return "wxIndex";
    }

    /**
     * @Description: TODO 首页分类
     * @author 王东
     */
    public String wxIndexType() {
        try {
            Type ty = new Type();
            ty.setTypeLei("1");
            ty.setTopShow("1");
            typeList = baseService.selectList(ty);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "typeList";
    }

    /**
     * @Description: TODO 我的
     * @author 王东
     */
    public String wxMine() {
        String id = request.getSession().getAttribute("id").toString();
        user = new User();
        user.setId(id);
        try {
            user = baseService.selectById(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxMine";
    }

    /**
     * @Description: TODO 短信验证
     * @author 王东
     */
    public String wxBind() {
        return "wxBind";
    }

    /**
     * @Description: TODO 发送短信验证码
     * @author 王东
     */
    public String wxSendMsg() {
        String checkCode = NumUtil.checkCode();
        try {
            User seUser = baseService.selectById(user);//验证电话号码是否重复
            if (seUser != null) {
                messageVo.setCode("2");
            } else {
                SendMsg.sendMsg(user.getPhone(), "您好,你的验证码:" + checkCode + "【选号网】");
                request.getSession().setAttribute("phone", user.getPhone());
                request.getSession().setAttribute("msgcode", checkCode);
                messageVo.setCode("1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 验证手机
     * @author 王东
     */
    public String wxCheckPhone() {
        try {
            if (request.getSession().getAttribute("msgcode").toString().equals(msgcode)) {
                user = new User();
                user.setId(request.getSession().getAttribute("id").toString());
                user.setPhone(request.getSession().getAttribute("phone").toString());
                user.setIscheck("1");
                baseService.update(user);
                messageVo.setCode("1");
            } else {
                messageVo.setCode("2");//验证码输入有误
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 微名片
     * @author 王东
     */
    public String wxCard() {
        try {
            user = new User();
            user.setId(getSession().getAttribute("id").toString());
            user = baseService.selectById(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxCard";
    }

    /**
     * @Description: TODO 编辑微信名片
     * @author 王东
     */
    public String wxEditCard() {
        try {
            user = new User();
            user.setId(getSession().getAttribute("id").toString());
            user = baseService.selectById(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxEditCard";
    }

    /**
     * @Description: TODO 显示微名片
     * @author 王东
     */
    public String wxShowCard() {
        try {
            user = baseService.selectById(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxShowCard";
    }

    /**
     * @Description: TODO 会员升级
     * @author 王东
     */
    public String wxMemberup() {
        wxSign = WxUtil.sign(HttpUtil.getUrl(request));

        return "wxMemberup";
    }

    /**
     * @Description: TODO 推广海报
     * @author 王东
     */
    public String wxTuiGuang() {
        wxSign = WxUtil.sign(HttpUtil.getUrl(request));
        ticket = WxUtil.linQRCode(user.getId());
        try {
            user = baseService.selectById(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxTuiGuang";
    }

    /**
     * @Description: TODO 显示粉丝
     * @author 王东
     */
    public String wxFans() {
        user = new User();
        user.setPid(request.getSession().getAttribute("id").toString());
        try {
            userNumOne = userService.selectNextNextUserCount(user);
            List<User> userList = userService.selectNextNextUserList(user);
            String nid = "";
            if (userList != null && userList.size() > 0) {
                for (int i = 0; i < userList.size(); i++) {
                    nid += userList.get(i).getId() + ",";
                }
            }
            if (nid.length() > 0) {
                nid = nid.substring(0, nid.length() - 1);
            } else {
                nid = "100000000000000";
            }
            user.setPid(nid);
            userNumTwo = userService.selectNextNextUserCount(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxFans";
    }

    /**
     * @Description: TODO 查询粉丝用户
     * @author 王东
     */
    public String wxNextUser() {
        try {
            user = new User();
            user.setPid(request.getSession().getAttribute("id").toString());
            if (userNextTag.equals("2")) {
                List<User> userList = userService.selectNextNextUserList(user);
                String pid = "";
                for (int i = 0; i < userList.size(); i++) {
                    pid += userList.get(i).getId() + ",";
                }
                if (pid.length() > 0) {
                    pid = pid.substring(0, pid.length() - 1);
                } else {
                    pid = "100000000000000";
                }
                user.setPid(pid);
            }
            page = baseService.selectPageList(page, user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "page";
    }

    /**
     * @Description: TODO 查看收入
     * @author 王东
     */
    public String wxDeposit() {
        try {
            user = new User();
            user.setId(getSession().getAttribute("id").toString());
            user = baseService.selectById(user);//查询最新的用户信息
            fanOrder = new FanOrder();
            fanOrder.setFanType("1");
            fanOrder.setToUserId(user.getId());
            oneFanMoney = userService.selectTotFanMoney(fanOrder);//一级返利总额
            fanOrder.setFanType("2");
            twoFanMoney = userService.selectTotFanMoney(fanOrder);//二级返利总额
            totTiMoney = userService.selectTotalTiMoney(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxDeposit";
    }

    /**
     * @Description: TODO 查看收入记录
     * @author 王东
     */
    public String wxDepositOrder() {
        try {
            fanOrder.setToUserId(getSession().getAttribute("id").toString());
            page = baseService.selectPageList(page, fanOrder);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "page";
    }

    /**
     * @Description: TODO 查看提现记录
     * @author 王东
     */
    public String wxTiOrder() {
        try {
            TiOrder tiOrder = new TiOrder();
            tiOrder.setUserId(getSession().getAttribute("id").toString());
            page = baseService.selectPageList(page, tiOrder);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "page";
    }

    /**
     * @Description: TODO 提现
     * @author 王东
     */
    public String wxTiXian() {
        try {
            tiOrder.setUserId(getSession().getAttribute("id").toString());
            userService.insertTiXian(tiOrder);
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 分享记录
     * @author 王东
     */
    public String wxShareOrder() {
        return "wxShareOrder";
    }

    /**
     * @Description: TODO 公司群组
     * @author 王东
     */
    public String wxCompanyGroup() {
        wxSign = WxUtil.sign(HttpUtil.getUrl(request));
        user = new User();
        user.setId(getSession().getAttribute("id").toString());
        try {
            user = baseService.selectById(user);
            user.setYaoCode(EncryptUtil.encrypt(user.getId()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxCompanyGroup";
    }

    /**
     * @Description: TODO 邀请加入企业群组
     * @author 王东
     */
    public String wxCompanyShare() {
        try {
            messageVo = userService.insertCompanyZhu(request);
            user = new User();
            user.setId(messageVo.getId());
            user = baseService.selectById(user);
            if (messageVo.getCode().equals("1")) {
                messageVo.setMessage("恭喜，你已成功加入群组[" + user.getCompanyName() + "]");
            } else if (messageVo.getCode().equals("2")) {
                messageVo.setMessage("群组[" + user.getCompanyName() + "]人数已到达上线，无法加入");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxCompanyShare";
    }

    /**
     * @Description: TODO 显示积分机制界面
     * @author 王东
     */
    public String wxCodeJi() {
        return "wxCodeJi";
    }

    /**
     * @Description: TODO 显示用户协议
     * @author 王东
     */
    public String wxUserXie() {
        hySystem = new HySystem();
        hySystem.setId("1");
        try {
            hySystem = baseService.selectById(hySystem);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxUserXie";
    }

    /**
     * @Description: TODO 联系上级
     * @author 王东
     */
    public String wxConShang() {
        try {
            if (getSession().getAttribute("pid") != null) {
                user = new User();
                user.setId(getSession().getAttribute("pid").toString());
                user = baseService.selectById(user);
            } else {
                user = new User();
                user.setHeadimgurl(Constant.domain + "/images/user.png");
                user.setNiName("选号网平台");
                user.setMpJob("总经理");
                user.setMpPhone("13798577087");
                user.setMpWxcode("");
                user.setMpEmail("");
                user.setMpCompany("0755-82556962");
                user.setMpClick("0");
                user.setMpShare("0");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxConShang";
    }

    public String wxUserRelease() {
        try {
            Share share = new Share();
            share.setUserId(getSession().getAttribute("id").toString());
            shareList = baseService.selectList(share);
            if (shareList != null) {
                for (int i = 0; i < shareList.size(); i++) {
                    totShare += Integer.parseInt(shareList.get(i).getShareNum());
                    totView += Integer.parseInt(shareList.get(i).getViewNum());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxUserRelease";
    }

    public String wxUserHuo() {
        try {

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxUserHuo";
    }

    public String wxUserShareNear() {
        try {
            shareList = baseService.selectCustomList("selectShareNear", new Share());
            if(shareList!=null && shareList.size()>0) {
                for(int i=0; i<shareList.size(); i++) {
                    String niName = shareList.get(i).getNiName();
                    if(niName.length()>5) {
                        niName = niName.substring(0, 5) + "*";
                    }
                    shareList.get(i).setNiName(niName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shareList";
    }

    public String wxOper() {
        try {
            hySystem = new HySystem();
            hySystem.setId("1");
            try {
                hySystem = baseService.selectById(hySystem);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxOper";
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

    public WxQcTicket getTicket() {
        return ticket;
    }

    public void setTicket(WxQcTicket ticket) {
        this.ticket = ticket;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Lunimg> getLunimgList() {
        return lunimgList;
    }

    public void setLunimgList(List<Lunimg> lunimgList) {
        this.lunimgList = lunimgList;
    }

    public Notice getNotice() {
        return notice;
    }

    public void setNotice(Notice notice) {
        this.notice = notice;
    }

    public int getUserNumOne() {
        return userNumOne;
    }

    public void setUserNumOne(int userNumOne) {
        this.userNumOne = userNumOne;
    }

    public int getUserNumTwo() {
        return userNumTwo;
    }

    public void setUserNumTwo(int userNumTwo) {
        this.userNumTwo = userNumTwo;
    }

    public String getMsgcode() {
        return msgcode;
    }

    public void setMsgcode(String msgcode) {
        this.msgcode = msgcode;
    }

    public WxSign getWxSign() {
        return wxSign;
    }

    public void setWxSign(WxSign wxSign) {
        this.wxSign = wxSign;
    }

    public String getUserNextTag() {
        return userNextTag;
    }

    public void setUserNextTag(String userNextTag) {
        this.userNextTag = userNextTag;
    }

    public FanOrder getFanOrder() {
        return fanOrder;
    }

    public void setFanOrder(FanOrder fanOrder) {
        this.fanOrder = fanOrder;
    }

    public int getTotTiMoney() {
        return totTiMoney;
    }

    public void setTotTiMoney(int totTiMoney) {
        this.totTiMoney = totTiMoney;
    }

    public int getOneFanMoney() {
        return oneFanMoney;
    }

    public void setOneFanMoney(int oneFanMoney) {
        this.oneFanMoney = oneFanMoney;
    }

    public int getTwoFanMoney() {
        return twoFanMoney;
    }

    public void setTwoFanMoney(int twoFanMoney) {
        this.twoFanMoney = twoFanMoney;
    }

    public HySystem getHySystem() {
        return hySystem;
    }

    public void setHySystem(HySystem hySystem) {
        this.hySystem = hySystem;
    }

    public String getMemLevel() {
        return memLevel;
    }

    public void setMemLevel(String memLevel) {
        this.memLevel = memLevel;
    }

    public TiOrder getTiOrder() {
        return tiOrder;
    }

    public void setTiOrder(TiOrder tiOrder) {
        this.tiOrder = tiOrder;
    }

    public int getCompanyMemCount() {
        return companyMemCount;
    }

    public void setCompanyMemCount(int companyMemCount) {
        this.companyMemCount = companyMemCount;
    }

    public List<HyUserStat> getUserStatList() {
        return userStatList;
    }

    public void setUserStatList(List<HyUserStat> userStatList) {
        this.userStatList = userStatList;
    }

    public HyUserStat getHyUserStat() {
        return hyUserStat;
    }

    public void setHyUserStat(HyUserStat hyUserStat) {
        this.hyUserStat = hyUserStat;
    }

    public List<Type> getTypeList() {
        return typeList;
    }

    public void setTypeList(List<Type> typeList) {
        this.typeList = typeList;
    }

    public List<Share> getShareList() {
        return shareList;
    }

    public void setShareList(List<Share> shareList) {
        this.shareList = shareList;
    }

    public int getTotShare() {
        return totShare;
    }

    public void setTotShare(int totShare) {
        this.totShare = totShare;
    }

    public int getTotView() {
        return totView;
    }

    public void setTotView(int totView) {
        this.totView = totView;
    }

    public int getTotZhuan() {
        return totZhuan;
    }

    public void setTotZhuan(int totZhuan) {
        this.totZhuan = totZhuan;
    }
}
