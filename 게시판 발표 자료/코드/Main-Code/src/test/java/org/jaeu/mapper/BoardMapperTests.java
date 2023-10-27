package org.jaeu.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.jaeu.domain.BoardDTO;
import org.jaeu.domain.CriteriaVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// Java Config
// @ContextConfiguration(classes = {org.zerock.config.RootConfig.class} )
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;



	@Test
	public void testInsertSelectKey() {

		BoardDTO board = new BoardDTO();
		board.setTitle("새로 작성하는 글 select key");
		board.setDetail("새로 작성하는 내용 select key");

		mapper.insertSelectKey(board);

		log.info(board);
	}

	@Test
	public void testRead() {

		// 존재하는 게시물 번호로 테스트
		BoardDTO board = mapper.detail(5L);

		log.info(board);

	}
	
//	@Test
//	public void testUpdate() {
//		
//		BoardVO board = new BoardVO();
//		board.setBno(10L);
//		board.setTitle("수정된 제목");
//		board.setDetail("수정된 내용");
//		
//		int count = mapper.update(board);
//		log.info("UPDATE COUNT: " + count);
//	}




}
