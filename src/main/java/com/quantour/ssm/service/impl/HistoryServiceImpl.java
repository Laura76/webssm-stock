package com.quantour.ssm.service.impl;

import com.quantour.ssm.service.HistoryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by zhangzy on 2017/5/25.
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class HistoryServiceImpl implements HistoryService{


}