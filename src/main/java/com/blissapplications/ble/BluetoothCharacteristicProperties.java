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
}
