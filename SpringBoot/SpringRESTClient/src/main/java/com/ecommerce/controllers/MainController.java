package com.ecommerce.controllers;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ecommerce.beans.Quote;
import com.ecommerce.beans.Value;

@Controller
public class MainController {
    @RequestMapping("/")
    @ResponseBody
    public String index() {
           
           RestTemplate restTemplate = new RestTemplate();
       Quote quote = restTemplate.getForObject("https://gistcdn.githack.com/ayan-b/ff0441b5a8d6c489b58659ffb849aff4/raw/e1c5ca10f7bea57edd793c4189ea8339de534b45/response.json", Quote.class);
          
      return quote.toString();
    }

}
