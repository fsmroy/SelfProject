package com.beibei.erp.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beibei.erp.bean.ProductSupplier;
import com.beibei.erp.mapper.ProductSupplierMapper;


@Service
public class ProductSupplierDao implements ProductSupplierMapper{
	
	@Resource
	ProductSupplierMapper productSupplierMapper;

	@Override
	public int deleteByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return productSupplierMapper.deleteByPrimaryKey(pk);
	}

	@Override
	public int insert(ProductSupplier record) {
		// TODO Auto-generated method stub
		return productSupplierMapper.insert(record);
	}

	@Override
	public int insertSelective(ProductSupplier record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ProductSupplier selectByPrimaryKey(Integer pk) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(ProductSupplier record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(ProductSupplier record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductSupplier> selectByP_num(String p_num) {
		// TODO Auto-generated method stub
		return productSupplierMapper.selectByP_num(p_num);
	}

	@Override
	public List<ProductSupplier> selectBySupplierAndLike(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productSupplierMapper.selectBySupplierAndLike(map);
	}

}
