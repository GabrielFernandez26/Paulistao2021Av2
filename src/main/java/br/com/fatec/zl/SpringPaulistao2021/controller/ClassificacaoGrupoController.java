package br.com.fatec.zl.SpringPaulistao2021.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.fatec.zl.SpringPaulistao2021.model.Resultado;
import br.com.fatec.zl.SpringPaulistao2021.persistence.ClassificacaoDao;
import br.com.fatec.zl.SpringPaulistao2021.persistence.GenericDao;
import br.com.fatec.zl.SpringPaulistao2021.persistence.IClassificacaoDao;

@Controller
public class ClassificacaoGrupoController {

	@Autowired
	private IClassificacaoDao cDao;

	public ClassificacaoGrupoController() throws ClassNotFoundException, SQLException {
		this.cDao = new ClassificacaoDao(new GenericDao());
	}

	@PostMapping("/classificacaoGrupo")
	public ModelAndView classificacaoPorGrupo(@RequestParam Map<String,String> allRequestParam, String Grupo) {
		ModelAndView modelAndView = new ModelAndView("classificacao");
		List<Resultado> resA = new ArrayList<Resultado>();
		List<Resultado> resB = new ArrayList<Resultado>();
		List<Resultado> resC = new ArrayList<Resultado>();
		List<Resultado> resD = new ArrayList<Resultado>();
		try {
			resA = this.cDao.classificacaoPorGrupo("A");
			resB = this.cDao.classificacaoPorGrupo("B");
			resC = this.cDao.classificacaoPorGrupo("C");
			resD = this.cDao.classificacaoPorGrupo("D");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			modelAndView.addObject("resultadoGrupoA", resA);
			modelAndView.addObject("resultadoGrupoB", resB);
			modelAndView.addObject("resultadoGrupoC", resC);
			modelAndView.addObject("resultadoGrupoD", resD);
		}
		return modelAndView;
	}

}
