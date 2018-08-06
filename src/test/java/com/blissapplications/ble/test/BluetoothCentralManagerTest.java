package com.blissapplications.ble.test;

import com.blissapplications.ble.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;

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
		final BluetoothCentralManager manager = new BluetoothCentralManager();
		manager.setListener(new BluetoothCentralManagerListenerImpl());
		BluetoothCentralManagerState state = manager.getState();
		if(state == BluetoothCentralManagerState.PoweredOn)
		{
			manager.startScanPeripherals();
		}
		
		Thread.sleep(240000);
		
		manager.stopScanPeripherals();
		
		
		
		manager.deinitialize();
	}
}