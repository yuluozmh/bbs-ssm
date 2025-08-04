package com.liang.dao;

import com.liang.bean.Plate;
import com.liang.bean.impl.PlateImpl;

import java.util.List;

public interface PlateMapper {
    /**
     * 新增板块
     * @param record
     */
    void insert(Plate record);

    /**
     * 按bid删除板块信息
     * @param bid
     */
    void deleteByKey(String bid);

    /**
     * 修改板块
     * @param record
     */
    void updateByKey(Plate record);

    /**
     * 查询板块的所有信息
     * @return
     */
    List<PlateImpl> selectPlate();

    /**
     * 按板块名查询
     * @param plate
     * @return
     */
    List<Plate> selectPlateByName(Plate plate);

    /**
     * 按板块ID查询板块信息
     * @param bid
     * @return
     */
    Plate selectPlateByKey(String bid);

    /**
     * 总板块数
     * @return
     */
    int selectCount();
}