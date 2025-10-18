package com.flavorbase.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "test_connection")
public class TestEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "test_message")
    private String message;
    
    // Default constructor
    public TestEntity() {}
    
    // Constructor
    public TestEntity(String message) {
        this.message = message;
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
}
