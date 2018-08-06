package com.blissapplications.ble;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 09/07/2018
 * Time: 21:18
 */
public interface BluetoothCentralManagerListener
{
	void discoveredPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral, double rssi, BluetoothPeripheralAdvertisementData advertisementData);
	
	void updatedState(BluetoothCentralManager centralManager);
	
	void connectedPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral);
	
	void failedToConnectToPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral, BluetoothException error);
	
	void disconnectedPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral, BluetoothException error);
}
