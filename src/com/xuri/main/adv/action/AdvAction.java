package com.xuri.main.adv.action;

import java.io.File;
import java.util.List;

import com.xuri.vo.*;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.main.adv.service.AdvService;
import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.util.DateUtil;
import com.xuri.util.HttpUtil;
import com.xuri.util.ImageUtils;
import com.xuri.util.WxUtil;

/**
 * @Title: AdvAction
 * @Description: TODO 广告
 * @date 2016-4-28
 */
public class AdvAction extends BaseAction {
    private static final long serialVersionUID = 8109868459302222569L;
    private Adv adv;
    private AdvMod advMod;
    private List<Adv> advList;
    private List<Type> typeList;
    private List<AdvMod> advModList;
    private WxSign wxSign;
    private User user;
    private HyView hyView;
    private CutImg cutImg;
    private String advType;
    private MessageVo messageVo = new MessageVo();
    private Page page;

    @Autowired
    private BaseService baseService;
    @Autowired
    private AdvService advService;


    public String showMod() {
        try {
            Type type = new Type();
            type.setTypeLei("3");
            typeList = baseService.selectList(type);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "showMod";
    }

    /**
     * @Description: TODO 类别列表
     * @author 王东
     */
    public String modList() {
        try {
            if (advMod == null) advMod = new AdvMod();
            advModList = baseService.selectList(advMod);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "advModList";
    }

    public String saveMod() {
        try {
            if (advMod.getId() == null || advMod.getId().length() == 0) {
                baseService.insert(advMod);
            } else {
                baseService.update(advMod);
            }
            messageVo.setCode("1");
        } catch (Exception e) {
            messageVo.setCode("0");
            e.printStackTrace();
        }
        return "messageVo";
    }

    public String deleteMod() {
        try {
            if (advMod.getId() != null && advMod.getId().length() > 0) {
                baseService.delete(advMod);
            }
            messageVo.setCode("1");
        } catch (Exception e) {
            messageVo.setCode("0");
            e.printStackTrace();
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 微信广告设置界面
     */
    public String wxAdv() {
        Adv adv = new Adv();
        try {
            String userId = request.getSession().getAttribute("id").toString();
            adv.setUserId(userId);
            advList = baseService.selectList(adv);
            if (advList != null && advList.size() > 0) {
                for (int i = 0; i < advList.size(); i++) {
                    Adv advSel = advList.get(i);
                    advSel.setImagePath(advSel.getImagePath() + "?v=" + DateUtil.getRecentDate("yyyyMMddHHmmss"));
                    advList.set(i, advSel);
                }
            }
            user = new User();
            user.setId(userId);
            user = baseService.selectById(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxAdv";
    }

    /**
     * @Description: TODO 显示添加广告界面
     */
    public String wxAdvEdit() {
        wxSign = WxUtil.sign(HttpUtil.getUrl(request));
        try {
            if (adv != null && adv.getId() != null && adv.getId().length() > 0) {
                adv = baseService.selectById(adv);
                if (adv != null) {
                    adv.setImagePath(adv.getImagePath() + "?v=" + DateUtil.getRecentDate("yyyyMMddHHmmss"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxAdvEdit";
    }

    /**
     * @Description: TODO 保存
     * @author 王东
     */
    public String wxSave() {
        try {
            String imagePath = adv.getImagePath();
            if (imagePath != null && imagePath.indexOf("?v") > -1) {
                imagePath = imagePath.substring(0, imagePath.indexOf("?v"));
                adv.setImagePath(imagePath);
            }
            if (adv.getImagePath().indexOf("file") == -1) {//不是以file开头说明是用id换取微信图片
                String path = "/file/img/" + DateUtil.getRecentDate("yyyyMM") + "/";
                String curTime = DateUtil.getRecentDate("yyyyMMddHHmmss");
                File file = new File(ServletActionContext.getServletContext().getRealPath(path));
                if (!file.exists()) {
                    file.mkdirs();
                }
                String realpath = ServletActionContext.getServletContext().getRealPath(path) + curTime + ".jpg";
                WxUtil.downWxImg(adv.getImagePath(), realpath);
                adv.setImagePath(path + curTime + ".jpg");
            }
            adv.setUserId(request.getSession().getAttribute("id").toString());
            messageVo = advService.saveAdv(adv);
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 删除
     */
    public String wxDelete() {
        try {
            String userId = request.getSession().getAttribute("id").toString();
            adv.setUserId(userId);
            advService.deleteAdv(adv);
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 设置使用广告
     */
    public String wxSetAdvUse() {
        try {
            String userId = request.getSession().getAttribute("id").toString();
            adv.setUserId(userId);
            advService.updateAdvUse(adv);
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 设置使用个人广告
     */
    public String wxSetAdvMp() {
        try {
            user = new User();
            user.setId(request.getSession().getAttribute("id").toString());
            advService.updateAdvMp(user);
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
            messageVo.setCode("0");
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 图片剪切界面
     */
    public String wxCutImg() {
        try {
            adv = baseService.selectById(adv);
            if (adv != null) {
                adv.setImagePath(adv.getImagePath() + "?v=" + DateUtil.getRecentDate("yyyyMMddHHmmss"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "wxCutImg";
    }

    /**
     * @Description: TODO 处理图片剪切
     */
    public String wxDoCut() {
        try {
            adv = baseService.selectById(adv);

            String path = request.getRealPath("/");
            path = path.replace("\\", "/");
            path = path.substring(0, path.length() - 1);
            ImageUtils.cutImage(path + adv.getImagePath(), path + adv.getImagePath(), cutImg.getX(), cutImg.getY(), cutImg.getW(), cutImg.getH());
            messageVo.setCode("1");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "messageVo";
    }

    /**
     * @Description: TODO 设置广告点击量
     */
    public String wxAdvClick() {
        try {
            advService.insertAdvClick(user, hyView);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "messageVo";
    }


    public MessageVo getMessageVo() {
        return messageVo;
    }

    public void setMessageVo(MessageVo messageVo) {
        this.messageVo = messageVo;
    }

    public WxSign getWxSign() {
        return wxSign;
    }

    public void setWxSign(WxSign wxSign) {
        this.wxSign = wxSign;
    }

    public Adv getAdv() {
        return adv;
    }

    public void setAdv(Adv adv) {
        this.adv = adv;
    }

    public List<Adv> getAdvList() {
        return advList;
    }

    public void setAdvList(List<Adv> advList) {
        this.advList = advList;
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

    public CutImg getCutImg() {
        return cutImg;
    }

    public void setCutImg(CutImg cutImg) {
        this.cutImg = cutImg;
    }

    public List<Type> getTypeList() {
        return typeList;
    }

    public void setTypeList(List<Type> typeList) {
        this.typeList = typeList;
    }

    public AdvMod getAdvMod() {
        return advMod;
    }

    public void setAdvMod(AdvMod advMod) {
        this.advMod = advMod;
    }

    public List<AdvMod> getAdvModList() {
        return advModList;
    }

    public void setAdvModList(List<AdvMod> advModList) {
        this.advModList = advModList;
    }

    public String getAdvType() {
        return advType;
    }

    public void setAdvType(String advType) {
        this.advType = advType;
    }


}
