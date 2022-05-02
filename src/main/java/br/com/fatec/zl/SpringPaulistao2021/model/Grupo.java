package br.com.fatec.zl.SpringPaulistao2021.model;

import java.util.ArrayList;
import java.util.List;

public class Grupo {
	private List <Time> times;
	private String nome;
	public Grupo() {
		this.times = new ArrayList<Time>();
	}
	public List<Time> getTimes() {
		return times;
	}

	public void addTime(Time time) {
		this.times.add(time);
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
}
