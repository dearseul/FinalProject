package pms.dao;
//pms.dao.RiskDao
import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import pms.dto.RiskBoard;

@Repository
public interface RiskDao {
	public ArrayList<RiskBoard> rBoard();
	public ArrayList<RiskBoard> rBoard_request();
	public void insertBoard(RiskBoard insert);
	
}
