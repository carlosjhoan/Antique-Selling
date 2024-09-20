package com.antiqueselling.antiqueselling.Pais.Dominio;

import java.util.List;
import java.util.Optional;

public interface IPais {
    String registrarPais(Pais pais);
    Optional<Pais> findPaisById(Long id);
    String borrarPais(Pais pais);
    List<Pais> encontrarPaisPorNombre(String nombre);
}
