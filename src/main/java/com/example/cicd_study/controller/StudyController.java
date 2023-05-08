package com.example.cicd_study.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping
public class StudyController {

    @GetMapping("/hello")
    public ResponseEntity<String> returnHello() {
        return new ResponseEntity<>("Hello", HttpStatus.OK);
    }
}
