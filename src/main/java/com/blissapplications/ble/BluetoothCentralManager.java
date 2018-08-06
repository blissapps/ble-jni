//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.blissapplications.ble;

import java.util.UUID;

public class BluetoothCentralManager
{
	
	private long nativeCentralManagerHandle;
	
	private native long initialize();
	
	private native int getState(long nativeCentralManagerHandle);
	
	private native void startScanPeripherals(long nativeCentralManagerHandle);
	
	private native void stopScanPeripherals(long nativeCentralManagerHandle);
	
	//Only available since 10.13
	//private native boolean isScanning(long nativeCentralManagerHandle);
	
	private native void connectPeripheral(long nativeCentralManagerHandle, long nativePeripheralHandle, BluetoothConnectPeripheralOptions options);
	
	private native void cancelPeripheralConnection(long nativeCentralManagerHandle, long nativePeripheralHandle);
	
	private native void deinitialize(long nativeCentralManagerHandle);
	
	private native BluetoothPeripheral[] retrievePeripheralsWithIdentifiers(long nativeCentralManagerHandle, UUID[] identifiers);
	
	private native BluetoothPeripheral[] retrieveConnectedPeripheralsWithServices(long nativeCentralManagerHandle, UUID[] services);
	
	private BluetoothCentralManagerListener listener;
	
	public BluetoothCentralManager()
	{
		nativeCentralManagerHandle = initialize();
	}
	
	public BluetoothCentralManagerState getState()
	{
		return BluetoothCentralManagerState.fromValue(getState(nativeCentralManagerHandle));
	}
	
	public void startScanPeripherals()
	{
		startScanPeripherals(nativeCentralManagerHandle);
	}
	
	public void stopScanPeripherals()
	{
		stopScanPeripherals(nativeCentralManagerHandle);
	}
	
	//Only available since 10.13
	//public boolean isScanning(){
	//	return isScanning(nativeCentralManagerHandle);
	//}
	
	public void connectPeripheral(BluetoothPeripheral peripheral, BluetoothConnectPeripheralOptions options)
	{
		connectPeripheral(nativeCentralManagerHandle, peripheral.getNativePeripheralHandle(), options);
	}
	
	public void cancelPeripheralConnection(BluetoothPeripheral peripheral)
	{
		cancelPeripheralConnection(nativeCentralManagerHandle, peripheral.getNativePeripheralHandle());
	}
	
	public BluetoothPeripheral[] retrieveConnectedPeripheralsWithServices(UUID[] services)
	{
		return retrieveConnectedPeripheralsWithServices(nativeCentralManagerHandle, services);
	}
	
	public BluetoothPeripheral[] retrievePeripheralsWithIdentifiers(UUID[] identifiers)
	{
		return retrievePeripheralsWithIdentifiers(nativeCentralManagerHandle, identifiers);
	}
	
	public void deinitialize()
	{
		deinitialize(nativeCentralManagerHandle);
	}
	
	public void discoveredPeripheral(BluetoothPeripheral peripheral, double rssi, BluetoothPeripheralAdvertisementData advertisementData)
	{
		if (listener == null)
		{
			return;
		}
		
		listener.discoveredPeripheral(this, peripheral, rssi, advertisementData);
	}
	
	public void updatedState()
	{
		if (listener == null)
		{
			return;
		}
		
		listener.updatedState(this);
	}
	
	public void connectedPeripheral(BluetoothPeripheral peripheral)
	{
		if (listener == null)
		{
			return;
		}
		
		listener.connectedPeripheral(this, peripheral);
	}
	
	public void failedToConnectToPeripheral(BluetoothPeripheral peripheral, BluetoothException error)
	{
		if (listener == null)
		{
			return;
		}
		
		listener.failedToConnectToPeripheral(this, peripheral, error);
	}
	
	public void disconnectedPeripheral(BluetoothPeripheral peripheral, BluetoothException error)
	{
		if (listener == null)
		{
			return;
		}
		
		listener.disconnectedPeripheral(this, peripheral, error);
	}
	
	
	public void setListener(BluetoothCentralManagerListener listener)
	{
		this.listener = listener;
	}
	
	public BluetoothCentralManagerListener getListener()
	{
		return listener;
	}
	
	static
	{
		System.loadLibrary("ble-jni");
	}
}
