package br.com.fatec.zl.SpringPaulistao2021.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.fatec.zl.SpringPaulistao2021.model.Grupo;
import br.com.fatec.zl.SpringPaulistao2021.persistence.GenericDao;
import br.com.fatec.zl.SpringPaulistao2021.persistence.GrupoDao;
import br.com.fatec.zl.SpringPaulistao2021.persistence.IGrupoDao;

@Controller
public class GrupoController {
	@Qualifier("grupoDao")
	@Autowired
	private IGrupoDao grpDao;

	public GrupoController() throws ClassNotFoundException, SQLException {
		this.grpDao = new GrupoDao(new GenericDao());
	}
	
	@GetMapping("/grupos")
	public ModelAndView listarGrupos() {
		ModelAndView modelAndView = new ModelAndView("index");
		return modelAndView;
	}
	
	@PostMapping("/grupos")
	public ModelAndView listarGrupos(@RequestParam Map<String,String> allRequestParam) {
		List<Grupo> grupos = new ArrayList<Grupo>();
		ModelAndView modelAndView = new ModelAndView("index");
		try {
			grpDao.gerarGrupos();
			grupos = this.grpDao.listarGrupos();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();

		} finally {
			modelAndView.addObject("grupos",grupos);
		}
		return modelAndView;
	}
}
