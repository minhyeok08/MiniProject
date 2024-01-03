package com.my.mapper;
import com.my.vo.*;
import java.util.*;
public interface MainMapper {
	public List<ProductVO> ListData(); // 리스트 저장
	
	public void CartInsertData(int pcno); // 장바구니 데이터 넣기
	
	public void CartDeleteData(int pcno); // 장바구니 데이터 삭제
	
	public void CartUpdateData(Map map); // 장바구니 데이터 갱신
	
	public List<ProductVO> CartData(); // 장바구니 정보
}
