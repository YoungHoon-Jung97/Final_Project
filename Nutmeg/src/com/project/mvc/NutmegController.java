package com.project.mvc;
	
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NutmegController
{
	@RequestMapping("/template.action")
	public String template(Model model)
	{
		return "Template";
	}
}