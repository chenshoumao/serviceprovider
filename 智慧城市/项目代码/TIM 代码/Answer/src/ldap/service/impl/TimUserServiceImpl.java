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
	public boolean updateChallengAnswer(String eruid) {
		// TODO Auto-generated method stub
		return this.userDao.updateChallengAnswer(eruid);
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

}
