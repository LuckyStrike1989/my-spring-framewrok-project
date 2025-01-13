package com.home.study.test1.transmission.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.home.study.test1.transmission.model.UploadFileSearchVO;

@Controller
public class FileController {
	//@Autowired
    //private IFileService fileService;
	
	@RequestMapping("/transmission/file")
	public String file(
		HttpServletRequest request
		, HttpServletResponse response
		, @ModelAttribute("uploadFileSearch") UploadFileSearchVO uploadFileSearchVO
		, ModelMap model
	) {
		// model.addAttribute("categoryList", fileService.selectCategoryList());
		
		uploadFileSearchVO.setRegID("guest");
		
		// uploadFileSearchVO = fileService.selectFileList(uploadFileSearchVO);
		
		return "transmission/file";
	}
}
