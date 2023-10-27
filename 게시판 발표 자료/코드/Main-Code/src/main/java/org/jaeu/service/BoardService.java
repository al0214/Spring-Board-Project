package org.jaeu.service;

import java.util.List;

import org.jaeu.domain.BoardDTO;
import org.jaeu.domain.CriteriaVO;
import org.jaeu.domain.FileDTO;

public interface BoardService {

	public BoardDTO detail(Long bno);

	public List<BoardDTO> getWithPaging(CriteriaVO cri);

	public void register(BoardDTO board);

	public int getTotal();

	public void update(BoardDTO board);

	public void remove(Long bno);

	public void allremove(BoardDTO board);

	public void registerFile(FileDTO fileDTO);

	public void increase();

	public List<FileDTO> getfiles(Long bno);

	public List<FileDTO> getfileName(String serverName);

	public void fileRemove(Long bno);

	public void AtfileRemove(Long fileBno);

	public void registerAlterFile(FileDTO fileDTO);

	public String getFolder();

	public String makeFilename(String d);

	public String makeOnlyFileName(String a);
}
