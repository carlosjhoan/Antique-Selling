package com.antiqueselling.antiqueselling.Pais.Dominio;

import java.util.List;

import com.antiqueselling.antiqueselling.Ciudad.Dominio.Ciudad;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Pais {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(columnDefinition = "bigint")
    private long id;

    @Column(columnDefinition = "varchar(100)", unique = true)
    private String nombre;

    @OneToMany(mappedBy = "pais")
    private List<Ciudad> listCiudades; 

}
