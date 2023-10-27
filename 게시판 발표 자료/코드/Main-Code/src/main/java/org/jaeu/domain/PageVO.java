package org.jaeu.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private CriteriaVO cri;
	
	public PageVO(CriteriaVO cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		// 페이지 마지막 번호는 가져온 페이지 번호를 10으로 나누고 반올림하여 10을 곱하면 나온다. 
	    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		// 시작 페이지는 해당 페이지의 마지막 번호서 9를 빼면 나오게 된다.
	    this.startPage = this.endPage - 9;
		
		// 전체 데이터 수를 이용해서 진짜 끝 페이지를 구함
	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		// 만약 전체 realEnd가 endPage보다 작다면 끝 번호는 작은 값이 되어야만 한다
	    if (realEnd <= this.endPage) {
	        this.endPage = realEnd;
	      }
		
		// 이전 페이지 계산
	    this.prev = this.startPage > 1;
		
		// 다음 페이지 계산
	    this.next = this.endPage < realEnd;
	}
}
