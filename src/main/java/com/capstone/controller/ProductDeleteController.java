package com.capstone.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.capstone.model.DeleteProduct;
import com.capstone.service.DeleteProductService;

@RestController
@RequestMapping("/deleted")
public class ProductDeleteController {

    @Autowired
    private DeleteProductService deleteProductService;

    @GetMapping("{id}")
    public List<DeleteProduct> getDeletedProducts(@PathVariable long id) {
        return deleteProductService.getDeleteProducts(id);
    }
}
