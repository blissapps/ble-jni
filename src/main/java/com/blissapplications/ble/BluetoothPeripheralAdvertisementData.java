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
	byte[] manufacturerData;
	BluetoothServiceData[] serviceData;
	UUID[] serviceUUIDs;
	UUID[] overflowServiceUUIDs;
	double txPowerLevel;
	boolean isConnectable;
	UUID[] solicitedServiceUUIDs;
}
