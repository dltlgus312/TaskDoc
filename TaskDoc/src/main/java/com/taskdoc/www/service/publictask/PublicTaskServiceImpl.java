package com.taskdoc.www.service.publictask;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.privatetask.PrivateTaskDAO;
import com.taskdoc.www.database.dao.publictask.PublicTaskDAO;
import com.taskdoc.www.database.dto.PrivateTaskVO;
import com.taskdoc.www.database.dto.PublicTaskVO;

@Service("PublicTaskService")
public class PublicTaskServiceImpl implements PublicTaskService{

	@Autowired
	PublicTaskDAO dao;
	
	@Autowired
	PrivateTaskDAO privateDao;

	@Override
	public List<PublicTaskVO> publicTaskList(int pcode) {
		// TODO Auto-generated method stub
		return dao.publicTaskList(pcode);
	}
	
	@Override
	@Transactional
	public Map<String, Object> publicTaskAllList(int pcode, String uid) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		
		List<PublicTaskVO> pVos = publicTaskList(pcode);
		List<List<PrivateTaskVO>> ptVos = new ArrayList<>();
		
		for(PublicTaskVO vo : pVos) {
			ptVos.add(privateDao.privateTaskList(vo.getTcode(), uid));
		}
		
		map.put("publicTaskList", pVos);
		map.put("privateTaskList", ptVos);
		return map;
	}

	@Override
	@Transactional
	public int publicTaskInsert(PublicTaskVO publicTaskVo) {
		// TODO Auto-generated method stub
		int tcode = 0;
		Integer sequenceMax = null;
		
		tcode = dao.publicTaskInsert(publicTaskVo);
		if(publicTaskVo.getTrefference() == 0) {
			// refference
			publicTaskVo.setTrefference(tcode);
			sequenceMax = dao.selfRefMax(publicTaskVo.getPcode());
		}else {
			// sequence
			sequenceMax = dao.sameRefMax(publicTaskVo.getTrefference());
		}
		
		publicTaskVo.setTsequence(sequenceMax == null ? 1 : sequenceMax + 1);
		
		dao.publicTaskUpdate(publicTaskVo);
		return tcode;
	}

	@Override
	public int publicTaskUpdate(PublicTaskVO publicTaskVo) {
		// TODO Auto-generated method stub
		return dao.publicTaskUpdate(publicTaskVo);
	}

	@Override
	public int publicTaskDelete(int tcode) {
		// TODO Auto-generated method stub
		return dao.publicTaskDelete(tcode);
	}

}
