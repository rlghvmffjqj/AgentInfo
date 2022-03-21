package com.secuve.agentInfo.core;

import java.util.ArrayList;
import java.util.List;

//import org.apache.commons.lang.StringUtils;


public class Str {
	
	/** BLANK ���� */
	public static final String BLANK = "";

	/** NULL ���� */
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
	
	// perl join() �Լ� ����
	// StringUtils.join ���� �ٲ�� ��

	// StringUtils.join ���� �ٲ�� ��
//	@Deprecated
//	public static String join(char del, List<String> list)
//	{
//		return StringUtils.join(list, del);
//	}

	// 20140331 csv ��� ��������/�ҷ������ ���������͸� �״�� �����ϰ�
	// ���� ȣȯ�� ���ؼ� Ư�����ڳ� 0���� �����ϴ� ���� ó���ϴ� �κ��� ��ǥ���� ����
	public static String toCSV(String ... array)
	{
		StringBuffer buf = new StringBuffer();

		for (int i=0; i < array.length; i++)
		{
			String token = array[i];
			if ( token == null ) {
				token = "";
			}
			
			// �ܾ��� �� ���� �ڵ�����.
			// ����) ���� ���ڿ��� �������� �� �� �ֱ��ѵ�...
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
	
	// ��ɾ� �Է� ����(�Ǵ� CSV����)�� ���ڿ��� �Ľ�
	// - , �� ���Ե� ���ڿ��� " �� ���´�.
	// - ù ���ڰ� + �̸� { } �� ���´�
	//
	// TODO: " �� ó���� ���� �ִ°͸� �����ؾ� �ϴµ�, ������ �߰��� ���Ե� " �� �����ϰ� �ִ� ����
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
	
	/*
	// 20140328 CSV ������ �� Excel �� ������ �� ǥ�õ��� �ʴ� ���ڵ��� ó�����ش�.
	private static String escapeExcel(String token) {
		// +, -, %, =, 0 ���� �����ϴ� ���ڿ��� =" " �� ���´�.
		if ( token.startsWith("+") || token.startsWith("-") || token.startsWith("%") || token.startsWith("=") || token.startsWith("0") ) {
			token = String.format("=\"%s\"", token);
		}
		// ���ڿ��� , �� �����ϰ� �ִٸ� " " �� ���Ѵ�.
		else if ( token.indexOf(',') > -1 ) {
			token = String.format("\"%s\"", token);
		}
		
		return token;
	}

	private static String unescapeExcel(String token) {
		// =+, =-, =%, ==, =0 ���� �����ϸ� = �� �����Ѵ�.
		if ( token.startsWith("=+") || token.startsWith("=-") || token.startsWith("=%") || token.startsWith("==") || token.startsWith("=0") ) {
			token = token.substring(1, token.length());
		}
		// =" " �� ���������� Ǯ���ش�
		else if ( token.startsWith("=\"") && token.endsWith("\"") ) {
			token = token.substring(2, token.length()-1);
		}
		
		return token;
	}
	
	@Test
	public void test1() {
		String[] tokens1 = {"+Everyone", "123,456","-abc","%123","=abc","001"};
		String line1 = toCSV(tokens1);
		//String line2 = "=\"+Everyone\",\"123,456\",=\"-abc\",=\"%123\",=\"=abc\",=\"001\"";
		String[] tokens2 = splitCSV(line1);
	}
	*/

	/**
	* ��Ʈ�� ���ռ� �˻� ��ƿ��Ƽ �޼ҵ�
	* ��Ʈ���� null�̰ų� �� ��Ʈ������ ���θ� �Ǵ��Ѵ�.

	* @param string üũ�� ��Ʈ��
	* @return true ��Ʈ���� null�� ���; flase ��Ʈ���� null�� �ƴ� ���
	*/
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
