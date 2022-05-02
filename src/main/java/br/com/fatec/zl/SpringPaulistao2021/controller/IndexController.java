package br.com.fatec.zl.SpringPaulistao2021.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {
	
	@RequestMapping("/")
	public ModelAndView nomeDaAction() {
	  ModelAndView modelAndView = new ModelAndView("index");
	  
	  modelAndView.addObject("Titulo", "Aoba!");
	  return modelAndView;
	}
}
