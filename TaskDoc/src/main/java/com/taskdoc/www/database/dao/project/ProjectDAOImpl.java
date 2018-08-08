package com.taskdoc.www.database.dao.project;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.ProjectVO;

@Repository
public class ProjectDAOImpl implements ProjectDAO {
	
	private final String NAMESPACE = "project_SQL.";
	private final String INSERT = "insert";
	private final String VIEW = "view";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	
	@Autowired
	SqlSession sql;

	@Override
	public ProjectVO projectView(int pcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, pcode);
	}

	@Override
	public int projectInsert(ProjectVO project) {
		// TODO Auto-generated method stub
		return sql.insert(NAMESPACE + INSERT, project);
	}

	@Override
	public int projectUpdate(ProjectVO project) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, project);
	}

	@Override
	public int projectDelete(int pcode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, pcode);
	}
}