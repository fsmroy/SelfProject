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

import com.beibei.erp.bean.Deliver;
import com.beibei.erp.bean.DeliverDetail;
import com.beibei.erp.bean.Product;
import com.beibei.erp.bean.ProductKey;

import com.beibei.erp.dao.DeliverAction;
import com.beibei.erp.dao.DeliverDao;
import com.beibei.erp.dao.DeliverDetailDao;
import com.beibei.erp.dao.ProductDao;
import com.beibei.erp.service.TrialService;


@Controller
public class DeliverController {

	@Autowired
	ProductDao productDao;

	@Autowired
	DeliverAction deliverAction;

	@Autowired
	DeliverDetailDao deliverDetailDao;

	@Autowired
	DeliverDao deliverDao;

	@RequestMapping(value = "deliver", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView deliver(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("warehouse/deliver");
		
		TrialService.trial(mav);

		return mav;

	}

	

	@RequestMapping(value = "addDeliver", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addDeliver(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		String signer = request.getParameter("signer");
		String[] p_ids = request.getParameterValues("p_id");
		String customer = request.getParameter("customer");

		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String deliver_id = sdf.format(d);

		DeliverDetail deliverDetail = null;
		List<DeliverDetail> deliverDetailList = new ArrayList<DeliverDetail>();

		int total = 0;
		for (String pid : p_ids) {
			int p_price = 0;
			int p_count_out = Integer.parseInt(request
					.getParameter(pid + "p_count_out"));

			if (request.getParameter(pid + "p_price") != null
					&& request.getParameter(pid + "p_price").matches("[0-9]+")) {
				p_price = p_price
						+ Integer.parseInt(request
								.getParameter(pid + "p_price"));
			}
			total = total + p_price*p_count_out;
			deliverDetail = new DeliverDetail();
			deliverDetail.setP_count_out(p_count_out);
			deliverDetail.setP_price(p_price);
			deliverDetail.setP_id(Integer.parseInt(pid));
			deliverDetail.setDeliver_id(deliver_id);
			deliverDetailList.add(deliverDetail);
		}

		Deliver deliver = new Deliver();
		deliver.setDeliver_id(deliver_id);
		deliver.setCreate_date(d);
		deliver.setSigner(signer);
		deliver.setTotal(total);
		deliver.setCustomer(customer);
		deliver.setDeliverDetailList(deliverDetailList);

		deliverAction.insertDeliverData(deliver);

		JSONObject json = new JSONObject();
		json.put("success", "success");

		return json.toString();

	}

	@RequestMapping(value = "queryAllDeliver", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryAlldeliver(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		List<Deliver> deliverList = deliverDao.selectAll();
		List<DeliverDetail> deliverDetailList = null;
		for (Deliver deliver : deliverList) {
			deliverDetailList = deliverDetailDao.selectByDeliverid(deliver.getDeliver_id());
			deliver.setDeliverDetailList(deliverDetailList);	
			for (DeliverDetail detail : deliverDetailList) {
				detail.setJsonId(detail.getPk() + detail.getDeliver_id());
			}	
			//for treegrid	
			deliver.setJsonId(deliver.getDeliver_id());
			deliver.setChildren(deliverDetailList);
		}
		JSONArray json = new JSONArray();
		json = json.fromObject(deliverList);
		System.out.println(json.toString());
		//接著用TREEGRID
		return json.toString();

	}
	
	@RequestMapping(value = "queryDeliverByDate", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryDeliverByDate(HttpServletRequest request,
			HttpServletResponse response,String startDate,String endDate) {
		HttpSession session = request.getSession();
		Map<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<Deliver> deliverList = deliverDao.selectByDate(map);
		List<DeliverDetail> deliverDetailList = null;
		
		Map<String,Object> tempMap;
		JSONArray json = new JSONArray();
		
		
		for (Deliver deliver : deliverList) {
			deliverDetailList = deliverDetailDao.selectByDeliverid(deliver.getDeliver_id());
			deliver.setDeliverDetailList(deliverDetailList);	
			
			tempMap = new HashMap<String,Object>();
			
			tempMap = new HashMap<String,Object>();
			tempMap.put("deliver_id", deliver.getDeliver_id());
			tempMap.put("signer", deliver.getSigner());
			tempMap.put("createDate", deliver.getCreateDate());
			tempMap.put("total", deliver.getTotal());
			tempMap.put("customer", deliver.getCustomer());
			
			
			JSONObject obj = null;
			for (DeliverDetail detail : deliverDetailList) {
				detail.setJsonId(detail.getPk() + detail.getDeliver_id());
				
				obj = new JSONObject();
				obj = JSONObject.fromObject(detail);
				obj.putAll(tempMap);
				json.add(obj);
			}	
			//for treegrid	
			deliver.setJsonId(deliver.getDeliver_id());
			deliver.setChildren(deliverDetailList);
		}
		//JSONArray json = new JSONArray();
		//json = json.fromObject(deliverList);
		System.out.println(json.toString());
		//接著用TREEGRID
		return json.toString();

	}
	
	@RequestMapping(value = "delivermain", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView delivermain(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("warehouse/delivermain");
		
		TrialService.trial(mav);

		return mav;

	}

}
