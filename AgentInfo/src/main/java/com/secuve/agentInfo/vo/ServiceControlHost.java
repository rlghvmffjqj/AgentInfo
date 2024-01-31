package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ServiceControlHost implements Comparable<ServiceControlHost> {
	private String vmName;
	private String state;
	private String memoryAssigned;
	private String uptime;
	
	@Override
    public int compareTo(ServiceControlHost other) {
		int thisOrder = getOrder(this.state);
        int otherOrder = getOrder(other.state);

        // 비교 결과 반환
        return Integer.compare(thisOrder, otherOrder);
    }
	
	private int getOrder(String state) {
        switch (state) {
            case "Running":
                return 1;
            case "Saved":
                return 2;
            case "Off":
                return 3;
            default:
                return 0; // 예외 처리: 알 수 없는 상태는 마지막에 배치하거나, 예외 처리에 맞게 조정
        }
    }
}
