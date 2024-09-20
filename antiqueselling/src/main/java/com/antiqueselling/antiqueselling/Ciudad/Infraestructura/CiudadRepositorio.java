package com.antiqueselling.antiqueselling.Ciudad.Infraestructura;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.antiqueselling.antiqueselling.Ciudad.Dominio.Ciudad;

public interface CiudadRepositorio extends JpaRepository<Ciudad, Long> {

    List<Ciudad> findByNombre(String nombre);
}
