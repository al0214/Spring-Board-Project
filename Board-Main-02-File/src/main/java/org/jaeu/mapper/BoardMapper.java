package org.jaeu.mapper;

import java.util.List;

import org.jaeu.domain.BoardDTO;
import org.jaeu.domain.CriteriaVO;
import org.jaeu.domain.FileDTO;

public interface BoardMapper {
	
	public BoardDTO detail(Long bno);
	public List<BoardDTO> getWithPaging(CriteriaVO cri);
	public void insertSelectKey(BoardDTO board);
	public int getTotal();
	public int update(BoardDTO board);
	public int remove(Long bno);
	public void allremove(BoardDTO board);
	public void registerFile(FileDTO fileDTO);
	public void increase();
	public List<FileDTO> getFiles(Long bno);
	public List<FileDTO> getFileName(String serverName);
	public void fileRemove(Long bno);
	public void AtfileRemove(Long fileBno);
	public void registerAlterFile(FileDTO fileDTO);
}
