package com.beibei.erp.mapper;

import java.util.List;
import java.util.Map;

import com.beibei.erp.bean.Product;
import com.beibei.erp.bean.ProductKey;

public interface ProductMapper {
   

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	int deleteByPrimaryKey(ProductKey key);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	int insert(Product record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	int insertSelective(Product record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	Product selectByPrimaryKey(ProductKey key);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	int updateByPrimaryKeySelective(Product record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	int updateByPrimaryKey(Product record);

	List<Product> selectAll(Map<String,String> dataMap);
    
    List<Product> selectByP_num(String p_num);
    
    List<Product> selectByP_name(String p_name);
    
    void deleteBatchByPNUM(List<String> list);
    Product selectByPid(int pid);
    
    int insertNoPid(Product record);
    
    Product selectByPnum(String pnum);
    
    Product selectByPbarcode(String pbarcode);
}