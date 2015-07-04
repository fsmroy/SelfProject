package com.beibei.erp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.beibei.erp.bean.Product;
import com.beibei.erp.bean.ProductSupplier;
import com.beibei.erp.bean.Supplier;
import com.beibei.erp.dao.ProductSupplierDao;
import com.beibei.erp.dao.SupplierDao;


@Controller
public class SupplierController {
	
	@Autowired
	SupplierDao supplierDao;
	
	@Autowired
	ProductSupplierDao productSupplierDao;
	
	@RequestMapping(value = "supplier", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	public ModelAndView supplier(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("warehouse/supplier");
		return mav;
	}
	
	
	@RequestMapping(value = "querySupplier", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryData(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		
		List<Supplier> supplierList= supplierDao.selectAll();	
		
		
		JSONArray json = new JSONArray();	
		JSONArray mJSONArray = json.fromObject(supplierList);
		//System.out.println(mJSONArray.toString());

		return mJSONArray.toString();

	}
	
	@RequestMapping(value = "insertSupplier", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String insertSupplier(HttpServletRequest request,
			HttpServletResponse response,Supplier supplier) {
		HttpSession session = request.getSession();
		
		supplierDao.insert(supplier);
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");
		return mJSON.toString();

	}
	
	
	
	
	@RequestMapping(value = "deleteSupplier", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteSupplier(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		
		String[] pkArray = request.getParameterValues("deleteId");
		
		if(pkArray!=null){
			List<String> pkList = new ArrayList<String>();
			for(String id:pkArray){
				pkList.add(id);
			}
			
			supplierDao.deleteBatchByPk(pkList);
		}
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");
		

		return mJSON.toString();

	}
	
	
	@RequestMapping(value = "querySupplyByPk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String querySupplyByPk(HttpServletRequest request,
			HttpServletResponse response,String pk) {
		HttpSession session = request.getSession();

		//String pk = request.getParameter("pk");
		System.out.println("PK:"+pk);
	
		Supplier supplier = new Supplier();
		if(pk!=null){
		
			supplier = supplierDao.selectByPrimaryKey(Integer.parseInt(pk));
		}
		
		
		JSONObject json = new JSONObject();	
		JSONObject mJSON = json.fromObject(supplier);
		System.out.println(mJSON.toString());

		return mJSON.toString();

	}
	
	@RequestMapping(value = "updateSupplier", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String updateData(HttpServletRequest request,
			HttpServletResponse response,Supplier supplier) {
		HttpSession session = request.getSession();
		System.out.println("近來更新");
		
	
		if(supplier!=null){
			supplierDao.updateByPrimaryKey(supplier);
		}
		
		
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");
		

		return mJSON.toString();

	}
	
	
	@RequestMapping(value = "insertSupplierItem", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String insertSupplierItem(HttpServletRequest request,
			HttpServletResponse response,ProductSupplier productSupplier) {
		HttpSession session = request.getSession();
		
		productSupplierDao.insert(productSupplier);
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");
		return mJSON.toString();

	}
	
	
	@RequestMapping(value = "querySupplierItem", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String querySupplierItem(HttpServletRequest request,
			HttpServletResponse response,String p_num) {
		HttpSession session = request.getSession();

		
		List<ProductSupplier> productSupplierList = productSupplierDao.selectByP_num(p_num);
		
		
		JSONArray json = new JSONArray();	
		JSONArray mJSONArray = json.fromObject(productSupplierList);
		//System.out.println(mJSONArray.toString());

		return mJSONArray.toString();

	}
	
	@RequestMapping(value = "deleteSupplierItem", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteSupplierItem(HttpServletRequest request,
			HttpServletResponse response,String pk) {
		HttpSession session = request.getSession();

		
		productSupplierDao.deleteByPrimaryKey(Integer.parseInt(pk));
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");

		return mJSON.toString();

	}
	
	

}
