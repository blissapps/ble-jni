package com.blissapplications.ble;

import java.util.UUID;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 19/07/2018
 * Time: 15:16
 */
public class BluetoothCharacteristic
{
	private BluetoothService service;
	private long nativeCharacteristicHandle;
	
	private native UUID getIdentifier(long nativeCharacteristicHandle);
	
	private native byte[] getValue(long nativeCharacteristicHandle);
	
	private native BluetoothCharacteristicProperties getProperties(long nativeCharacteristicHandle);
	
	private native BluetoothDescriptor[] getDescriptors(long nativeCharacteristicHandle);
	
	private native boolean isNotifying(long nativeCharacteristicHandle);
	
	public BluetoothCharacteristic(long nativeCharacteristicHandle, BluetoothService service)
	{
		this.nativeCharacteristicHandle = nativeCharacteristicHandle;
		this.service = service;
	}
	
	public UUID getIdentifier()
	{
		return getIdentifier(nativeCharacteristicHandle);
	}
	
	public byte[] getValue()
	{
		return getValue(nativeCharacteristicHandle);
	}
	
	public BluetoothCharacteristicProperties getProperties()
	{
		return getProperties(nativeCharacteristicHandle);
	}
	
	public BluetoothDescriptor[] getDescriptors(){
		return getDescriptors(nativeCharacteristicHandle);
	}
	
	public boolean isNotifying(){
		return isNotifying(nativeCharacteristicHandle);
	}
}
