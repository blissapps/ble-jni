package com.blissapplications.ble.test;

import com.blissapplications.ble.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 08/07/2018
 * Time: 16:41
 */
public class BluetoothCentralManagerTest
{
	
	@Before
	public void setUp() throws Exception
	{
	
	}
	
	@After
	public void tearDown() throws Exception
	{
	}
	
	@Test
	public void initializeTest() throws InterruptedException
	{
		BluetoothCentralManager manager = new BluetoothCentralManager();
		manager.setListener(new BluetoothManagerCentralListener()
		{
			@Override
			public void discoveredPeripheral(BluetoothPeripheral peripheral, double rssi, BluetoothPeripheralAdvertisementData advertisementData)
			{
				System.out.printf("Got Peripheral: %s (%f dB)\n", peripheral.getIdentifier(), rssi);
			}
		});
		BluetoothCentralManagerState state = manager.getState();
		manager.startScanPeripherals();
		
		Thread.sleep(10000);
		
		manager.stopScanPeripherals();
		
		manager.deinitialize();
	}
}