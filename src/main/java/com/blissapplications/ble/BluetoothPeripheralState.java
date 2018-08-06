package com.blissapplications.ble;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 05/08/2018
 * Time: 20:20
 */
public enum BluetoothPeripheralState
{
	Unknown(-1),
	Disconnected(0),
	Connecting(1),
	Connected(2);
	//Only in 10.13
	//Disconnecting
	
	private final int value;
	
	BluetoothPeripheralState(int value)
	{
		this.value = value;
	}
	
	public static BluetoothPeripheralState fromValue(int value)
	{
		if (value == Disconnected.value)
		{
			return Disconnected;
		}
		
		if (value == Connecting.value)
		{
			return Connecting;
		}
		
		if (value == Connected.value)
		{
			return Connected;
		}
		
		return Unknown;
	}
}
