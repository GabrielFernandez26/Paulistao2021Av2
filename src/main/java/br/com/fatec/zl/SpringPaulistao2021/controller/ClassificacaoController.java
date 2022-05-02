package br.com.fatec.zl.SpringPaulistao2021.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import br.com.fatec.zl.SpringPaulistao2021.model.Resultado;
import br.com.fatec.zl.SpringPaulistao2021.persistence.IClassificacaoDao;

@Controller
public class ClassificacaoController {
	@Qualifier("classificacaoDao")
	@Autowired
	private IClassificacaoDao cDao;

	@GetMapping("/classificacao")
	public ModelAndView classificacaoGeral() {
		ModelAndView modelAndView = new ModelAndView("classificacao");
		List<Resultado> resultados = new ArrayList<Resultado>();
		try {
			resultados = this.cDao.classificacaoGeral();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			modelAndView.addObject("resultados", resultados);
		}
		return modelAndView;
	}

}
