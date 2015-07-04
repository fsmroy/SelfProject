package com.beibei.erp.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beibei.erp.bean.Product;
import com.beibei.erp.bean.ProductKey;
import com.beibei.erp.mapper.ProductMapper;

@Service
public class ProductDao implements ProductMapper {

	@Resource
	private ProductMapper productMapper;

	

	@Override
	public int insert(Product record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(Product record) {
		// TODO Auto-generated method stub
		return 0;
	}

	

	@Override
	public int updateByPrimaryKeySelective(Product record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(Product record) {
		// TODO Auto-generated method stub
		return productMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Product> selectAll(Map<String, String> dataMap) {
		// TODO Auto-generated method stub
		return productMapper.selectAll(dataMap);
	}

	@Override
	public List<Product> selectByP_num(String p_num) {
		// TODO Auto-generated method stub
		return productMapper.selectByP_num("%"+p_num+"%");
	}

	@Override
	public List<Product> selectByP_name(String p_name) {
		// TODO Auto-generated method stub
		return productMapper.selectByP_name("%"+p_name+"%");
	}

	@Override
	public int deleteByPrimaryKey(ProductKey key) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Product selectByPrimaryKey(ProductKey key) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteBatchByPNUM(List<String> list) {
		// TODO Auto-generated method stub
		productMapper.deleteBatchByPNUM(list);
		
	}

	@Override
	public Product selectByPid(int pid) {
		// TODO Auto-generated method stub
		return productMapper.selectByPid(pid);
	}

	@Override
	public int insertNoPid(Product record) {
		// TODO Auto-generated method stub
		return productMapper.insertNoPid(record);
	}

	@Override
	public Product selectByPnum(String pnum) {
		// TODO Auto-generated method stub
		return productMapper.selectByPnum(pnum);
	}

	@Override
	public Product selectByPbarcode(String pbarcode) {
		// TODO Auto-generated method stub
		return productMapper.selectByPbarcode(pbarcode);
	}

	

	

}
