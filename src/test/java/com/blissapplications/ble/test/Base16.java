package com.blissapplications.ble.test;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 11/07/2018
 * Time: 23:38
 */
public class Base16 {
	public static class Encoder{
		private static char[] toLowerHex={'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
		private static char[] toUpperHex={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
		private boolean upper;
		public Encoder(boolean upper) {
			this.upper=upper;
		}
		public String encode(byte[] data){
			char[] value=new char[data.length*2];
			char[] toHex=upper?toUpperHex:toLowerHex;
			for(int i=0,j=0;i<data.length;i++){
				int octet=data[i]&0xFF;
				value[j++]=toHex[octet>>4];
				value[j++]=toHex[octet&0xF];
			}
			return new String(value);
		}
		static final Encoder LOWER=new Encoder(false);
		static final Encoder UPPER=new Encoder(true);
	}
	public static Encoder getEncoder(){
		return Encoder.LOWER;
	}
	public static Encoder getUpperEncoder(){
		return Encoder.UPPER;
	}
	//...
}
