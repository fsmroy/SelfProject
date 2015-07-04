package com.beibei.erp.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beibei.erp.bean.Deliver;
import com.beibei.erp.bean.DeliverDetail;
import com.beibei.erp.mapper.DeliverDetailMapper;


@Service
public class DeliverDetailDao implements DeliverDetailMapper{
	
	@Resource
	DeliverDetailMapper deliverDetailMapper;

	@Override
	public int deleteByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(DeliverDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(DeliverDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public DeliverDetail selectByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(DeliverDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(DeliverDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertAll(Deliver deliver) {
		// TODO Auto-generated method stub
		return deliverDetailMapper.insertAll(deliver);
	}

	@Override
	public List<DeliverDetail> selectByDeliverid(String deliver_id) {
		// TODO Auto-generated method stub
		return deliverDetailMapper.selectByDeliverid(deliver_id);
	}

}
