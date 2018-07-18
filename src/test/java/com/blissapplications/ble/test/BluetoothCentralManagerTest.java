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
				System.out.printf("Got Peripheral: %s (%f dB) <%s>\n", peripheral.getIdentifier(), rssi, advertisementData.localName);
				System.out.printf("Manufacturer Data: [%s]\n", Base16.getUpperEncoder().encode(advertisementData.manufacturerData));
				System.out.printf("Service Data: [%d]\n", advertisementData.serviceData.length);
				if("Env".equals(advertisementData.localName)){
					for (BluetoothServiceData serviceData: advertisementData.serviceData)
					{
						System.out.printf("Service [%s]: [%s]\n", serviceData.serviceUUID, Base16.getUpperEncoder().encode(advertisementData.manufacturerData));
					}
				}
			}
		});
		BluetoothCentralManagerState state = manager.getState();
		manager.startScanPeripherals();
		
		Thread.sleep(40000);
		
		manager.stopScanPeripherals();
		
		manager.deinitialize();
	}
}