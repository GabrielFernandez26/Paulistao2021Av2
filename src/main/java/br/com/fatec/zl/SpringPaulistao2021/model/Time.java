package br.com.fatec.zl.SpringPaulistao2021.model;

public class Time {
	private int codigoTime;
	private String nome;
	private String cidade;
	private String estadio;
	
	
	public int getCodigoTime() {
		return codigoTime;
	}


	public void setCodigoTime(int codigoTime) {
		this.codigoTime = codigoTime;
	}


	public String getNome() {
		return nome;
	}


	public void setNome(String nome) {
		this.nome = nome;
	}


	public String getCidade() {
		return cidade;
	}


	public void setCidade(String cidade) {
		this.cidade = cidade;
	}


	public String getEstadio() {
		return estadio;
	}


	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}


	@Override
	public String toString() {
		return "Time [CodigoTime=" + codigoTime + ", NomeTime=" + nome+ ", Cidade=" + cidade + ", Estadio="
				+ estadio + "]";
	}

	
}
