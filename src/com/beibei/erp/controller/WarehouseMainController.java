package com.beibei.erp.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.beibei.erp.bean.ProductKey;
import com.beibei.erp.dao.ProductDao;
import com.beibei.erp.service.TrialService;



@Controller
public class WarehouseMainController {
	
	@Autowired
	ProductDao productDao;

	@RequestMapping(value = "warehousemain", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView main(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("warehouse/warehousemain");
		
		TrialService.trial(mav);

		return mav;

	}

	@RequestMapping(value = "updateWH", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void updateWH(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		System.out.println(request.getParameter("itemid"));

		// return mav;

	}
	
	

	@RequestMapping(value = "deleteData", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteData(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		
		String[] idArray = request.getParameterValues("deleteId");
		
		if(idArray!=null){
			List<String> idList = new ArrayList<String>();
			for(String id:idArray){
				idList.add(id);
			}
			
			productDao.deleteBatchByPNUM(idList);
		}
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");
		

		return mJSON.toString();

	}

	@RequestMapping(value = "queryData", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryData(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		String sortId= request.getParameter("sort");
		String order = request.getParameter("order");
		
		Map<String, String> dataMap = new HashMap<String,String>();
		if(sortId!=null && order!=null){
			
		}else{
			sortId = "p_num";
			order = "";
		}
		dataMap.put("order_id", sortId);
		dataMap.put("order_type", order);
		System.out.println("排序排序:" + sortId + "   order:"+order);
		List<Product> productList = productDao.selectAll(dataMap);	
		
		
		JSONArray json = new JSONArray();	
		JSONArray mJSONArray = json.fromObject(productList);
		//System.out.println(mJSONArray.toString());

		return mJSONArray.toString();

	}
	
	@RequestMapping(value = "queryDataBykey", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryDataBykey(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		String pid= request.getParameter("pid");
	
		Product product = new Product();
		if(pid!=null){
		
			product = productDao.selectByPid(Integer.parseInt(pid));
		}
		
		
		JSONObject json = new JSONObject();	
		JSONObject mJSON = json.fromObject(product);
		System.out.println(mJSON.toString());

		return mJSON.toString();

	}
	
	
	
	
	@RequestMapping(value = "updateData", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String updateData(HttpServletRequest request,
			HttpServletResponse response,Product product) {
		HttpSession session = request.getSession();
		System.out.println("近來更新");
		String pid= request.getParameter("pid");
	
		if(product!=null){
			productDao.updateByPrimaryKey(product);
		}
		
		
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");
		

		return mJSON.toString();

	}
	
	@RequestMapping(value = "addProductData", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addProductData(HttpServletRequest request,
			HttpServletResponse response,Product product) {
		HttpSession session = request.getSession();
		
		if(product!=null){
			productDao.insertNoPid(product);
		}
		
		
		
		JSONObject mJSON = new JSONObject();
		mJSON.put("success", "success");
		

		return mJSON.toString();

	}
	
	
}
