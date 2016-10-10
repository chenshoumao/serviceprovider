package com.solar.tech.util;

import com.solar.tech.bean.AbstractUser;
import com.solar.tech.bean.AbstractUser.UserStatus;
import com.solar.tech.bean.User;
import com.solar.tech.dao.IDao;
import java.util.List;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;

public class ZhongxingRealm extends AbstractRealm
{

	
	
  protected AuthenticationInfo _doGetAuthenticationInfo(AuthenticationToken token)
  {
    UsernamePasswordToken _token = (UsernamePasswordToken)token;
    String username = _token.getUsername();
    String password = String.valueOf(_token.getPassword());
    User user = new User();
    user.setUserName(username);
    List users = getDao().findExample(user);
    if (users.size() == 0) {
      throw new AuthenticationException(Error.USR_NOT_EXIST(username));
    }
    user = (User)users.get(0);
    if ("WEBMEMB".equals(user.getUserClass()))
      throw new AuthenticationException(Error.USR_NOT_EXIST(username));
    if (!Current.md5(password).equals(user.getPassword()))
      throw new AuthenticationException(Error.PASSWORD(username));
    if (AbstractUser.UserStatus.FRZ.equals(user.getUserStatus())) {
      throw new AuthenticationException(Error.USR_FRZ(username));
    }
    SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, password.toCharArray(), user.getUserName());
    return info;
  }
}

