package com.beibei.erp.controller;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.beibei.erp.service.TrialService;


@Controller
public class ImageController {
	@RequestMapping(value = "imageupload", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView imageupload(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("warehouse/imageupload");
		
		TrialService.trial(mav);

		return mav;

	}
}
