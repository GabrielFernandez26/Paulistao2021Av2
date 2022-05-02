package br.com.fatec.zl.SpringPaulistao2021.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.batch.BatchProperties.Job;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.fatec.zl.SpringPaulistao2021.model.Jogo;
import br.com.fatec.zl.SpringPaulistao2021.persistence.IJogoDao;

@Controller
public class QuartasController {

	@Autowired
	private IJogoDao jDao;
	
	@GetMapping("/quartas")
	public ModelAndView buscarQuartas() {
		ModelAndView modelAndView = new ModelAndView("quartas");
		return modelAndView;
	}
	
	@PostMapping("/quartas")
	public ModelAndView listarQuartas(@RequestParam Map<String, String> allRequestParam) {
		ModelAndView modelAndView = new ModelAndView("quartas");
		List<Jogo> jogos = new ArrayList<Jogo>();

		try {
			jDao.gerarJogos();
			jogos = this.jDao.listarQuartas();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			modelAndView.addObject("jogos", jogos);
		}

		return modelAndView;
	}

}
