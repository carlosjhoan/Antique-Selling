package com.antiqueselling.antiqueselling.Ciudad.Dominio;

import java.util.List;
import java.util.Optional;


public interface ICiudad {

    void createCiudad(Ciudad ciudad);
    Optional <Ciudad> findCiudadById(Long id);
    boolean deletePaisById(String nombre);
    List<Ciudad> encontrarCiudadPorNombre(String nombre);
    List<Ciudad> encontrarTodasCiudades();

}
