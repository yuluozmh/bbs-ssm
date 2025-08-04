package com.liang.service;

import java.util.List;

import com.liang.bean.Visit;

import javax.servlet.http.HttpServletRequest;

public interface VisitService {
    /**
     * 新增访问信息
     *
     * @param request
     */
    void setVisit(HttpServletRequest request);

    /**
     * 查询访问信息（分页）
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    List<Visit> getVisit(int pageStart, int pageSize);

    /**
     * 统计-国家
     *
     * @return
     */
    List<Visit> visitCountryStatistic();

    /**
     * 统计-中国省份
     *
     * @return
     */
    List<Visit> visitProvinceStatistic();

    /**
     * 总访问数
     *
     * @return
     */
    int getCount();


    /**
     * 月总访量
     *
     * @return
     */
    int getMonthCount();

    /**
     * 周总访量
     *
     * @return
     */
    int getWeekCount();

    /**
     * 日总访量
     *
     * @return
     */
    int getDayCount();

    /**
     * 获取最近n天的访问数据
     *
     * @param n 天数
     * @return
     */
    List<Visit> getVisitRecordDay(Integer n);
}
