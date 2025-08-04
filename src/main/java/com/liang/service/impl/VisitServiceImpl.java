package com.liang.service.impl;

import com.liang.bean.Visit;
import com.liang.dao.VisitMapper;
import com.liang.service.VisitService;
import com.liang.utils.IpUtil;
import com.liang.utils.PageUtil;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class VisitServiceImpl implements VisitService {
    @Autowired
    VisitMapper visitMapper;
    @Autowired
    PageUtil pageUtil;
    @Autowired
    IpUtil ipUtil;

    // 管理系统-访问记录初始条数（第一页）
    private int adminVisitPageSize;

    @PostConstruct
    private void init() {
        adminVisitPageSize = pageUtil.getAdminVisitPageSize();
    }

    /**
     * 新增访问信息
     *
     * @param request
     */
    @Override
    public void setVisit(HttpServletRequest request) {
        // 解析ip
        Visit visit = ipUtil.getVisit(ipUtil.getIP(request), ipUtil.getOS(request));
        // 将访问信息添加到数据库
        visit.setVisitid(UUIDUtil.getRandomUUID());
        visitMapper.insert(visit);
    }

    /**
     * 查询访问信息（分页）
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    @Override
    public List<Visit> getVisit(int pageStart, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        if (pageStart == 1) {
            map.put("offset", (pageStart - 1) * pageSize);
        } else {
            map.put("offset", (pageStart - 2) * pageSize + adminVisitPageSize);
        }
        map.put("limit", pageSize);
        return visitMapper.selectVisitPaging(map);
    }

    /**
     * 统计-国家
     *
     * @return
     */
    @Override
    public List<Visit> visitCountryStatistic() {
        return visitMapper.selectVisitCountryStatistic();
    }

    /**
     * 统计-中国省份
     *
     * @return
     */
    @Override
    public List<Visit> visitProvinceStatistic() {
        List<Visit> visitList = visitMapper.selectVisitProvinceStatistic();
        for (int i = 0; i < visitList.size(); i++) {
            String province = visitList.get(i).getVisitprovince();
            if (province.endsWith("移动") || province.endsWith("联通") || province.endsWith("电信")) {
                visitList.remove(i);
            } else if (province.endsWith("省") || province.endsWith("自治区") || province.endsWith("市")) {
                visitList.remove(i);
            }
        }
        return visitList;
    }

    /**
     * 总访问数
     *
     * @return
     */
    @Override
    public int getCount() {
        return visitMapper.selectCount();
    }


    /**
     * 月总访量
     *
     * @return
     */
    @Override
    public int getMonthCount() {
        return visitMapper.selectMonthCount();
    }

    /**
     * 周总访量
     *
     * @return
     */
    @Override
    public int getWeekCount() {
        return visitMapper.selectWeekCount();
    }

    /**
     * 日总访量
     *
     * @return
     */
    @Override
    public int getDayCount() {
        return visitMapper.selectDayCount();
    }

    /**
     * 获取最近n天的访问数据
     *
     * @param n 天数
     * @return
     */
    @Override
    public List<Visit> getVisitRecordDay(Integer n) {
        return visitMapper.selectVisitRecordDay(n);
    }
}
