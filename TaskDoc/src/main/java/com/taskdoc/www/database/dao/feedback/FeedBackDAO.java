package com.taskdoc.www.database.dao.feedback;

import java.util.List;

import com.taskdoc.www.database.dto.FeedBackVO;

public interface FeedBackDAO {
	public List<FeedBackVO> feedBackList(int dmcode);
	public FeedBackVO feedBackView(int fbcode);
	public int feedBackInsert(FeedBackVO feedBack);
	public int feedBackUpdate(FeedBackVO feedBack);
	public int feedBackDelete(FeedBackVO feedBack);
}
