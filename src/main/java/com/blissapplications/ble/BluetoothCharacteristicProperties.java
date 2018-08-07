package com.blissapplications.ble;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 19/07/2018
 * Time: 17:22
 */
public class BluetoothCharacteristicProperties
{
	public boolean canBroadcast;
	public boolean canRead;
	public boolean canBeWrittenWithoutResponse;
	public boolean canBeWritten;
	public boolean canNotify;
	public boolean canIndicate;
	public boolean authenticatedSignedWrites;
	public boolean hasExtendedProperties;
	public boolean indicateEncryptionRequired;
	public boolean notifyEncryptionRequired;

	@Override
	public String toString() {
		String formatString =   "B - R - WR - W - N - I - A - E - IE - NE\n" +
								"b - r - wr - w - n - i - a - e - ie - ne";

		formatString = formatString.replace("b", formatBool(canBroadcast));
		formatString = formatString.replace("wr", formatBool(canBeWrittenWithoutResponse) + " ");
		formatString = formatString.replace("ne", formatBool(notifyEncryptionRequired) + " ");
		formatString = formatString.replace("ie", formatBool(indicateEncryptionRequired) + " ");
		formatString = formatString.replace("r", formatBool(canRead));
		formatString = formatString.replace("w", formatBool(canBeWritten));
		formatString = formatString.replace("n", formatBool(canNotify));
		formatString = formatString.replace("i", formatBool(canIndicate));
		formatString = formatString.replace("a", formatBool(authenticatedSignedWrites));
		formatString = formatString.replace("e", formatBool(hasExtendedProperties));

		return formatString;
	}

	private String formatBool(boolean value){
		return value ? "Y" : "N";
	}
}
