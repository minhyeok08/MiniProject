package com.my.web;

import java.text.DecimalFormat;
import java.util.HashMap;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.my.vo.ProductVO;
import com.my.service.MainService;
import com.my.service.*;
@RestController
@CrossOrigin("*")
public class MainRestController {
	
	@Autowired
	private MainService service;
	
	@GetMapping(value="main/main_vue.do",produces = "text/plain;charset=UTF-8")
	public String ListData() throws Exception
	{
		List<ProductVO> list = service.ListData();
		for(ProductVO vo : list)
		{
			int dprice = vo.getPrice() * (100 - vo.getDiscount()) / 100;
			vo.setDprice(dprice);
			DecimalFormat df = new DecimalFormat("###,###,###");	// 1000원 단위로 , 쉼표
			String strDprice = df.format(vo.getDprice());	// str 타입 별도 저장
			vo.setStrDprice(strDprice);
			String strPrice = df.format(vo.getPrice());
			vo.setStrPrice(strPrice);
		}
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		
		return json;
	}
	
	@GetMapping(value="main/insert_vue.do",produces = "text/plain;charset=UTF-8")
	public void InsertData(int pcno) throws Exception
	{
		service.CartInsertData(pcno);
	}
	
	@GetMapping(value="main/cart_vue.do",produces = "text/plain;charset=UTF-8")
	public String CartData() throws Exception
	{
		List<ProductVO> clist = service.CartData();
		for(ProductVO vo : clist)
		{
			int dprice = vo.getPrice() * (100 - vo.getDiscount()) / 100;
			vo.setDprice(dprice);
			DecimalFormat df = new DecimalFormat("###,###,###");
			String strDprice = df.format(vo.getDprice());
			vo.setStrDprice(strDprice);
			String strPrice = df.format(vo.getPrice());
			vo.setStrPrice(strPrice);			
		}
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(clist);
		
		return json;
	}
	
	@GetMapping(value="main/delete_vue.do",produces = "text/plain;charset=UTF-8")
	public void DeleteData(int pcno) throws Exception
	{
		service.CartDeleteData(pcno);
	}
	
	@GetMapping(value="main/update_vue.do",produces = "text/plain;charset=UTF-8")
	public void UpdateData(int pcno, int count) throws Exception
	{
		Map map = new HashMap();
		map.put("pcno", pcno);
		map.put("count", count);
		service.CartUpdateData(map);
	}
	
	
}
