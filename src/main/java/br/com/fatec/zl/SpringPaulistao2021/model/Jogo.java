package br.com.fatec.zl.SpringPaulistao2021.model;

public class Jogo {
	
	private int codigoJogo;
	private String timeA;
	private String timeB;
	private int golsTimeA;
	private int golsTimeB;
	private String data;
	
	public String getTimeA() {
		return timeA;
	}
	public void setTimeA(String timeA) {
		this.timeA = timeA;
	}
	public String getTimeB() {
		return timeB;
	}
	public void setTimeB(String timeB) {
		this.timeB = timeB;
	}
	
	public int getCodigoJogo() {
		return codigoJogo;
	}
	public void setCodigoJogo(int codigoJogo) {
		this.codigoJogo = codigoJogo;
	}
	
	public int getGolsTimeA() {
		return golsTimeA;
	}
	public void setGolsTimeA(int golsTimeA) {
		this.golsTimeA = golsTimeA;
	}
	public int getGolsTimeB() {
		return golsTimeB;
	}
	public void setGolsTimeB(int golsTimeB) {
		this.golsTimeB = golsTimeB;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	
		
		
}
