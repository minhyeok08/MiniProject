package com.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.MainDAO;
import com.my.vo.ProductVO;

import java.util.*;
@Service
public class MainServiceImpl implements MainService {
	@Autowired
	private MainDAO dao;
	
	@Override
	public List<ProductVO> ListData()
	{
		return dao.ListData();
	}
	
	@Override
	public void CartInsertData(int pcno)
	{
		dao.CartInsertData(pcno);
	}
	
	@Override
	public void CartDeleteData(int pcno)
	{
		dao.CartDeleteData(pcno);
	}
	
	@Override
	public void CartUpdateData(Map map)
	{
		dao.CartUpdateData(map);
	}
	
	@Override
	public List<ProductVO> CartData()
	{
		return dao.CartData();
	}
}
