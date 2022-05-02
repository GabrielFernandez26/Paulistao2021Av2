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

import br.com.fatec.zl.SpringPaulistao2021.model.Jogo;
import br.com.fatec.zl.SpringPaulistao2021.persistence.IJogoDao;

@Controller
public class RodadaController {
	@Qualifier("jogoDao")
	@Autowired
	private IJogoDao jDao;
	
	@GetMapping("/rodadas")
	public ModelAndView listarGrupos() {
		ModelAndView modelAndView = new ModelAndView("rodadas");
		return modelAndView;
	}

	@PostMapping("/rodadas")
	public ModelAndView listarGrupos(@RequestParam Map<String, String> allRequestParam, String data) {
		List<Jogo> jogos = new ArrayList<Jogo>();
		ModelAndView modelAndView = new ModelAndView("rodadas");
		try {
			jDao.gerarJogos();
			jogos = this.jDao.buscarJogoPorData(data);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();

		} finally {
			modelAndView.addObject("jogos", jogos);
		}
		return modelAndView;
	}

}
