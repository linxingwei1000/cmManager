package cm.lx.controller.administration;

import cm.lx.bean.entity.Wages;
import cm.lx.controller.BaseController;
import cm.lx.bean.entity.WagesAssist;
import cm.lx.service.WagesAssistService;
import cm.lx.service.WagesService;
import cm.lx.util.TimeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * 工资管理
 *
 * @author linxingwei
 * @date 2018/12/27
 */
@Controller
public class WagesController extends BaseController {

    @Resource
    WagesService wagesService;

    @Resource
    WagesAssistService wagesAssistService;

    List<Wages> list = new ArrayList<>();

    @RequestMapping(value = "/userWagesView")
    public ModelAndView listUser(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("wages/list");
        mav.addObject(DATA, null);
        mav.addObject(TIP, session.getAttribute("tip"));
        return mav;
    }

    @RequestMapping(value = "/userWagesSearch")
    public ModelAndView userWagesSearch(
            @RequestParam(value = "searchKey", required = false, defaultValue = "") String searchKey,
            @RequestParam(value = "searchValue", required = false, defaultValue = "") String searchValue) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("wages/list");
        mav.addObject("searchKey", searchKey);
        mav.addObject("searchValue", searchValue);

        if (searchKey.equals("staff")) {
            list = wagesService.getWagesByStaffAndMonth(searchValue, null);
        } else if (searchKey.equals("payMonth")) {
            list = wagesService.getWagesByStaffAndMonth(null, searchValue);
        }

        mav.addObject(DATA, list);
        return mav;
    }


    @RequestMapping(value = "/userWagesAction", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView userWagesAction(
            @RequestParam(value = "action", required = true, defaultValue = "") Integer action,
            @RequestParam(value = "over", required = false, defaultValue = "") Integer over,
            @RequestParam(value = "id", required = false, defaultValue = "") Integer id,
            @RequestParam(value = "staff", required = false, defaultValue = "") String staff,
            @RequestParam(value = "stime", required = false, defaultValue = "") String stime,
            @RequestParam(value = "etime", required = false, defaultValue = "") String etime,
            @RequestParam(value = "soldDate", required = false, defaultValue = "") String soldDate,
            @RequestParam(value = "basePay", required = false, defaultValue = "") Double basePay,
            @RequestParam(value = "compassionateLeave", required = false, defaultValue = "") Double compassionateLeave,
            @RequestParam(value = "late", required = false, defaultValue = "") Double late,
            @RequestParam(value = "unHitCard", required = false, defaultValue = "") Double unHitCard,
            @RequestParam(value = "qualityCommission", required = false, defaultValue = "") Double qualityCommission,
            @RequestParam(value = "authCommission", required = false, defaultValue = "") Double authCommission,
            @RequestParam(value = "depositCommission", required = false, defaultValue = "") Double depositCommission,
            @RequestParam(value = "billCommission", required = false, defaultValue = "") Double billCommission,
            @RequestParam(value = "insuranceCommission", required = false, defaultValue = "") Double insuranceCommission,
            @RequestParam(value = "newCarCommission", required = false, defaultValue = "") Double newCarCommission,
            @RequestParam(value = "mealSupplement", required = false, defaultValue = "") Double mealSupplement,
            @RequestParam(value = "otherSupplement", required = false, defaultValue = "") Double otherSupplement) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("wages/add");
        mav.addObject("action", action);

        mav.addObject("staff", staff);
        mav.addObject("stime", stime);
        mav.addObject("etime", etime);
        mav.addObject("soldDate", soldDate);
        mav.addObject("basePay", basePay);
        mav.addObject("compassionateLeave", compassionateLeave);
        mav.addObject("late", late);
        mav.addObject("unHitCard", unHitCard);
        mav.addObject("qualityCommission", qualityCommission);
        mav.addObject("authCommission", authCommission);
        mav.addObject("depositCommission", depositCommission);
        mav.addObject("billCommission", billCommission);
        mav.addObject("insuranceCommission", insuranceCommission);
        mav.addObject("newCarCommission", newCarCommission);
        mav.addObject("mealSupplement", mealSupplement);
        mav.addObject("otherSupplement", otherSupplement);

        if (over == null) {
            if (id != null) {
                Wages wages = wagesService.getWagesById(id);
                mav.addObject("id", id);
                mav.addObject("staff", wages.getStaff());
                mav.addObject("stime", wages.getStime());
                mav.addObject("etime", wages.getEtime());
                mav.addObject("soldDate", wages.getSoldTime());
                mav.addObject("basePay", wages.getBasePay());
                mav.addObject("compassionateLeave", wages.getCompassionateLeave());
                mav.addObject("late", wages.getLate());
                mav.addObject("unHitCard", wages.getUnHitCard());
                mav.addObject("qualityCommission", wages.getQualityCommission());
                mav.addObject("authCommission", wages.getAuthCommission());
                mav.addObject("depositCommission", wages.getDepositCommission());
                mav.addObject("billCommission", wages.getBillCommission());
                mav.addObject("insuranceCommission", wages.getInsuranceCommission());
                mav.addObject("newCarCommission", wages.getNewCarCommission());
                mav.addObject("mealSupplement", wages.getMealSupplement());
                mav.addObject("otherSupplement", wages.getOtherSupplement());
            }
            return mav;
        } else {
            if (StringUtils.isEmpty(staff)) {
                mav.addObject(TIP, "员工必填！");
                return mav;
            }
            if (StringUtils.isEmpty(stime)) {
                mav.addObject(TIP, "销售开始时间必填！");
                return mav;
            }
            if (StringUtils.isEmpty(etime)) {
                mav.addObject(TIP, "销售结束时间必填！");
                return mav;
            }
            if (StringUtils.isEmpty(soldDate)) {
                mav.addObject(TIP, "转已售截至时间必填！");
                return mav;
            }
            String payMonth = stime.substring(0, 7).replace("-", "年") + "月";

            List<Wages> list = wagesService.getWagesByStaffAndMonth(staff, payMonth);
            if (list.size() != 0) {
                //说明也有当前月份工资，创建改修改
                id = list.get(0).getId();
                action = MOD_ACTION;
            }

            Wages wages = new Wages();
            wages.setStaff(staff);
            wages.setPayMonth(payMonth);
            wages.setBasePay(basePay == null ? 0 : basePay);
            wages.setCompassionateLeave(compassionateLeave == null ? 0 : compassionateLeave);
            wages.setLate(late == null ? 0 : late);
            wages.setUnHitCard(unHitCard == null ? 0 : unHitCard);
            wages.setQualityCommission(qualityCommission == null ? 0 : qualityCommission);
            wages.setAuthCommission(authCommission == null ? 0 : authCommission);
            wages.setDepositCommission(depositCommission == null ? 0 : depositCommission);
            wages.setBillCommission(billCommission == null ? 0 : billCommission);
            wages.setInsuranceCommission(insuranceCommission == null ? 0 : insuranceCommission);
            wages.setNewCarCommission(newCarCommission == null ? 0 : newCarCommission);
            wages.setMealSupplement(mealSupplement == null ? 0 : mealSupplement);
            wages.setOtherSupplement(otherSupplement == null ? 0 : otherSupplement);
            wages.setStime(stime);
            wages.setEtime(etime);
            wages.setSoldTime(soldDate);
            //计算采购提成
            calculate(stime, etime, soldDate, wages);

            mav.clear();
            if (action.equals(CREATE_ACTION)) {
                wagesService.create(wages);
                mav.addObject(TIP, "ok " + staff + "工资录入成功！");
            } else if (action.equals(MOD_ACTION)) {
                wages.setId(id);
                wagesService.updateWages(wages);
                mav.addObject(TIP, "ok " + staff + "工资修改成功！");
            }
            mav.setViewName("wages/list");
            mav.addObject(DATA, wagesService.getWagesByStaffAndMonth(staff, null));
            return mav;
        }
    }

    @RequestMapping(value = "/userWagesDelete", method = RequestMethod.GET)
    public ModelAndView userWagesDelete(
            @RequestParam(value = "id", required = false, defaultValue = "") Integer id) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("wages/list");

        wagesService.deleteById(id);
        for (Wages wages : list) {
            if (wages.getId().equals(id)) {
                list.remove(wages);
                break;
            }
        }
        mav.addObject(TIP, "ok 删除工资成功！");
        mav.addObject(DATA, list);
        return mav;
    }

    private void calculate(String stime, String etime, String soldDate, Wages wages) {
        Long st = TimeUtils.transformDateToTimetag(stime, TimeUtils.FORMAT_ONE);
        Long et = TimeUtils.transformDateToTimetag(etime, TimeUtils.FORMAT_ONE) + 24 * 60 * 60 * 1000;
        Long soldt = TimeUtils.transformDateToTimetag(soldDate, TimeUtils.FORMAT_ONE);

        List<WagesAssist> list = wagesAssistService.getWagesAssistByTime(st, et, soldt);

        Double carCommission = 0.0;
        Double purchaseCommission = 0.0;
        Double shareDividends = 0.0;

        for (WagesAssist wagesAssist : list) {
            if (wagesAssist.getSalePerson().equals(wages.getStaff())) {
                carCommission += wagesAssist.getCarCommission();
            }
            if (wagesAssist.getPurchasePerson().equals(wages.getStaff())) {
                purchaseCommission += wagesAssist.getPurchaseCommission();
            }
            if (wagesAssist.getInsidePerson().equals(wages.getStaff())) {
                shareDividends += wagesAssist.getShareDividends();
            }
        }
        wages.setCarCommission(carCommission);
        wages.setPurchaseCommission(purchaseCommission);
        wages.setShareDividends(shareDividends);
        wages.calculateWages();
    }
}
