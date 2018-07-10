package com.blissapplications.ble;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 09/07/2018
 * Time: 16:22
 */
public enum BluetoothCentralManagerState
{
	Unknown(0),
	Resetting(1),
	Unsupported(2),
	Unauthorized(3),
	PoweredOff(4),
	PoweredOn(5);
	
	private final int value;
	
	private BluetoothCentralManagerState(int value)
	{
		this.value = value;
	}
	
	public static BluetoothCentralManagerState fromValue(int value)
	{
		if (value == Unknown.value)
		{
			return Unknown;
		}
		
		if (value == Resetting.value)
		{
			return Resetting;
		}
		
		if (value == Unsupported.value)
		{
			return Unsupported;
		}
		
		if (value == Unauthorized.value)
		{
			return Unauthorized;
		}
		
		if (value == PoweredOff.value)
		{
			return PoweredOff;
		}
		
		if (value == PoweredOn.value)
		{
			return PoweredOn;
		}
		
		return Unknown;
	}
}
