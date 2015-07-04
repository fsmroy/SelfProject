package com.beibei.erp.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beibei.erp.bean.Purchase;
import com.beibei.erp.bean.PurchaseDetail;
import com.beibei.erp.bean.PurchaseDetailKey;
import com.beibei.erp.mapper.PurchaseDetailMapper;


@Service
public class PurchaseDetailDao implements PurchaseDetailMapper{
	
	@Resource
	PurchaseDetailMapper purchaseDetailMapper;

	

	@Override
	public int insert(PurchaseDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(PurchaseDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	@Override
	public int updateByPrimaryKeySelective(PurchaseDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(PurchaseDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertAll(Purchase purchase) {
		// TODO Auto-generated method stub
		return purchaseDetailMapper.insertAll(purchase);
	}

	@Override
	public List<PurchaseDetail> selectByPurchaseid(String purchase_id) {
		// TODO Auto-generated method stub
		return purchaseDetailMapper.selectByPurchaseid(purchase_id);
	}

	@Override
	public int deleteByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public PurchaseDetail selectByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return null;
	}

}
