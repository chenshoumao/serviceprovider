package ldap.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ldap.dao.TimUserDao;
import ldap.entity.User;
import ldap.service.TimUserService;
@Service
public class TimUserServiceImpl implements TimUserService{
	@Autowired
	private TimUserDao userDao;
	 
	@Override
	public boolean updateChallengAnswer(String eruid,String password, String question, String answer) {
		// TODO Auto-generated method stub
		return this.userDao.updateChallengAnswer(eruid,password,question, answer);
	}

	public List showAccount(String eruid) {
		// TODO Auto-generated method stub
		return this.userDao.showAccount(eruid);
	}

	public String changeChallengeResponse(String username, String password,
			String answer, String confirmAnswer) {
		// TODO Auto-generated method stub
		return this.userDao.changeChallengeResponse(username,password,answer,confirmAnswer);
	}

	public void editUser(User user) {
		// TODO Auto-generated method stub
		this.userDao.editUser(user);
	}

	public String getChallengAnswer(String username) {
		// TODO Auto-generated method stub
		return userDao.getChallengAnswer(username);
	}

	public String getQuestion(String username) {
		// TODO Auto-generated method stub
		return userDao.getQuestion(username);
	}

}
