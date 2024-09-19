package com.antiqueselling.antiqueselling.Pais.Dominio;

import java.util.List;
import java.util.Optional;

public interface IPais {
    void createPais(Pais pais);
    Optional<Pais> findPaisById(Long id);
    void borrarPais(Pais pais);
    List<Pais> encontrarPaisPorNombre(String nombre);
}
