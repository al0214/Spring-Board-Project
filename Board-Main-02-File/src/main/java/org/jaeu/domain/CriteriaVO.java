package org.jaeu.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CriteriaVO {
	
	private int pageNum;
	private int amount;
	
	public CriteriaVO() {
		this(1, 10);
	}
	
	public CriteriaVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
