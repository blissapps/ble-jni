package com.blissapplications.ble;

import java.util.UUID;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 09/07/2018
 * Time: 21:13
 */
public class BluetoothPeripheral
{
	
	private long nativePeripheralHandle;
	private BluetoothPeripheralListener listener;
	
	// JNI Methods
	
	private native UUID getIdentifier(long nativePeripheralHandle);
	
	private native String getName(long nativePeripheralHandle);
	
	private native void discoverServices(long nativePeripheralHandle, UUID[] serviceUUIDs);
	
	private native void discoverIncludedServices(long nativePeripheralHandle, UUID[] serviceUUIDs, long nativeServiceHandle);
	
	private native BluetoothService[] getServices(long nativePeripheralHandle);
	
	private native void discoverCharacteristicsForService(long nativePeripheralHandle, UUID[] characteristicUUIDs, long nativeServiceHandle);
	
	private native void discoverDescriptors(long nativePeripheralHandle, BluetoothCharacteristic characteristic);
	
	private native void readValueForCharacteristic(long nativePeripheralHandle, BluetoothCharacteristic characteristic);
	
	private native void readValueForDescriptor(long nativePeripheralHandle, BluetoothDescriptor descriptor);
	
	private native void writeValueForCharacteristic(long nativePeripheralHandle, byte[] data, BluetoothCharacteristic characteristic, BluetoothCharacteristicWriteType type);
	
	private native void writeValueForDescriptor(long nativePeripheralHandle, byte[] data, BluetoothDescriptor descriptor);
	
	private native void setNotifyValueForCharacteristic(long nativePeripheralHandle, BluetoothCharacteristic characteristic);
	
	private native int getState(long nativePeripheralHandle);
	
	private native void readRSSI(long nativePeripheralHandle);
	
	private native boolean canSendWriteWithoutResponse(long nativePeripheralHandle);
	
	private native long maximumWriteValueLengthForCharacteristic(long nativePeripheralHandle, BluetoothCharacteristicWriteType characteristic);
	
	// Constructor
	
	public BluetoothPeripheral(long nativePeripheralHandle)
	{
		this.nativePeripheralHandle = nativePeripheralHandle;
	}
	
	// Public contract
	
	public String getName()
	{
		return getName(nativePeripheralHandle);
	}
	
	public UUID getIdentifier()
	{
		return getIdentifier(nativePeripheralHandle);
	}
	
	public void discoverServices()
	{
		discoverServices(new UUID[]{});
	}
	
	public void discoverServices(UUID[] serviceUUIDs)
	{
		discoverServices(nativePeripheralHandle, serviceUUIDs);
	}
	
	public void discoveredServices(BluetoothException error)
	{
		if (listener == null)
		{
			return;
		}
		
		listener.discoveredServices(this, error);
	}
	
	public void discoverIncludedServices(UUID[] serviceUUIDs, BluetoothService service)
	{
		discoverIncludedServices(nativePeripheralHandle, serviceUUIDs, service.getNativeServiceHandle());
	}
	
	public BluetoothService[] getServices()
	{
		return getServices(nativePeripheralHandle);
	}
	
	public void discoverCharacteristicsForService(UUID[] characteristicUUIDs, BluetoothService service)
	{
		discoverCharacteristicsForService(nativePeripheralHandle, characteristicUUIDs, service.getNativeServiceHandle());
	}
	
	public void discoveredCharacteristicsForService(BluetoothService service, BluetoothException error)
	{
		if (listener == null)
		{
			return;
		}
		
		listener.discoveredCharacteristicsForService(this, service, error);
	}
	
	public void discoverDescriptors(BluetoothCharacteristic characteristic)
	{
		discoverDescriptors(nativePeripheralHandle, characteristic);
	}
	
	public void readValueForCharacteristic(BluetoothCharacteristic characteristic)
	{
		readValueForCharacteristic(nativePeripheralHandle, characteristic);
	}
	
	public void readValueForDescriptor(BluetoothDescriptor descriptor)
	{
		readValueForDescriptor(nativePeripheralHandle, descriptor);
	}
	
	public void writeValueForCharacteristic(byte[] data, BluetoothCharacteristic characteristic, BluetoothCharacteristicWriteType type)
	{
		writeValueForCharacteristic(nativePeripheralHandle, data, characteristic, type);
	}
	
	public void writeValueForDescriptor(byte[] data, BluetoothDescriptor descriptor)
	{
		writeValueForDescriptor(nativePeripheralHandle, data, descriptor);
	}
	
	public void setNotifyValueForCharacteristic(BluetoothCharacteristic characteristic)
	{
		setNotifyValueForCharacteristic(nativePeripheralHandle, characteristic);
	}
	
	public BluetoothPeripheralState getState()
	{
		return BluetoothPeripheralState.fromValue(getState(nativePeripheralHandle));
	}
	
	public void readRSSI()
	{
		readRSSI(nativePeripheralHandle);
	}
	
	public boolean canSendWriteWithoutResponse()
	{
		return canSendWriteWithoutResponse(nativePeripheralHandle);
	}
	
	public long maximumWriteValueLengthForCharacteristic(BluetoothCharacteristicWriteType characteristic)
	{
		return maximumWriteValueLengthForCharacteristic(nativePeripheralHandle, characteristic);
	}
	
	//Getters and Setters
	
	long getNativePeripheralHandle()
	{
		return nativePeripheralHandle;
	}
	
	public void setListener(BluetoothPeripheralListener listener)
	{
		this.listener = listener;
	}
	
	public BluetoothPeripheralListener getListener()
	{
		return listener;
	}
	
	static
	{
		System.loadLibrary("ble-jni");
	}
}
