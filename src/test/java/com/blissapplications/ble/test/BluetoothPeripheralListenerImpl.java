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
public class BluetoothPeripheralListenerImpl implements BluetoothPeripheralListener {

    @Override
    public void discoveredServices(BluetoothPeripheral peripheral, BluetoothException error) {
        BluetoothService[] services = peripheral.getServices();
        //UUID c1 = UUID.fromString("0c4c3001-7700-46f4-aa96-d5e974e32a54");
        System.out.printf("Discovered services. Peripheral state: %s \n", peripheral.getState());
        for (BluetoothService service : services) {
            System.out.printf("Discovered service %s on peripheral %s \n", service.getIdentifier(), peripheral.getIdentifier());
            peripheral.discoverCharacteristicsForService(new UUID[]{}, service);
        }
    }

    @Override
    public void discoveredIncludedServicesForService(BluetoothPeripheral peripheral, BluetoothService service, BluetoothException error) {

    }

    @Override
    public void discoveredCharacteristicsForService(BluetoothPeripheral peripheral, BluetoothService service, BluetoothException error) {
        BluetoothCharacteristic[] characteristics = service.getCharacteristics();

        for (BluetoothCharacteristic characteristic : characteristics) {
            System.out.printf("Discovered characteristic %s on service %s of peripheral %s\n", characteristic.getIdentifier(), service.getIdentifier(), peripheral.getIdentifier());
            System.out.printf("Characteristic properties\n%s\n", characteristic.getProperties());
            peripheral.discoverDescriptorsForCharacteristic(characteristic);

            if(characteristic.getIdentifier().equals(UUID.fromString("0c4c3001-7700-46f4-aa96-d5e974e32a54"))){
                peripheral.setNotifyValueForCharacteristic(characteristic, true);
            }
        }
    }

    @Override
    public void discoveredDescriptorsForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error) {
        BluetoothDescriptor[] descriptors = characteristic.getDescriptors();

        for (BluetoothDescriptor descriptor : descriptors) {
            System.out.printf("Discovered descriptor %s characteristic %s on service %s of peripheral %s\n", descriptor.getIdentifier(), characteristic.getIdentifier(), characteristic.getService().getIdentifier(), peripheral.getIdentifier());
        }
    }

    @Override
    public void updatedValueForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error) {
        System.out.printf("Updated value for characteristic %s: <%d>[%s]\n", characteristic.getIdentifier(), characteristic.getValue().length, Base16.getEncoder().encode(characteristic.getValue()));
    }

    @Override
    public void updatedValueForDescriptor(BluetoothPeripheral peripheral, BluetoothDescriptor descriptor, BluetoothException error) {

    }

    @Override
    public void wroteValueForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error) {

    }

    @Override
    public void wroteValueForDescriptor(BluetoothPeripheral peripheral, BluetoothDescriptor descriptor, BluetoothException error) {

    }

    @Override
    public void updatedNotificationStateForCharacteristic(BluetoothPeripheral peripheral, BluetoothCharacteristic characteristic, BluetoothException error) {

    }

    @Override
    public void updatedRSSI(BluetoothPeripheral peripheral, BluetoothException error) {
        System.out.printf("Peripheral <%s> RSSI: %.2f dB\n", peripheral.getName(), peripheral.getRSSI());
    }

    @Override
    public void updatedName(BluetoothPeripheral peripheral) {
        System.out.printf("Peripheral updated name: <%s>\n", peripheral.getName());
    }

    @Override
    public void modifiedServices(BluetoothPeripheral peripheral, BluetoothService[] services) {
        System.out.printf("Peripheral <%s> modified services\n", peripheral.getName());
        for (BluetoothService service : services) {
            System.out.printf("Modified service %s on peripheral %s \n", service.getIdentifier(), peripheral.getIdentifier());
            peripheral.discoverCharacteristicsForService(new UUID[]{}, service);
        }
    }

    public void executeAfter(Callable<Void> callable, int delay) {
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            public void run() {
                try {
                    callable.call();
                } catch (Exception ex) {

                }
            }
        }, delay);
    }
}
