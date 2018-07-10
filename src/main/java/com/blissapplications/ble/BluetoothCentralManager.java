//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.blissapplications.ble;

public class BluetoothCentralManager
{
	
	private long nativeCentralManagerHandle;
	
	private native long initialize();
	
	private native int getState(long nativeCentralManagerHandle);
	
	private native void startScanPeripherals(long nativeCentralManagerHandle);
	
	private native void stopScanPeripherals(long nativeCentralManagerHandle);
	
	private native void deinitialize(long nativeCentralManagerHandle);
	
	private BluetoothManagerCentralListener listener;
	
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
		
		listener.discoveredPeripheral(peripheral, rssi, advertisementData);
	}
	
	public void setListener(BluetoothManagerCentralListener listener)
	{
		this.listener = listener;
	}
	
	public BluetoothManagerCentralListener getListener()
	{
		return listener;
	}
	
	static
	{
		System.loadLibrary("ble-jni");
	}
}
