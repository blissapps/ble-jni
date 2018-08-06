package com.blissapplications.ble;

import java.util.UUID;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 19/07/2018
 * Time: 14:27
 */
public class BluetoothService
{
	
	private BluetoothPeripheral peripheral;
	private long nativeServiceHandle;
	long getNativeServiceHandle()
	{
		return nativeServiceHandle;
	}
	
	private native boolean isPrimary(long nativeServiceHandle);
	
	private native UUID getIdentifier(long nativeServiceHandle);
	
	private native BluetoothCharacteristic[] getCharacteristics(long nativeServiceHandle);
	
	private native BluetoothService[] getIncludedServices(long nativeServiceHandle);
	
	public boolean isPrimary()
	{
		return isPrimary(nativeServiceHandle);
	}
	
	public BluetoothPeripheral getPeripheral()
	{
		return peripheral;
	}
	
	public UUID getIdentifier()
	{
		return getIdentifier(nativeServiceHandle);
	}
	
	public BluetoothCharacteristic[] getCharacteristics()
	{
		return getCharacteristics(nativeServiceHandle);
	}
	
	public BluetoothService[] getIncludedServices()
	{
		return getIncludedServices(nativeServiceHandle);
	}
	
	public BluetoothService(long nativeServiceHandle, BluetoothPeripheral peripheral)
	{
		this.nativeServiceHandle = nativeServiceHandle;
		this.peripheral = peripheral;
	}
	static
	{
		System.loadLibrary("ble-jni");
	}
}
