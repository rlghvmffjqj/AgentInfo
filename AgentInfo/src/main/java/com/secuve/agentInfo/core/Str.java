package com.secuve.agentInfo.core;

import java.util.ArrayList;
import java.util.List;

public class Str {
	
	public static final String BLANK = "";

	public static final String NULL = "null";
	
	public static boolean equalsOnly(String value, String validStrings) {
		String[] validList = validStrings.split(",");
		
		for (String validstr : validList)
		{
			if ( validstr.equals(value) )
				return true;
		}
		
		return false;
	}
	
	public static String toCSV(String ... array)
	{
		StringBuffer buf = new StringBuffer();

		for (int i=0; i < array.length; i++)
		{
			String token = array[i];
			if ( token == null ) {
				token = "";
			}
			
			token = token.trim();

			if ( token.indexOf(',') > -1 ) {
				token = String.format("\"%s\"", token);
			}
			
			buf.append(token);

			if ( i < array.length -1 ) {
				buf.append(',');
			}
		}
		
		return buf.toString();
	}
	
	public static String toCSV(List<String> list)
	{
		String[] array = list.toArray(new String[0]);
		return toCSV(array);
	}
	
	public static String[] splitCSV(String line)
	{
		return splitQuotedString(line, ',', '"');
	}
	
	public static String[] splitQuotedString(String line, char del, char quote)
	{
		ArrayList<String> tokens = new ArrayList<String>();
		StringBuffer buf = new StringBuffer();
		String token;
		
		boolean isQuoted = false;
		char[] array = line.toCharArray();
		char c, n;
		for (int pos=0; pos < array.length; pos++)
		{
			c = array[pos];
			if ( isQuoted )
			{
				if ( c == quote ) {
					n = (pos+1 < array.length ? array[pos+1] : 0);
					if ( n == quote ) {
						pos++;
						buf.append(n);
					} else {
						isQuoted = false;
					}
				} else {
					buf.append(c);
				}
			}
			else
			{
				if ( c == quote ) {
					isQuoted = true;
				} else if ( c == del ) {
					token = buf.toString();
					tokens.add(token);
					buf.setLength(0);
				} else {
					buf.append(c);
				}
			}
		}
		
		token = buf.toString();
		tokens.add(token);
		
		return (String[])tokens.toArray(new String[0]);
	}
	
	public static boolean isNullOrEmpty(String string) 
	{
		boolean boolRtn = false;
		if (string == null)
		{
			boolRtn = true;
		}
		else
		{
			if ((string.trim().equals(NULL)) || (string.trim().equals(BLANK)))
			{
				boolRtn = true;
			}
			else
			{
				boolRtn = false;
			}
		}
		return boolRtn;
	}
}