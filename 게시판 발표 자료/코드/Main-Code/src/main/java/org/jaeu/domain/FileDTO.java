package org.jaeu.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FileDTO {
	private Long fileBno;
	private Long bno;
	private String clientName;
	private String serverName;
	private String path;
	private Date createDate;
	private Date changeDate;
}
