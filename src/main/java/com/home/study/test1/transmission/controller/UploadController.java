package com.home.study.test1.transmission.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UploadController {
	
	@RequestMapping("/transmission/upload")
	public String upload(ModelMap model) {
		return "transmission/upload";
	}
}
