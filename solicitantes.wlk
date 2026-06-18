
import servicios.*

class Persona{
    var property provincia
    method puedeSerAtendidoPor(unProfesional) = unProfesional.provincias().contains(self.provincia())
}

class Institucion{
    var property universidades = []
    method puedeSerAtendidoPor(unProfesional) = self.universidades().contains(unProfesional.universidad()) 
}

class Club {
  var property provincias = []
  method puedeSerAtendidoPor(unProfesional) = self.provincias().any({ provincia => unProfesional.provincias().contains(provincia) })
}
