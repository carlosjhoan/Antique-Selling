package com.antiqueselling.antiqueselling.Pais.Infraestructura;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.antiqueselling.antiqueselling.Pais.Dominio.IPais;
import com.antiqueselling.antiqueselling.Pais.Dominio.Pais;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/pais")
public class PaisControlador {

    @Autowired
    IPais paisServicios;

    @PostMapping("/borrarPais")
    public String borrarPais(@Valid @RequestBody Pais pais) {
        
        return paisServicios.borrarPais(pais);

    }

    @PostMapping("/guardarPais")
    public String guardarPais(@Valid @RequestBody Pais pais) {
        
        return paisServicios.registrarPais(pais);

    }


    

}
