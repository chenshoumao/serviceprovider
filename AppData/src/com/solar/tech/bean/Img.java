package com.solar.tech.bean;

 
/**
 * 
 * ClassName: Img 
 * @Description: 图片信息
 * @author houhuayu
 * @date 2016-6-16
 */
public class Img {
//图片名称
private String imgName;
//图片地址
private String imgUrl;
//相册名称
private String photo;
//上传upUrl
private String upUrl;
//是否是管理员
private String isadmin;
//存放文件夹名称
private String saveFile;
public String getSaveFile() {
	return saveFile;
}
public void setSaveFile(String saveFile) {
	this.saveFile = saveFile;
}
public String getIsadmin() {
	return isadmin;
}
public void setIsadmin(String isadmin) {
	this.isadmin = isadmin;
}
public String getUpUrl() {
	return upUrl;
}
public void setUpUrl(String upUrl) {
	this.upUrl = upUrl;
}
public String getPhoto() {
	return photo;
}
public void setPhoto(String photo) {
	this.photo = photo;
}
public String getImgName() {
	return imgName;
}
public void setImgName(String imgName) {
	this.imgName = imgName;
}
public String getImgUrl() {
	return imgUrl;
}
public void setImgUrl(String imgUrl) {
	this.imgUrl = imgUrl;
}


}
