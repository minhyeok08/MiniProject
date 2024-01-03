package com.my.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.my.vo.*;
import com.my.mapper.MainMapper;
@Repository
public class MainDAO {
	@Autowired
	private MainMapper mapper;
	
	public List<ProductVO> ListData()
	{
		
		return mapper.ListData();
	}
	
	public void CartInsertData(int pcno)
	{
		mapper.CartInsertData(pcno);
	}
	
	public void CartUpdateData(Map map)
	{
		mapper.CartUpdateData(map);
	}
	
	public List<ProductVO> CartData()
	{
		
		return mapper.CartData();
	}
	
	public void CartDeleteData(int pcno)
	{
		mapper.CartDeleteData(pcno);
	}
}
