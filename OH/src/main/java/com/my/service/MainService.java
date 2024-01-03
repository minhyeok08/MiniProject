package com.my.service;
import java.util.*;


import org.springframework.stereotype.Service;

import com.my.vo.ProductVO;

public interface MainService {
	public List<ProductVO> ListData();
	
	public void CartInsertData(int pcno);
	
	public void CartDeleteData(int pcno);
	
	public void CartUpdateData(Map map);
	
	public List<ProductVO> CartData();
}
