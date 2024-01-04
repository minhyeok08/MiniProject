package com.my.vo;

public class ProductVO {
	private int pcno,discount,price,count,dprice; 
	// pcno 상품 고유번호, discount 할인율, price 상품가격, count 상품개수, dprice 상품할인가
	
	private String name,detail,method,img,strPrice,strDprice;
	// name 상품명, detail 상품상세설명, method 보관방법, img 상품이미지파일명, string형 가격(decimal.format함수 활용위해), string형 상품할인가
	public int getPcno() {
		return pcno;
	}
	public void setPcno(int pcno) {
		this.pcno = pcno;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getDprice() {
		return dprice;
	}
	public void setDprice(int dprice) {
		this.dprice = dprice;
	}
	public String getStrPrice() {
		return strPrice;
	}
	public void setStrPrice(String strPrice) {
		this.strPrice = strPrice;
	}
	public String getStrDprice() {
		return strDprice;
	}
	public void setStrDprice(String strDprice) {
		this.strDprice = strDprice;
	}
	
	
}
