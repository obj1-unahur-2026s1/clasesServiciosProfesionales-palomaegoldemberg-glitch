class Universidad {
  var property provincia
  var property honorariosRecomendados
}

class ProfesionalVinculado{
  var property universidad 
  method provincias() = [universidad.provincia()]
  method honorariosPorHora() = universidad.honorariosRecomendados()
}

class ProfesionalAsociado{
  var property universidad 
  method provincias() = ["Entre Rios", "Santa Fe", "Corrientes"]
  method honorariosPorHora() = 3000
}

class ProfesionalLibre{
  var property universidad
  var property provincias
  var property honorariosPorHora  
}

class Empresa{
  var property profesionales = []
  var property honorarioDeReferencia 

  method cuantosEstudiaronEn(unaUniversidad) =
    profesionales.count({unProfesional => unProfesional.universidad() == unaUniversidad})
  
  method profesionalesCaros() =  profesionales.filter({unProfesional => unProfesional.honorariosPorHora()
                                                       > self.honorarioDeReferencia()})

  method universidadesFormadoras() = profesionales.map({p => p.universidad()}).asSet()
  
  method profesionalMasBarato() = profesionales.min({p => p.honorariosPorHora()})

  method esDeGenteAcotada() = profesionales.all({p => p.cantidadDeProvincias() >= 3})

  method cantidadDeProvincias() = profesionales.size({p => p.provincia()})  

// method esDeGenteAcotada() = profesionales.all({ p => p.provincias().size() <= 3 })
}