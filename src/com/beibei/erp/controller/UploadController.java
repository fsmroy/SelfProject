package com.beibei.erp.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;












/**
 * Servlet implementation class UploadServlet
 */

@Controller
public class UploadController{
	
	 @Autowired 
	 ServletContext servletContext;
	

	
	
	@RequestMapping(value = "/upload",  method = { RequestMethod.GET, RequestMethod.POST })
	public void upload(HttpServletRequest request,HttpServletResponse response,String pnum) throws IOException {
		
		System.out.println("進來上傳!!!!");
	
		HttpSession session = request.getSession();
		ResourceBundle resource = ResourceBundle.getBundle("fileUpload-config");
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
        uploadHandler.setFileSizeMax(Long.parseLong(resource.getString("maxRequestSize")));
		
        PrintWriter writer = response.getWriter();
        response.setContentType("text/plain");
        JSONArray json = new JSONArray();
    	String tempFolder =servletContext.getRealPath("productImg") ;
    	
    	System.out.println("上傳路徑:" + tempFolder);
	
    
        try {
        	File f = new File(tempFolder);
        	if(!f.isDirectory()){
        		f.mkdirs();
        	}
            List<FileItem> items = uploadHandler.parseRequest(request);
          
            for (FileItem item : items) {
                if (!item.isFormField()) {
                	String oldFileName = item.getName();
                	if (oldFileName != null && !oldFileName.equals("")) {
                		String newFileName = pnum +"." +oldFileName.replaceAll(".+\\.", "");
						
                        File file = new File(tempFolder, newFileName);
                        item.write(file);
                        System.out.println("Success");
                        JSONObject jsono = new JSONObject();
                        jsono.put("name", newFileName);
                        jsono.put("size", item.getSize());
                        jsono.put("url", "upload?time=" );
                        jsono.put("deleteUrl", "upload?time=");
                        jsono.put("deleteType", "POST");
                      
                        json.add(jsono);
                	}
                }
            }
            
            //
           
        } catch (FileUploadException e) {
                throw new RuntimeException(e);
        } catch (Exception e) {
                throw new RuntimeException(e);
        } finally {
            writer.write(json.toString());
            System.out.println(json.toString());
            writer.close();
        }
	}
	
	
}
