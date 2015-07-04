package com.beibei.erp.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beibei.erp.bean.Product;
import com.beibei.erp.bean.ProductSupplier;
import com.beibei.erp.dao.ProductDao;
import com.beibei.erp.dao.ProductSupplierDao;


@Controller
public class AutocomplateController {
	
	@Autowired
	ProductDao productDao;
	
	@Autowired
	ProductSupplierDao productSupplierDao;
	
	
	@RequestMapping(value = "autocomplateProduct", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryProduct(HttpServletRequest request,
			HttpServletResponse response,String queryInput,String supplier,String queryType) throws UnsupportedEncodingException {
	
		
		HttpSession session = request.getSession();
		
	
		System.out.println("輸入"+queryInput);
		
		List<Product> productList = new ArrayList<Product>();
		List<String> dataList = new ArrayList<String>();
		
		if(queryInput!=null && queryInput.length()>0){
			if(supplier!=null && supplier.length()>0 && queryType!=null && queryType.equals("supplier")){
				
			
				
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("supplier_id", supplier);
				map.put("supplier_p_num", "%"+queryInput+"%");
				List<ProductSupplier> productSupplierList =productSupplierDao.selectBySupplierAndLike(map);
				
				for(ProductSupplier productSupplier : productSupplierList){
					System.out.println(productSupplier.getP_name()+"(" +productSupplier.getP_num()+")");
					dataList.add(productSupplier.getP_name() +"-"+productSupplier.getSupplier_p_num()+"(" +productSupplier.getP_num()+")" );
				}
			}else{
				if(queryInput.matches("[\\d]+")){
					productList = productDao.selectByP_num(queryInput);
					
				}else{
					productList = productDao.selectByP_name(queryInput);
					
				}
				for(Product product:productList){
					dataList.add(product.getP_name()+"(" +product.getP_num()+")" );
				}
			}
		
			
		}
		
		
		
		JSONArray json = new JSONArray();	
		JSONArray mJSONArray = json.fromObject(dataList);
		System.out.println(mJSONArray.toString());

		return mJSONArray.toString();

	}
}
