class Universidad {
  var property provincia
  var property honorariosRecomendados
  var totalRecaudado = 0
  method donar(importe) { 
    totalRecaudado += importe
  }
  method totalRecaudado() = totalRecaudado //test par ver cuanto tiene
}

class ProfesionalVinculado{
  var property universidad 
  method provincias() = [universidad.provincia()]
  method honorariosPorHora() = universidad.honorariosRecomendados()
  method cobrar(unImporte) { universidad.donar(unImporte / 2) }
}

class ProfesionalAsociado{
  var property universidad 
  method provincias() = ["Entre Rios", "Santa Fe", "Corrientes"]
  method honorariosPorHora() = 3000
  method cobrar(unImporte) {asociacionDeProfesionalesDelLitoral.cobrar(unImporte)} 
}

class ProfesionalLibre{
  var property universidad
  var property provincias
  var property honorariosPorHora
  var property totalRecaudado = 0  
  method cobrar(unImporte) {totalRecaudado += unImporte}
  method pasarDinero(unProfesional, importe){
    totalRecaudado -= importe
    unProfesional.cobrar(importe)
  } 
}

class Empresa{
  var property profesionales = []
  var property honorarioDeReferencia 
  var property clientes = #{}

  method cuantosEstudiaronEn(unaUniversidad) =
    profesionales.count({unProfesional => unProfesional.universidad() == unaUniversidad})
  
  method profesionalesCaros() =  profesionales.filter({unProfesional => unProfesional.honorariosPorHora()
                                                       > self.honorarioDeReferencia()})

  method universidadesFormadoras() = profesionales.map({p => p.universidad()}).asSet()
  
  method profesionalMasBarato() = profesionales.min({p => p.honorariosPorHora()})

  method esDeGenteAcotada() = profesionales.all({p => p.cantidadDeProvincias() >= 3})
  method cantidadDeProvincias() = profesionales.size({p => p.provincia()})  

// method esDeGenteAcotada() = profesionales.all({ p => p.provincias().size() <= 3 })

  method puedeSatisfacerA(unSolicitante) = profesionales.any({ unProfesional => unSolicitante.puedeSerAtendidoPor(unProfesional)})

  method darServicio(unSolicitante) {
    if (self.puedeSatisfacerA(unSolicitante)) {
      const profesionalesPosibles = profesionales.filter({ p => unSolicitante.puedeSerAtendidoPor(p) })
      const profesionalElegido = profesionalesPosibles.anyOne()
      profesionalElegido.cobrar(profesionalElegido.honorariosPorHora())
      clientes.add(unSolicitante)
        }
    }
  method cuantosClientes() = clientes.size()

  method esCliente(unSolicitante) = clientes.contains(unSolicitante)

  method esPocoAtractivo(unProfesional) =
    unProfesional.provincias().all({ provincia =>
    profesionales.any({ otro => 
        otro != unProfesional && 
        otro.provincias().contains(provincia) && 
        otro.honorariosPorHora() < unProfesional.honorariosPorHora()
    })
})
}
object asociacionDeProfesionalesDelLitoral {
  var totalRecaudado = 0
  method cobrar(unImporte) {totalRecaudado += unImporte}  
}