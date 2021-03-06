package com.quantour.ssm.service;

import com.quantour.ssm.dto.customizeStrategy.CustomizeStrategyDTO;
import com.quantour.ssm.dto.customizeStrategy.ScreeningConditionDTO;
import com.quantour.ssm.dto.customizeStrategy.StockPondDTO;
import com.quantour.ssm.dto.customizeStrategy.TradeModelDTO;
import com.quantour.ssm.dto.strategyResultDTO;

import java.util.ArrayList;

/**
 * Created by zhangzy on 2017/5/25.
 * 实现自定义策略相关的接口
 */

public interface CustomizeService {
    /**
     * 获得全部行业板块的名称 在初始化自定义策略的界面的时候需要调用
     * @return
     */
    public ArrayList<String> getAllIndustryBlock();

    /**
     * 获得全部概念板块的名称
     * @return
     */
    public ArrayList<String> getAllConceptBlock();

    /**
     * 获得全部地域板块的名称
     * @return
     */
    public ArrayList<String> getAllAreaBlock();

    /**
     * 根据开始日期 结束日期 基准板块 策略的三个方面的设置或者这个策略在这一个区间上的结果
     * @param sDate 策略开始日期
     * @param lDate 策略结束日期
     * @param blockCode 基准板块的编号 格式为sh000300(沪深300)
     * @param stockPondDTO  策略的选股设置
     * @param screeningConditionDTOArrayList 策略的选股指标 是一个多个筛选条件形成的列表
     * @param tradeModelDTO 策略的交易模型
     * @return
     */
    public strategyResultDTO getCustomizeStrategyResult(String userId,String sDate, String lDate, String blockCode, StockPondDTO stockPondDTO, ArrayList<ScreeningConditionDTO> screeningConditionDTOArrayList, TradeModelDTO tradeModelDTO);


    /**
     * 获得当前的系统时间 格式为"yyyy-MM-dd HH:mm:ss"
     * @return
     */
    public String getCurrentTime();
    /**
     * 根据策略的编号获得一个自定义策略 strategyId=userId+" "+dateTime
     * @param strategyId
     * @return
     */
    public CustomizeStrategyDTO getOneStrategy(String strategyId);

    /**
     * 向数据库中插入一个新的策略 如果这个策略的用户id和策略姓名不存在则返回TRUE
     * @param customizeStrategyDTO
     * @return
     */
    public boolean insertOneStrategy(CustomizeStrategyDTO customizeStrategyDTO);

    /**
     * 根据策略id删除一条策略
     * @param strategyId
     * @return
     */
    public boolean deleteOneStrategy(String strategyId);

    /**
     * 删除一个用户创建的全部策略
     * @param userId
     * @return
     */
    public boolean deleteUserAllStrategy(String userId);

    /**
     * 获得数据库中全部的策略用来展示
     * @return
     */
    public ArrayList<CustomizeStrategyDTO> getAllCustomizeStrategy();

    /**
     * 根据用户的id获得这个用户创建的全部策略
     * @param userID
     * @return
     */
    public ArrayList<CustomizeStrategyDTO> getOneUserAllStrategy(String userID);
}
