package com.beibei.erp.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

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
import com.beibei.erp.dao.ProductDao;


@Controller
public class AutocomplateController {
	
	@Autowired
	ProductDao productDao;
	
	
	@RequestMapping(value = "autocomplateProduct", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryProduct(HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
	
		
		HttpSession session = request.getSession();
		
		String inputStr = request.getParameter("queryInput");
		System.out.println("輸入"+inputStr);
		
		List<Product> productList = new ArrayList<Product>();
		List<String> dataList = new ArrayList<String>();
		
		if(inputStr!=null && inputStr.length()>0){
			
		
			if(inputStr.matches("[\\d]+")){
				productList = productDao.selectByP_num(inputStr);
				
			}else{
				productList = productDao.selectByP_name(inputStr);
				
			}
			for(Product product:productList){
				dataList.add(product.getP_name()+"(" +product.getP_num()+")" );
			}
		}
		
		
		
		JSONArray json = new JSONArray();	
		JSONArray mJSONArray = json.fromObject(dataList);
		System.out.println(mJSONArray.toString());

		return mJSONArray.toString();

	}
}
