package com.blissapplications.ble;


import java.util.UUID;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 10/07/2018
 * Time: 00:01
 */
public class BluetoothServiceData
{
	
	public UUID serviceUUID;
	public byte[] data;
	
	@Override
	public String toString()
	{
		return String.format("Service: %s -> %s", serviceUUID, Base16.getEncoder().encode(data));
	}
}
