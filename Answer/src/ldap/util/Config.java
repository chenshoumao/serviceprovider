package ldap.util;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;



public class Config {
	
	private Properties prop = new Properties();
	private static Config instance = new Config();
	
	private Config() {
		loadCfg();
	}
	private void loadCfg() {
		try {
			String resource = "/ldap_config.properties";
			boolean hasLeadingSlash = resource.startsWith("/");
			String stripped = hasLeadingSlash ? resource.substring(1): resource;
			InputStream in = null;
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			if (classLoader != null) {
				in = classLoader.getResourceAsStream(resource);
				if (in == null && hasLeadingSlash) {
					in = classLoader.getResourceAsStream(stripped);
				}
			}

			if (in == null) {
				in = Config.class.getClassLoader().getResourceAsStream(resource);
			}
			if (in == null && hasLeadingSlash) {
				in = Config.class.getClassLoader().getResourceAsStream(stripped);
			}

			prop.load(in);
			in.close();
			in = null;
			
		}catch (IOException e) {
			e.printStackTrace();
			System.out.println("读取ldap_config配置文件出错!");
		}
	}

	public void reLoadCfg() {
		try {
			String resource = "/ldap_config.properties";
			boolean hasLeadingSlash = resource.startsWith("/");
			String stripped = hasLeadingSlash ? resource.substring(1): resource;
			InputStream in = null;
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			if (classLoader != null) {
				in = classLoader.getResourceAsStream(resource);
				if (in == null && hasLeadingSlash) {
					in = classLoader.getResourceAsStream(stripped);
				}
			}

			if (in == null) {
				in = Config.class.getClassLoader()
						.getResourceAsStream(resource);
			}
			if (in == null && hasLeadingSlash) {
				in = Config.class.getClassLoader()
						.getResourceAsStream(stripped);
			}

			prop.load(in);
			in.close();
			in = null;
		} catch (IOException e) {
			//throw new ldap_config Exception("重新读取ldap_config.properties配置文件出错!");
		}
	}

	public String getConfigValue(String configName) {
		return getConfigValue(configName, "");
	}

	public String getConfigValue(String configName, String defaultValue) {
		String propValue = prop.getProperty(configName, defaultValue);
		if (propValue != null) {
			propValue = propValue.trim();
		}
		return propValue;
	}

	public static Config getInstance() {
		return instance;
	}
	

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Config config = getInstance();
		System.out.println(config.getConfigValue("LdapUrl"));
		System.out.println(config.getConfigValue("basedn"));
		System.out.println(config.prop.toString());
	}

}
