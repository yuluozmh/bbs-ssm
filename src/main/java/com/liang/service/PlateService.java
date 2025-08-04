package com.liang.service;

import java.util.List;

import com.liang.bean.Plate;
import com.liang.bean.impl.PlateImpl;

public interface PlateService {
    /**
     * 新增板块信息
     *
     * @param plate
     */
    void setPlate(Plate plate);

    /**
     * 按bid删除板块信息
     *
     * @param bid
     */
    void deletePlate(String bid);

    /**
     * 修改板块
     *
     * @param plate
     */
    void updatePlate(Plate plate);

    /**
     * 查询板块信息（无条件）
     *
     * @return
     */
    List<PlateImpl> getPlate();

    /**
     * 按板块ID查询板块信息
     *
     * @param bid
     * @return
     */
    Plate getPlateId(String bid);

    /**
     * 板块名查询板块信息
     *
     * @param plate
     * @return
     */
    List<Plate> getPlateName(Plate plate);

    /**
     * 总板块数
     *
     * @return
     */
    int getCount();
}
