package com.bajaj.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "solutions")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Solution {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String regNo;
    
    @Column(nullable = false)
    private String questionType;
    
    @Column(columnDefinition = "TEXT", nullable = false)
    private String sqlQuery;
    
    @Column(nullable = false)
    private LocalDateTime submittedAt;
    
    @Column
    private String webhookUrl;
    
    @Column
    private String status;
}
