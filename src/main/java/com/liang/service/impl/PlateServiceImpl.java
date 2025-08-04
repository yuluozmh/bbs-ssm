package com.liang.service.impl;

import com.liang.bean.Plate;
import com.liang.bean.impl.PlateImpl;
import com.liang.dao.PlateMapper;
import com.liang.service.PlateService;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlateServiceImpl implements PlateService {
    @Autowired
    PlateMapper plateMapper;

    /**
     * 新增板块信息
     *
     * @param plate
     */
    @Override
    public void setPlate(Plate plate) {
        plate.setBid(UUIDUtil.getRandomUUID());
        plateMapper.insert(plate);
    }

    /**
     * 按bid删除板块信息
     *
     * @param bid
     */
    @Override
    public void deletePlate(String bid) {
        plateMapper.deleteByKey(bid);
    }

    /**
     * 修改板块
     *
     * @param plate
     */
    @Override
    public void updatePlate(Plate plate) {
        plateMapper.updateByKey(plate);
    }

    /**
     * 查询板块信息（无条件）
     *
     * @return
     */
    @Override
    public List<PlateImpl> getPlate() {
        return plateMapper.selectPlate();
    }

    /**
     * 按板块ID查询板块信息
     *
     * @param bid
     * @return
     */
    @Override
    public Plate getPlateId(String bid) {
        return plateMapper.selectPlateByKey(bid);
    }

    /**
     * 板块名查询板块信息
     *
     * @param plate
     * @return
     */
    @Override
    public List<Plate> getPlateName(Plate plate) {
        return plateMapper.selectPlateByName(plate);
    }

    /**
     * 总板块数
     *
     * @return
     */
    @Override
    public int getCount() {
        return plateMapper.selectCount();
    }
}
