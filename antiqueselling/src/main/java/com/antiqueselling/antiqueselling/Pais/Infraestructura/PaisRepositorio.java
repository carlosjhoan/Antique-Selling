package com.antiqueselling.antiqueselling.Pais.Infraestructura;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.antiqueselling.antiqueselling.Pais.Dominio.Pais;

public interface PaisRepositorio extends JpaRepository<Pais, Long>{

    List<Pais> findByNombre(String nombre);

}
