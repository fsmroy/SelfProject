package com.beibei.erp.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.servlet.ModelAndView;

public class TrialService {

	
	public static void trial(ModelAndView mav) throws ParseException{
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date testDate = sdf.parse("2015/10/10");
		if(d.getTime()> testDate.getTime()){
			mav.setViewName("trial");
		}
	}
}
