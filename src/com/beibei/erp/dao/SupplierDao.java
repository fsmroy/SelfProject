package com.beibei.erp.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beibei.erp.bean.Supplier;
import com.beibei.erp.mapper.SupplierMapper;


@Service
public class SupplierDao implements SupplierMapper{

	@Resource
	SupplierMapper supplierMapper;

	@Override
	public int deleteByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return supplierMapper.deleteByPrimaryKey(pk);
	}

	@Override
	public int insert(Supplier record) {
		// TODO Auto-generated method stub
		
		return supplierMapper.insert(record);
	}

	@Override
	public int insertSelective(Supplier record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Supplier selectByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return supplierMapper.selectByPrimaryKey(pk);
	}

	@Override
	public int updateByPrimaryKeySelective(Supplier record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(Supplier record) {
		// TODO Auto-generated method stub
		return supplierMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Supplier> selectAll() {
		// TODO Auto-generated method stub
		return supplierMapper.selectAll();
	}

	@Override
	public void deleteBatchByPk(List<String> list) {
		// TODO Auto-generated method stub
		supplierMapper.deleteBatchByPk(list);
		
	}
}
