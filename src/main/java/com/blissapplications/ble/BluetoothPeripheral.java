package com.blissapplications.ble;

import java.util.UUID;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 09/07/2018
 * Time: 21:13
 */
public class BluetoothPeripheral
{
	private long nativeCentralManagerHandle;
	
	private native String getIdentifier(long nativeCentralManagerHandle);
	
	public BluetoothPeripheral(long nativeCentralManagerHandle)
	{
		this.nativeCentralManagerHandle = nativeCentralManagerHandle;
	}
	
	public UUID getIdentifier()
	{
		return UUID.fromString(getIdentifier(nativeCentralManagerHandle));
	}
	
	static
	{
		System.loadLibrary("ble-jni");
	}
}