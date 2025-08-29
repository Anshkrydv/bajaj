package com.bajaj.dto;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WebhookRequest {
    private String name;
    private String regNo;
    private String email;
}
