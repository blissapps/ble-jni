package com.blissapplications.ble;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 09/07/2018
 * Time: 23:48
 */

import java.util.UUID;

/***
 * From https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerdelegate/advertisement_data_retrieval_keys?language=objc
 */
public class BluetoothPeripheralAdvertisementData
{
	public String localName;
	public byte[] manufacturerData;
	public BluetoothServiceData[] serviceData;
	public UUID[] serviceUUIDs;
	public UUID[] overflowServiceUUIDs;
	public double txPowerLevel;
	public boolean isConnectable;
	public UUID[] solicitedServiceUUIDs;
}
