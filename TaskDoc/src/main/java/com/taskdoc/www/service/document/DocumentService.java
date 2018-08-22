package com.taskdoc.www.service.document;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.taskdoc.www.database.dto.DocumentVO;

public interface DocumentService {
	public List<DocumentVO> taskList(int tcode);
	public List<DocumentVO> roomList(int crcode);
	public int fileUpload(MultipartFile[] multipartFile, DocumentVO documentVo);
	public int documentMove(DocumentVO documentVo);
	public int documentCopy(DocumentVO documentVo);
	public int documentUpdate(DocumentVO documentVo);
	public int documentDelete(int dmcode);
}
