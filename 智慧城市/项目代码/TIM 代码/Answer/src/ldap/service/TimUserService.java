package ldap.service;

import java.util.List;
import java.util.Map;

import ldap.dao.TimUserDao;
import ldap.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

 @Service
public interface TimUserService { 
	public boolean updateChallengAnswer(String eruid);
	
	public List showAccount(String eruid);
	
	public String changeChallengeResponse(String username, String password,
			String answer, String confirmAnswer);
}
