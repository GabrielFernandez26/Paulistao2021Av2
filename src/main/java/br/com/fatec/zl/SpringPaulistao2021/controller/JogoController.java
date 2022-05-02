package br.com.fatec.zl.SpringPaulistao2021.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.fatec.zl.SpringPaulistao2021.model.Jogo;
import br.com.fatec.zl.SpringPaulistao2021.persistence.GenericDao;
import br.com.fatec.zl.SpringPaulistao2021.persistence.IJogoDao;
import br.com.fatec.zl.SpringPaulistao2021.persistence.JogoDao;

@Controller
public class JogoController {
	@Qualifier("jogoDao")
	@Autowired
	private IJogoDao jDao;
	
	public JogoController() throws ClassNotFoundException, SQLException{
		this.jDao = new JogoDao(new GenericDao());
	}
	
	
	@GetMapping("/jogos")
	public ModelAndView listarJogos(@RequestParam Map<String, String> allRequestParam) {
		List<Jogo> jogos = new ArrayList<Jogo>();
		ModelAndView modelAndView = new ModelAndView("jogos");
		try {
			jDao.gerarJogos();
			jogos = this.jDao.listarJogos();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			modelAndView.addObject("jogos", jogos);
		}
		return modelAndView;
	}
}
