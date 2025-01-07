package com.home.study.test1.transmission.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.home.study.test1.transmission.model.CategorySearchVO;
import com.home.study.test1.transmission.model.CategoryVO;
import com.home.study.test1.transmission.model.GotoVO;

@Controller
@RequestMapping("/test/category")
public class CategoryController {
	
	@RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
	public String index(
		HttpServletRequest request
		, HttpServletResponse response
		, @ModelAttribute("categorySearch") CategorySearchVO categorySearchVO
		, @ModelAttribute("gotoForm") GotoVO gotoFrom
		, ModelMap model
	) {
		return "test/category/index";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(
		HttpServletRequest req
		, HttpServletResponse resp
        , @ModelAttribute("categoryForm") CategoryVO categoryVO
        , @ModelAttribute("gotoForm") GotoVO gotoForm, ModelMap model
    ) {

        model.addAttribute("mode", "add");
        return "test/category/form";
    }
}
