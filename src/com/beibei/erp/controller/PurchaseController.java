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
import com.beibei.erp.bean.Purchase;
import com.beibei.erp.bean.PurchaseDetail;
import com.beibei.erp.dao.ProductDao;
import com.beibei.erp.dao.PurchaseAction;
import com.beibei.erp.dao.PurchaseDao;
import com.beibei.erp.dao.PurchaseDetailDao;
import com.beibei.erp.service.TrialService;

@Controller
public class PurchaseController {

	@Autowired
	ProductDao productDao;

	@Autowired
	PurchaseAction purchaseAction;

	@Autowired
	PurchaseDetailDao purchaseDetailDao;

	@Autowired
	PurchaseDao purchaseDao;

	@RequestMapping(value = "purchase", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView purchase(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("warehouse/purchase");

		TrialService.trial(mav);
		
		return mav;

	}

	

	@RequestMapping(value = "addPurchase", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addPurchase(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		String signer = request.getParameter("signer");
		String[] p_ids = request.getParameterValues("p_id");
		

		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String purchase_id = sdf.format(d);

		PurchaseDetail purchaseDetail = null;
		List<PurchaseDetail> purchaseDetailList = new ArrayList<PurchaseDetail>();

		int total = 0;
		for (String pid : p_ids) {
			int p_price = 0;
			int p_count_in = Integer.parseInt(request
					.getParameter(pid + "p_count_in"));
			int free_count = 0;
			if(request.getParameter(pid + "free_count")!=null){
				free_count =  Integer.parseInt(request.getParameter(pid + "free_count"));
			}

			if (request.getParameter(pid + "p_price") != null
					&& request.getParameter(pid + "p_price").matches("[0-9]+")) {
				p_price = p_price
						+ Integer.parseInt(request
								.getParameter(pid + "p_price"));
			}
			
			total = total + p_price*p_count_in;
			purchaseDetail = new PurchaseDetail();
			purchaseDetail.setP_count_in(p_count_in);
		
			purchaseDetail.setP_id(Integer.parseInt(pid));
			purchaseDetail.setPurchase_id(purchase_id);
			
			purchaseDetail.setFree_count(free_count);
			
		
			purchaseDetailList.add(purchaseDetail);
		}

		Purchase purchase = new Purchase();
		purchase.setPurchase_id(purchase_id);
		purchase.setCreate_date(d);
		purchase.setSigner(signer);
		purchase.setTotal(total);
		purchase.setSupplier_id(request.getParameter("supplier_id"));
		
		purchase.setPurchaseDetailList(purchaseDetailList);

		purchaseAction.insertPurchaseData(purchase);

		JSONObject json = new JSONObject();
		json.put("success", "success");

		return json.toString();

	}

	@RequestMapping(value = "queryAllPurchase", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryAllPurchase(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		List<Purchase> purchaseList = purchaseDao.selectAll();
		List<PurchaseDetail> purchaseDetailList = null;
		for (Purchase purchase : purchaseList) {
			purchaseDetailList = purchaseDetailDao.selectByPurchaseid(purchase.getPurchase_id());
			purchase.setPurchaseDetailList(purchaseDetailList);		
			for (PurchaseDetail detail : purchaseDetailList) {
				detail.setJsonId(detail.getPk() + detail.getPurchase_id());
			}		
			//for treegrid	
			purchase.setJsonId(purchase.getPurchase_id());
			purchase.setChildren(purchaseDetailList);
		}
	
		JSONArray json = new JSONArray();
		json = json.fromObject(purchaseList);
		System.out.println(json.toString());
		//接著用TREEGRID

		return json.toString();
	}
	
	@RequestMapping(value = "queryPurchaseByDate", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryPurchaseByDate(HttpServletRequest request,
			HttpServletResponse response,String startDate,String endDate) {
		HttpSession session = request.getSession();
		Map<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		System.out.println("query:" + map);
		List<Purchase> purchaseList = purchaseDao.selectByDate(map);
		List<PurchaseDetail> purchaseDetailList = null;
		for (Purchase purchase : purchaseList) {
			purchaseDetailList = purchaseDetailDao.selectByPurchaseid(purchase.getPurchase_id());
			purchase.setPurchaseDetailList(purchaseDetailList);		
			for (PurchaseDetail detail : purchaseDetailList) {
				detail.setJsonId(detail.getPk() + detail.getPurchase_id());
			}		
			//for treegrid	
			purchase.setJsonId(purchase.getPurchase_id());
			purchase.setChildren(purchaseDetailList);
		}
	
		JSONArray json = new JSONArray();
		json = json.fromObject(purchaseList);
		System.out.println(json.toString());
		//接著用TREEGRID

		return json.toString();
	}
	
	@RequestMapping(value = "purchasemain", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView purchasemain(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("warehouse/purchasemain");
		TrialService.trial(mav);
		return mav;

	}

}
