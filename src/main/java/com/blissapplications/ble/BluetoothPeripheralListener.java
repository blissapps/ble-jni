package com.blissapplications.ble;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 19/07/2018
 * Time: 11:47
 */
public interface BluetoothPeripheralListener
{
	void discoveredServices(BluetoothPeripheral peripheral, BluetoothException error);
	void discoveredIncludedServicesForService(BluetoothPeripheral peripheral, BluetoothService service, BluetoothException error);
	
	void discoveredCharacteristicsForService(BluetoothPeripheral peripheral, BluetoothService service, BluetoothException error);
	void discoveredDescriptorsForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error);
	
	void updatedValueForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error);
	void updatedValueForDescriptor(BluetoothPeripheral peripheral, BluetoothDescriptor descriptor, BluetoothException error);
	
	void wroteValueForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error);
	void wroteValueForDescriptor(BluetoothPeripheral peripheral, BluetoothDescriptor descriptor, BluetoothException error);
	
	void updatedNotificationStateForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error);
	
	void updatedRSSI(BluetoothPeripheral peripheral, BluetoothException error);
	
	void updatedName(BluetoothPeripheral peripheral);
	
	void modifiedServices(BluetoothPeripheral peripheral, BluetoothService[] services);

	//to.13 Only
	//void isReadyToSendWriteWithoutResponse(BluetoothPeripheral peripheral);
}
