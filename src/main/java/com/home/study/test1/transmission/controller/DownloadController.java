package com.home.study.test1.transmission.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DownloadController {
	@RequestMapping("/transmission/download")
	public String download() {
		return "transmission/download";
	}
}
