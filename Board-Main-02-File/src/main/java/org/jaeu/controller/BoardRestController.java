package org.jaeu.controller;

import java.io.Console;
import java.io.File;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jaeu.domain.BoardDTO;
import org.jaeu.domain.CriteriaVO;
import org.jaeu.domain.FileDTO;
import org.jaeu.domain.PageVO;
import org.jaeu.service.BoardService;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("*")
@RestController
@Log4j
@AllArgsConstructor
public class BoardRestController {
	private BoardService service;

	// 게시판 페이지
	@GetMapping("/list")
	public ModelAndView manage() {
		ModelAndView mav = new ModelAndView("board/list");
		return mav;
	}

	// 게시판 페이징 처리 및 데이터 불러오기
	@GetMapping(value = "/list/pages/{page}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<Map<String, Object>> getList(@PathVariable("page") int page) {
		Map<String, Object> response = new HashMap<>();
		Map<String, Object> response1 = new HashMap<>();
		Map<String, Object> response2 = new HashMap<>();

		int total = service.getTotal();
		CriteriaVO cri = new CriteriaVO(page, 10);
		List<BoardDTO> getWithPage = service.getWithPaging(cri);

		PageVO pageVO = new PageVO(cri, total);

		response1.put("data", getWithPage);
		response2.put("pageDTO", pageVO);
		response2.put("total", total);

		response.put("TableData", response1);
		response.put("ListData", response2);
		log.info(cri);

		log.info(cri.getPageNum());
		log.info(service.getWithPaging(cri));

		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	// 게시판 데이터 전부 지우기
	@DeleteMapping(value = "/list")
	public void alldel(BoardDTO board) {
		log.info("All Remove Board Object");
		service.allremove(board);
	}

	// 등록 페이지
	@GetMapping(value = "/register")
	public ModelAndView viewcreate() {
		ModelAndView mav = new ModelAndView("board/register");
		return mav;
	}

	// 게시물 등록
	@PostMapping(value = "/register", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public void create(@RequestBody BoardDTO board) {
		log.info("Send Register : " + board);
		log.info(board);
		service.increase();
		service.register(board);
	}
	
	// 상세 페이지
	@GetMapping(value = "/detail/{bno}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ModelAndView detailView(@PathVariable Long bno) {
		ModelAndView mav = new ModelAndView("board/detail");
		mav.addObject("bno", bno);
		log.info("Open Detail Page : " + bno + "번");

		return mav;
	}
	
	// 상세 페이지 데이터 조회
	@GetMapping(value = "/detail/{bno}.json", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<Map<String, Object>> detail(@PathVariable("bno") Long bno) {
		Map<String, Object> response = new HashMap<>();

		BoardDTO board = service.detail(bno);
		List<FileDTO> files = service.getfiles(bno);

		response.put("board", board);
		response.put("getfiles", files);

		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	// 수정 페이지
	@GetMapping(value = "/modify/{bno}", produces = "application/text; charset=UTF-8")
	public ModelAndView modify(@PathVariable Long bno) {
		ModelAndView mav = new ModelAndView("/board/modify");
		mav.addObject("bno", bno);
		log.info("Open Modify Page : " + bno + "번");

		return mav;
	}
	
	// 수정 기능
	@PutMapping(value = "/modify/update")
	public void update(@RequestBody BoardDTO board) {
		log.info("수정 : " + board);
		service.update(board);
	}
	
	// 삭제 기능
	@DeleteMapping(value = "/modify/delete/{bno}")
	public void delete(@PathVariable Long bno) {
		log.info("삭제 : " + bno);
		service.remove(bno);
		service.fileRemove(bno);
	}
	
	// 파일 삭제
	@DeleteMapping(value = "/file/remove/{fileBno}")
	public void deleteFile(@PathVariable Long fileBno) {
		log.info("삭제 : " + fileBno);
		service.AtfileRemove(fileBno);
	}
	
	// 파일 가져오기
	@GetMapping(value = "/file/{bno}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<FileDTO>> getfiles(@PathVariable("bno") Long bno) {

		return new ResponseEntity<>(service.getfiles(bno), HttpStatus.OK);
	}

	// 파일 업로드
	@PostMapping(value = "/upload")
	public void uploadFormPost(@RequestBody MultipartFile[] uploadFile) {
		log.info("파일 데이터 : " +uploadFile);
		String uploadFolder = "D://UpLoadFile/main";
		FileDTO fileDTO = new FileDTO();

		// 업로드 폴더에 getFolder 위치 추가
		File uploadPath = new File(uploadFolder, service.getFolder());

		// 파일 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		for (MultipartFile multipartFile : uploadFile) {

			// 확장자 가져오기
			String extension = StringUtils.getFilenameExtension(multipartFile.getOriginalFilename());
			String serverName = service.makeFilename(extension);

			try {
				File saveFile = new File(uploadPath, serverName);
				fileDTO.setClientName(multipartFile.getOriginalFilename());
				fileDTO.setServerName(serverName);
				fileDTO.setPath(saveFile.toString());
				// 업로드 폴더에 이름으로 저장

				// 파일에 실질적으로 저장
				multipartFile.transferTo(saveFile);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());

			}
			log.info(fileDTO);
			
			service.registerFile(fileDTO);
		}

	};
	
	// 특정 번호에 파일 업로드
	@PostMapping(value = "/upload/file")
	public void uploadPost(@RequestBody MultipartFile[] uploadFile, Long bno) {
		log.info("업로드 지나감");
		String uploadFolder = "D://UpLoadFile/main";
		FileDTO fileDTO = new FileDTO();

		// 업로드 폴더에 getFolder 위치 추가
		File uploadPath = new File(uploadFolder, service.getFolder());

		// 파일 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		for (MultipartFile multipartFile : uploadFile) {

			// 확장자 가져오기
			String extension = StringUtils.getFilenameExtension(multipartFile.getOriginalFilename());
			String serverName = service.makeFilename(extension);

			try {
				fileDTO.setBno(bno);
				File saveFile = new File(uploadPath, serverName);
				fileDTO.setClientName(multipartFile.getOriginalFilename());
				fileDTO.setServerName(serverName);
				fileDTO.setPath(saveFile.toString());
				// 업로드 폴더에 이름으로 저장

				// 파일에 실질적으로 저장
				multipartFile.transferTo(saveFile);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());

			}
			log.info(fileDTO);
			service.registerAlterFile(fileDTO);
		}

	};
	
	// 파일 다운로드
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> download(String serverName) {
		log.info(serverName);
		List<FileDTO> file = service.getfileName(serverName);
		String path = file.get(0).getPath();
		String name = file.get(0).getClientName();

		log.info("Download File Name : " + serverName);

		Resource resource = new FileSystemResource(path);

		HttpHeaders headers = new HttpHeaders();

		try {
			headers.add("Content-Disposition",
					"attachment; filename=" + new String(name.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (Exception e) {
			// TODO: handle exception
		}
		log.info(resource);

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);

	}

};
