package com.capstone.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
public class DeleteProduct {
	@Id
	private long prodId;
	@Column(name = "name")
	private String prodName;
	
	private String prodDescription;
	
	
	private long sellerId;


	public long getProdId() {
		return prodId;
	}


	public void setProdId(long prodId) {
		this.prodId = prodId;
	}


	public String getProdName() {
		return prodName;
	}


	public void setProdName(String prodName) {
		this.prodName = prodName;
	}


	public String getProdDescription() {
		return prodDescription;
	}


	public void setProdDescription(String prodDescription) {
		this.prodDescription = prodDescription;
	}


	public long getSellerId() {
		return sellerId;
	}


	public void setSellerId(long sellerId) {
		this.sellerId = sellerId;
	}


	public DeleteProduct(long prodId, String prodName, String prodDescription, long sellerId) {
		super();
		this.prodId = prodId;
		this.prodName = prodName;
		this.prodDescription = prodDescription;
		this.sellerId = sellerId;
	}
	
	DeleteProduct(){
		
	}
	

}
