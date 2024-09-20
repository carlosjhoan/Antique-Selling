package com.antiqueselling.antiqueselling.Pais.Aplicacion;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.antiqueselling.antiqueselling.Pais.Dominio.IPais;
import com.antiqueselling.antiqueselling.Pais.Dominio.Pais;
import com.antiqueselling.antiqueselling.Pais.Infraestructura.PaisRepositorio;

@Service
public class PaisImplementacion implements IPais  {

    @Autowired
    PaisRepositorio paisRepositorio;

    @Override
    public String borrarPais(Pais pais) {
        
        String nombrePaisABorrar = pais.getNombre();
        long idPaisABorrar = pais.getId();
        
        Optional<Pais> optionalPais = paisRepositorio.findById(idPaisABorrar);

        if (optionalPais.isPresent()) {

            Pais paisABorrar = optionalPais.get();
            paisRepositorio.delete(paisABorrar);
            List<Pais> listaPaisBorrado = paisRepositorio.findByNombre(nombrePaisABorrar);

            if (listaPaisBorrado.size() == 0) {
                
                return "Pais Borrado exitosamente";
            }

            return "No se pudo borrar este pais";

        }

        return "Este Pais no se encuentra registrado.";

    }

    @Override
    public String registrarPais(Pais pais) {
        
        List<Pais> paisEncontrado = paisRepositorio.findByNombre(pais.getNombre());

        if (paisEncontrado.size()==0) {

            paisRepositorio.save(pais);
            return "Pais guardado exitosamente";

        } else if (paisEncontrado.size() > 0) {
            
            return "Este pais ya está registrado";

        } else {

            return "Error al registrar pais";

        }
    }

    @Override
    public List<Pais> encontrarPaisPorNombre(String nombre) {
        
        return null;
    }

    @Override
    public Optional<Pais> findPaisById(Long id) {
        
        return Optional.empty();
    }

    

}
