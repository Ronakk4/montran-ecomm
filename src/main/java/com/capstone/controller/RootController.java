//package com.capstone.controller;
//
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//@Controller
//public class RootController {
//
//    @GetMapping("/")
//    public String indexPage() {
//        return "index"; // This will serve the main landing page
//    }
//    
//    @GetMapping("/index")
//    public String indexPageAlternate() {
//        return "index"; // Alternative route to index
//    }
//}


package com.capstone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RootController {

    @GetMapping("/")
    public String indexPage() {
        return "index"; // This will serve the main landing page
    }
    
    @GetMapping("/index")
    public String indexPageAlternate() {
        return "index"; // Alternative route to index
    }
}