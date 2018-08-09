package com.taskdoc.www.controller.http;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/project")
public class Project {
	/*
	 * 2.프로젝트 메인 , 생성 , 프로젝트 멤버 초대, 프로젝트(이름, 멤버 삭제 등등,,) 수정 , 프로젝트 공지사항,
	 * 
	 */
	
	//session
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "main";
	}

	//session
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() {
		return "create";
	}

	//session
	@RequestMapping(value = "/userInvite", method = RequestMethod.GET)
	public String userInvite() {
		return "userInvite";
	}

	//session
	@RequestMapping(value = "/infoEdit", method = RequestMethod.GET)
	public String infoEdit() {
		return "infoEdit";
	}

	//session
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String notice() {
		return "notice";
	}
}
