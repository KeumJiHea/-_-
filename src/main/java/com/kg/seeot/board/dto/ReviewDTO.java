package com.kg.seeot.board.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReviewDTO {
private String reviewDate, reviewFile, reviewContent;
private String memberId;
private int reviewStar=1, productNo;
public String getReviewDate() {
	return reviewDate;
}
/*
public void setReviewDate(String reviewDate) {
	this.reviewDate = reviewDate;
}
*/
public void setReviewDate(Timestamp  reviewDate) {
	SimpleDateFormat s = 
			new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
	this. reviewDate = s.format( reviewDate );
}


public String getReviewFile() {
	return reviewFile;
}
public void setReviewFile(String reviewFile) {
	this.reviewFile = reviewFile;
}
public String getReviewContent() {
	return reviewContent;
}
public void setReviewContent(String reviewContent) {
	this.reviewContent = reviewContent;
}
public String getMemberId() {
	return memberId;
}
public void setMemberId(String memberId) {
	this.memberId = memberId;
}
public int getReviewStar() {
	return reviewStar;
}
public void setReviewStar(int reviewStar) {
	this.reviewStar = reviewStar;
}
public int getProductNo() {
	return productNo;
}
public void setProductNo(int productNo) {
	this.productNo = productNo;
}
}
