package com.beibei.erp.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beibei.erp.bean.Deliver;
import com.beibei.erp.bean.Purchase;
import com.beibei.erp.mapper.DeliverMapper;
import com.beibei.erp.mapper.PurchaseMapper;


@Service
public class DeliverDao implements DeliverMapper{

	@Resource
	DeliverMapper deliverMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(Deliver record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(Deliver record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Deliver selectByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(Deliver record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(Deliver record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertHasDate(Deliver deliver) {
		// TODO Auto-generated method stub
		return deliverMapper.insertHasDate(deliver);
	}

	@Override
	public List<Deliver> selectAll() {
		// TODO Auto-generated method stub
		return deliverMapper.selectAll();
	}

	@Override
	public List<Deliver> selectByDate(Map<String, String> map) {
		// TODO Auto-generated method stub
		return deliverMapper.selectByDate(map);
	}

	

}
