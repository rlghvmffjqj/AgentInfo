package com.secuve.agentInfo.core;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.stereotype.Service;

@Service
public class LockService {
	private final Lock lock = new ReentrantLock();

    public boolean isLocked() {
        return lock.tryLock();
    }

    public void releaseLock() {
        if (((ReentrantLock) lock).isHeldByCurrentThread()) {
            lock.unlock();
        }
    }
}
