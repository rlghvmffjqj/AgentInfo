package com.secuve.agentInfo.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Component
@Table(name = "license5file")
public class License5File {
	@Id
	@Column(name = "serialnumber")
	private String serialNumber;
	@Column(name = "filename")
	private String fileName;

    @Lob
    @Column(name = "filedata")
    private byte[] fileData;
}
