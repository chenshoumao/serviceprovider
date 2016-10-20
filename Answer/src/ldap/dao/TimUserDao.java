package ldap.dao;

import java.util.List;
import java.util.Map;

import javax.naming.NamingEnumeration;
import javax.naming.NamingException;

 







import ldap.entity.User;

import org.springframework.stereotype.Repository;


@Repository
public interface TimUserDao {
	 
	public List getUserInfo(String eruid);

	public boolean updateChallengAnswer(String username,String question, String answer);

	public List showAccount(String eruid);
	
	public boolean uodatePassword(String eruid);

	public String changeChallengeResponse(String username, String password,
			String answer, String confirmAnswer);

	public void editUser(User user);

	public String getChallengAnswer(String username);

	public String getQuestion(String username);
}
