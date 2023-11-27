package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class FavoritePage {
	private int favoritePageKeyNum;
	private String favoritePageId;
	private String favoritePageUrl;
	private String favoritePageDate;
	private String favoritePageName;
	private String favoritePageIp;
	private String favoritePageRegistrant;
	private String favoritePageRegistrationDate;
	private String favoritePageModifier;
	private String favoritePageModifiedDate;
}
