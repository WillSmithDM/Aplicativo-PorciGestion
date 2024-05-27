class UserRole {
  final bool canEdit;
  final bool canInsert;
  final bool canDelete;
  final bool canUpdateVaccines;

  UserRole(
    {
      required this.canUpdateVaccines, 
      required this.canEdit,
      required this.canDelete,
      required this.canInsert});
}

final userRoles = {
  '1': UserRole(canDelete: true, canEdit: true, canInsert: true , canUpdateVaccines: true),
  '2': UserRole(canEdit: true, canDelete: true, canInsert: true, canUpdateVaccines: true),
  '3': UserRole(canEdit: true, canDelete: true, canInsert: true, canUpdateVaccines: false),
  '4': UserRole(canEdit: false, canDelete: false, canInsert: false, canUpdateVaccines: false)
};

final viewPermissions = {
  '1': {
    'Cerdos': true,
    'Campañas': true,
    'Alimentos': true,
    'Vacunas': true,
    'Historial': true,
    'Peso': true,
    'Usuarios': true,
    'Receta' : true,
    'Reportes' : false
  },
  '2': {
    'Cerdos': true,
    'Campañas': false,
    'Alimentos': true,
    'Vacunas': true,
    'Historial': true,
    'Peso': true,
    'Usuarios': false,
    'Receta': true,
    'Reportes': false
  },
  '3': {
    'Cerdos': false,
    'Campañas': false,
    'Alimentos': true,
    'Vacunas': true,
    'Historial': true,
    'Peso': true,
    'Usuarios': false,
    'Receta': false,
    'Reportes': false,
    
  },
  '4': {
    'Cerdos': true,
    'Campañas': false,
    'Alimentos': true,
    'Vacunas': true,
    'Historial': false,
    'Peso': true,
    'Usuarios': false,
    'Receta': false,
    'Reportes': false
  }
};
