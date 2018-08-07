package com.blissapplications.ble;

import java.util.UUID;

/**
 * Bliss Applications
 * User: tjanela
 * Date: 19/07/2018
 * Time: 15:17
 */
public class BluetoothDescriptor {
    private long nativeDescriptorHandle;
    private BluetoothCharacteristic characteristic;

    long getNativeDescriptorHandle() {
        return nativeDescriptorHandle;
    }

    private native UUID getIdentifier(long nativeDescriptorHandle);

    public BluetoothDescriptor(long nativeDescriptorHandle, BluetoothCharacteristic characteristic) {
        this.nativeDescriptorHandle = nativeDescriptorHandle;
        this.characteristic = characteristic;
    }

    public UUID getIdentifier() {
        return getIdentifier(nativeDescriptorHandle);
    }

    public BluetoothCharacteristic getCharacteristic() {
        return characteristic;
    }
}
