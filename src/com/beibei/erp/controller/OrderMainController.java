package com.beibei.erp.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.beibei.erp.dao.ProductDao;


@Controller
public class OrderMainController {

	
	@Autowired
	ProductDao productDao;

	@RequestMapping(value = "ordermain", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView main(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		System.out.println("AAAAA");
		ModelAndView mav = new ModelAndView();

		mav.setViewName("order/ordermain");

		return mav;

	}
}
