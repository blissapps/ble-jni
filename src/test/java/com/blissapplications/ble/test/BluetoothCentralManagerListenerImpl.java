package com.blissapplications.ble.test;

import com.blissapplications.ble.*;

import java.util.ArrayList;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 06/08/2018
 * Time: 00:30
 */
public class BluetoothCentralManagerListenerImpl implements BluetoothCentralManagerListener
{
	
	ArrayList<BluetoothPeripheral> peripherals = new ArrayList<>();
	ArrayList<BluetoothPeripheralAdvertisementData> adv = new ArrayList<>();
	
	BluetoothPeripheralListener peripheralListener = new BluetoothPeripheralListenerImpl();
	
	static byte MODE1_MAGIC_BYTE_1 = Base16.getDecoder().decode("d5")[0];
	static byte MODE1_MAGIC_BYTE_2 = Base16.getDecoder().decode("02")[0];
	
	static byte MODE2_MAGIC_BYTE_1 = Base16.getDecoder().decode("4c")[0];
	static byte MODE2_MAGIC_BYTE_2 = Base16.getDecoder().decode("00")[0];
	
	@Override
	public void discoveredPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral, double rssi, BluetoothPeripheralAdvertisementData advertisementData)
	{
		if(!shouldInteractWithPeripheral(peripheral, advertisementData)){
			return;
		}
		centralManager.stopScanPeripherals();
		peripherals.add(peripheral);
		peripheral.setListener(peripheralListener);
		System.out.printf("Got Peripheral: %s (%f dB) <%s>\n", peripheral.getIdentifier(), rssi, advertisementData.localName);
		System.out.printf("Manufacturer Data(%d): [%s]\n", advertisementData.manufacturerData.length, Base16.getUpperEncoder().encode(advertisementData.manufacturerData));
		System.out.printf("Service Data: [%d]\n", advertisementData.serviceData.length);
		for (BluetoothServiceData serviceData : advertisementData.serviceData)
		{
			System.out.printf("Service [%s]\n", serviceData);
		}
		BluetoothPeripheralState state = peripheral.getState();
		System.out.printf("Peripheral state: [%s]\n", state);
		if (state == BluetoothPeripheralState.Disconnected)
		{
			BluetoothConnectPeripheralOptions options = new BluetoothConnectPeripheralOptions();
			options.notifyOnDisconnection = true;
			
			centralManager.connectPeripheral(peripheral, options);
			state = peripheral.getState();
			System.out.printf("Peripheral state after connect: [%s]\n", state);
		}
	}
	
	private boolean shouldInteractWithPeripheral(BluetoothPeripheral peripheral, BluetoothPeripheralAdvertisementData advertisementData)
	{
		byte[] manufacturerData = advertisementData.manufacturerData;
		int manufacturerDataLength = manufacturerData.length;
		if(manufacturerDataLength < 2)
		{
			return false;
		}
		return (manufacturerData[0] == MODE1_MAGIC_BYTE_1 && manufacturerData[1] == MODE1_MAGIC_BYTE_2) ||
			(manufacturerData[0] == MODE2_MAGIC_BYTE_1 && manufacturerData[1] == MODE2_MAGIC_BYTE_2);
	}
	
	@Override
	public void updatedState(BluetoothCentralManager centralManager)
	{
		BluetoothCentralManagerState state = centralManager.getState();
		System.out.printf("State updated: %s\n", state);
		if(state == BluetoothCentralManagerState.PoweredOn) {
			centralManager.startScanPeripherals();
		}
	}
	
	@Override
	public void connectedPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral)
	{
		BluetoothPeripheralState state = peripheral.getState();
		System.out.printf("Connected peripheral: %s - %s\n", peripheral.getIdentifier(), state);
		peripheral.discoverServices();
	}
	
	@Override
	public void failedToConnectToPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral, BluetoothException error)
	{
		System.out.printf("Failed to connect to peripheral: %s - %s\n", peripheral.getIdentifier(), error.getMessage());
		peripherals.remove(peripheral);
	}
	
	@Override
	public void disconnectedPeripheral(BluetoothCentralManager centralManager, BluetoothPeripheral peripheral, BluetoothException error)
	{
		String message = error != null ? error.getMessage() : "No error";
		System.out.printf("Disconnected peripheral: %s - %s\n", peripheral.getIdentifier(), message);
		peripherals.remove(peripheral);
	}
	
}
