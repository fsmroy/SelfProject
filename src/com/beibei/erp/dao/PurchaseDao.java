package com.beibei.erp.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beibei.erp.bean.Purchase;
import com.beibei.erp.mapper.PurchaseMapper;


@Service
public class PurchaseDao implements PurchaseMapper{

	@Resource
	PurchaseMapper purchaseMapper;
	


	@Override
	public int insert(Purchase record) {
		// TODO Auto-generated method stub
		return purchaseMapper.insert(record);
	}

	@Override
	public int insertSelective(Purchase record) {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public int updateByPrimaryKeySelective(Purchase record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(Purchase record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertHasDate(Purchase record) {
		// TODO Auto-generated method stub
		return purchaseMapper.insertHasDate(record);
	}

	@Override
	public List<Purchase> selectAll() {
		// TODO Auto-generated method stub
		return purchaseMapper.selectAll();
	}

	@Override
	public int deleteByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Purchase selectByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Purchase> selectByDate(Map<String, String> map) {
		// TODO Auto-generated method stub
		return purchaseMapper.selectByDate(map);
	}

}
