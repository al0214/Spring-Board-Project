package org.jaeu.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.jaeu.domain.BoardDTO;
import org.jaeu.domain.CriteriaVO;
import org.jaeu.domain.FileDTO;
import org.jaeu.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public List<BoardDTO> getWithPaging(CriteriaVO cri) {
		// 리스트 페이지
		return mapper.getWithPaging(cri);
	}

	@Override
	public BoardDTO detail(Long bno) {
		// 조회 및 수정 페이지
		return mapper.detail(bno);
	}

	@Override
	public void register(BoardDTO board) {
		// 등록 페이지
		mapper.insertSelectKey(board);

	}

	@Override
	public void update(BoardDTO board) {
		// 수정 구현
		mapper.update(board);
	}

	@Override
	public int getTotal() {
		// 총 게시물 수
		return mapper.getTotal();
	}

	@Override
	public void remove(Long bno) {
		// 삭제 구현
		mapper.remove(bno);

	}

	@Override
	public void allremove(BoardDTO board) {
		// 모든 게시물 삭제
		mapper.allremove(board);

	}

	@Override
	public void registerFile(FileDTO fileDTO) {
		// 파일 등록
		mapper.registerFile(fileDTO);
	}

	@Override
	public void increase() {
		// 시퀀스 증가
		mapper.increase();

	}

	@Override
	public List<FileDTO> getfiles(Long bno) {
		
		return mapper.getFiles(bno);
	}

	@Override
	public List<FileDTO> getfileName(String serverName) {

		return mapper.getFileName(serverName);
	}

	@Override
	public void fileRemove(Long bno) {
		mapper.fileRemove(bno);

	}

	@Override
	public String makeFilename(String d) {
		Date now = new Date();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddhhmmSS");
		String nowString = sdf1.format(now);

		nowString = nowString + "." + d;
		return nowString;
	}

	@Override
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String string = sdf.format(date);

		return string.replace("-", File.separator);
	}

	@Override
	public String makeOnlyFileName(String a) {
		return FilenameUtils.getBaseName(a);
	}

	@Override
	public void AtfileRemove(Long fileBno) {
		mapper.AtfileRemove(fileBno);

	}

	@Override
	public void registerAlterFile(FileDTO fileDTO) {
		mapper.registerAlterFile(fileDTO);

	}

}
