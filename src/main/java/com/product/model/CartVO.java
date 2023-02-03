package com.product.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartVO {
	
	private int cart_idx; // 장바구니 번호
	private int midx; // 회원번호
	private int pidx; // 상품번호
	private int pqty; // 상품수량
	private int ctotalprice; // 상품 총액
	
	private ProductVO product; //상품 객체
	

}
