package com.blissapplications.ble;

import java.util.UUID;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 09/07/2018
 * Time: 21:13
 */
public class BluetoothPeripheral {

    private long nativePeripheralHandle;
    private BluetoothPeripheralListener listener;

    // JNI Methods

    private native UUID getIdentifier(long nativePeripheralHandle);

    private native String getName(long nativePeripheralHandle);

    private native void discoverServices(long nativePeripheralHandle, UUID[] serviceUUIDs);

    private native void discoverIncludedServices(long nativePeripheralHandle, UUID[] serviceUUIDs, long nativeServiceHandle);

    private native BluetoothService[] getServices(long nativePeripheralHandle);

    private native void discoverCharacteristicsForService(long nativePeripheralHandle, UUID[] characteristicUUIDs, long nativeServiceHandle);

    private native void discoverDescriptorsForCharacteristic(long nativePeripheralHandle, long nativeCharacteristicHandle);

    private native void readValueForCharacteristic(long nativePeripheralHandle, long nativeCharacteristicHandle);

    private native void readValueForDescriptor(long nativePeripheralHandle, long nativeDescriptorHandle);

    private native void writeValueForCharacteristic(long nativePeripheralHandle, byte[] data, long nativeCharacteristicHandle, BluetoothCharacteristicWriteType type);

    private native void writeValueForDescriptor(long nativePeripheralHandle, byte[] data, long nativeDescriptorHandle);

    private native void setNotifyValueForCharacteristic(long nativePeripheralHandle, long nativeCharacteristicHandle, boolean value);

    private native int getState(long nativePeripheralHandle);

    private native void readRSSI(long nativePeripheralHandle);

    private native double getRSSI(long nativePeripheralHandle);

    //private native boolean canSendWriteWithoutResponse(long nativePeripheralHandle);

    //private native long maximumWriteValueLengthForCharacteristic(long nativePeripheralHandle, long nativeCharacteristicHandle);

    // Constructor

    public BluetoothPeripheral(long nativePeripheralHandle) {
        this.nativePeripheralHandle = nativePeripheralHandle;
    }

    // Public contract

    public String getName() {
        return getName(nativePeripheralHandle);
    }

    public UUID getIdentifier() {
        return getIdentifier(nativePeripheralHandle);
    }

    public void discoverServices() {
        discoverServices(new UUID[]{});
    }

    public void discoverServices(UUID[] serviceUUIDs) {
        discoverServices(nativePeripheralHandle, serviceUUIDs);
    }


    public void discoverIncludedServices(UUID[] serviceUUIDs, BluetoothService service) {
        discoverIncludedServices(nativePeripheralHandle, serviceUUIDs, service.getNativeServiceHandle());
    }

    public BluetoothService[] getServices() {
        return getServices(nativePeripheralHandle);
    }

    public void discoverCharacteristicsForService(UUID[] characteristicUUIDs, BluetoothService service) {
        discoverCharacteristicsForService(nativePeripheralHandle, characteristicUUIDs, service.getNativeServiceHandle());
    }


    public void discoverDescriptorsForCharacteristic(BluetoothCharacteristic characteristic) {
        discoverDescriptorsForCharacteristic(nativePeripheralHandle, characteristic.getNativeCharacteristicHandle());
    }


    public void readValueForCharacteristic(BluetoothCharacteristic characteristic) {
        readValueForCharacteristic(nativePeripheralHandle, characteristic.getNativeCharacteristicHandle());
    }

    public void readValueForDescriptor(BluetoothDescriptor descriptor) {
        readValueForDescriptor(nativePeripheralHandle, descriptor.getNativeDescriptorHandle());
    }

    public void writeValueForCharacteristic(byte[] data, BluetoothCharacteristic characteristic, BluetoothCharacteristicWriteType type) {
        writeValueForCharacteristic(nativePeripheralHandle, data, characteristic.getNativeCharacteristicHandle(), type);
    }

    public void writeValueForDescriptor(byte[] data, BluetoothDescriptor descriptor) {
        writeValueForDescriptor(nativePeripheralHandle, data, descriptor.getNativeDescriptorHandle());
    }

    public void setNotifyValueForCharacteristic(BluetoothCharacteristic characteristic, boolean value) {
        setNotifyValueForCharacteristic(nativePeripheralHandle, characteristic.getNativeCharacteristicHandle(), value);
    }

    public BluetoothPeripheralState getState() {
        return BluetoothPeripheralState.fromValue(getState(nativePeripheralHandle));
    }

    public void readRSSI() {
        readRSSI(nativePeripheralHandle);
    }

    public double getRSSI() {
        return getRSSI(nativePeripheralHandle);
    }


    //10.13 Only
    //public boolean canSendWriteWithoutResponse() {
    //    return canSendWriteWithoutResponse(nativePeripheralHandle);
    //}

    //10.12 Only
    //public long maximumWriteValueLengthForCharacteristic(BluetoothCharacteristic characteristic) {
    //    return maximumWriteValueLengthForCharacteristic(nativePeripheralHandle, characteristic.getNativeCharacteristicHandle());
    //}

    //Invoked from JNI

    public void updatedName() {
        if (listener == null) {
            return;
        }

        listener.updatedName(this);
    }

    public void discoveredServices(BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.discoveredServices(this, error);
    }

    public void discoveredIncludedServicesForService(BluetoothService service, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.discoveredIncludedServicesForService(this, service, error);
    }

    public void modifiedServices(BluetoothService[] services) {
        if (listener == null) {
            return;
        }

        listener.modifiedServices(this, services);
    }

    public void discoveredCharacteristicsForService(BluetoothService service, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.discoveredCharacteristicsForService(this, service, error);
    }

    public void discoveredDescriptorsForCharacteristic(BluetoothCharacteristic characteristic, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.discoveredDescriptorsForCharacteristic(this, characteristic, error);
    }

    public void updatedValueForCharacteristic(BluetoothCharacteristic characteristic, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.updatedValueForCharacteristic(this, characteristic, error);
    }

    public void updatedValueForDescriptor(BluetoothDescriptor descriptor, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.updatedValueForDescriptor(this, descriptor, error);
    }

    public void wroteValueForCharacteristic(BluetoothCharacteristic characteristic, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.wroteValueForCharacteristic(this, characteristic, error);
    }

    public void wroteValueForDescriptor(BluetoothDescriptor descriptor, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.wroteValueForDescriptor(this, descriptor, error);
    }

    public void updatedNotificationStateForCharacteristic(BluetoothCharacteristic characteristic, BluetoothException error) {
        if (listener == null) {
            return;
        }

        listener.updatedNotificationStateForCharacteristic(this, characteristic, error);
    }

    public void updatedRSSI(BluetoothException exception) {
        if (listener == null) {
            return;
        }

        listener.updatedRSSI(this, exception);
    }

    //Getters and Setters

    long getNativePeripheralHandle() {
        return nativePeripheralHandle;
    }

    public void setListener(BluetoothPeripheralListener listener) {
        this.listener = listener;
    }

    public BluetoothPeripheralListener getListener() {
        return listener;
    }

    static {
        System.loadLibrary("ble-jni");
    }
}
