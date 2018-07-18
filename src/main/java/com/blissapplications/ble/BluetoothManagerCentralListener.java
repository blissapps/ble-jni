package com.blissapplications.ble;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 09/07/2018
 * Time: 21:18
 */
public interface BluetoothManagerCentralListener
{
	void discoveredPeripheral(BluetoothPeripheral peripheral, double rssi, BluetoothPeripheralAdvertisementData advertisementData);
	
	void updatedState();
}
