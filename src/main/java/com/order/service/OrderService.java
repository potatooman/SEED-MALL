package com.order.service;

import java.util.List;

import com.order.model.OrderProductVO;
import com.order.model.OrderVO;
import com.product.model.PagingVO;
import com.product.model.ProductVO;

public interface OrderService {
	// 주문 명세서 생성하기
	int createOrderList(OrderVO ovo);
	
	// 주문VO 생성하기 - 상품 정보 생성하기
	int createOrderProductList(OrderProductVO opvo);
	
	// 주문 구매확정 버튼
	int orderConfirmed(int oidx);
	
	// 주문 명세서 가져오기 - 회원번호로 List가져오기
	List<OrderVO> getOrderList(int midx);
	
	// 상품정보 가져오기
	OrderProductVO getOrderProduct(int pidx);

	// 몇 개 주문했는지
	int getOrderCount(PagingVO pvo);
	
	// 주문정보 수정
	int updateOrder(OrderVO ovo);
	
	// 주문정보 삭제
	int deleteOrder(Integer oidx);

	// 총 결제액(등급할인 후)
	int totalPayment();

	/* 총 주문 정보 */
	// 주문상품List 가져오기
	List<OrderProductVO> getOrderProductList(int desc_oidx);

	// 명세서 가져오기
	OrderVO getOrderDesc(int desc_oidx);
	
	// 주문 건 별로 수령자 가져오기
	OrderVO getOrderMember(int desc_oidx);
	
}
