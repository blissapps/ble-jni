package com.blissapplications.ble.test;

import com.blissapplications.ble.*;

import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;
import java.util.concurrent.Callable;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 06/08/2018
 * Time: 00:32
 */
public class BluetoothPeripheralListenerImpl implements BluetoothPeripheralListener
{
	
	@Override
	public void discoveredServices(BluetoothPeripheral peripheral, BluetoothException error)
	{
		BluetoothService[] services = peripheral.getServices();
		
		for (BluetoothService service : services)
		{
			System.out.printf("Discovered service %s on peripheral %s \n", service.getIdentifier(), peripheral.getIdentifier());
			
			peripheral.discoverCharacteristicsForService(new UUID[]{}, service);
			break;
		}
	}
	
	@Override
	public void discoveredIncludedServicesForService(BluetoothPeripheral peripheral, BluetoothService service, BluetoothException error)
	{
	
	}
	
	@Override
	public void discoveredCharacteristicsForService(BluetoothPeripheral peripheral, BluetoothService service, BluetoothException error)
	{
		BluetoothCharacteristic[] characteristics = service.getCharacteristics();
		
		for (BluetoothCharacteristic characteristic : characteristics)
		{
			System.out.printf("Discovered characteristic %s on service %s of peripheral %s\n", characteristic.getIdentifier(), service.getIdentifier(), peripheral.getIdentifier());
		}
	}
	
	@Override
	public void discoveredDescriptorsForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error)
	{
	
	}
	
	@Override
	public void updatedValueForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error)
	{
	
	}
	
	@Override
	public void updatedValueForDescriptor(BluetoothPeripheral peripheral, BluetoothDescriptor descriptor, BluetoothException error)
	{
	
	}
	
	@Override
	public void wroteValueForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error)
	{
	
	}
	
	@Override
	public void wroteValueForDescriptor(BluetoothPeripheral peripheral, BluetoothDescriptor descriptor, BluetoothException error)
	{
	
	}
	
	@Override
	public void updatedNotificationStateForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error)
	{
	
	}
	
	@Override
	public void readRSSI(BluetoothPeripheral peripheral, double rssi, BluetoothException error)
	{
	
	}
	
	@Override
	public void updatedName(BluetoothPeripheral peripheral)
	{
	
	}
	
	@Override
	public void modifiedServices(BluetoothPeripheral peripheral, BluetoothService[] services)
	{
	
	}
	
	@Override
	public void isReadyToSendWriteWithoutResponse(BluetoothPeripheral peripheral)
	{
	
	}
	
	public void executeAfter(Callable<Void> callable, int delay)
	{
		Timer timer = new Timer();
		timer.schedule(new TimerTask()
		{
			public void run()
			{
				try
				{
					callable.call();
				}
				catch (Exception ex)
				{
				
				}
			}
		}, delay);
	}
}
