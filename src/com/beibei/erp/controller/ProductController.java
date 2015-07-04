package com.beibei.erp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beibei.erp.bean.Product;
import com.beibei.erp.dao.ProductDao;


@Controller
public class ProductController {
	
	@Autowired
	ProductDao productDao;

	
	@RequestMapping(value = "queryDataByPnum", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryDataByPnum(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		String pnum = request.getParameter("pnum");

		Product product = new Product();
		if (pnum != null) {

			product = productDao.selectByPnum(pnum);
		}

		JSONObject json = new JSONObject();
		JSONObject mJSON = json.fromObject(product);
		System.out.println(mJSON.toString());

		return mJSON.toString();

	}

	@RequestMapping(value = "queryDataByPbarcode", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryDataByPbarcode(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		String pbarcode = request.getParameter("pbarcode");

		Product product = new Product();
		if (pbarcode != null) {

			product = productDao.selectByPbarcode(pbarcode);
		}

		JSONObject json = new JSONObject();
		JSONObject mJSON = json.fromObject(product);
		System.out.println(mJSON.toString());

		return mJSON.toString();

	}
}
