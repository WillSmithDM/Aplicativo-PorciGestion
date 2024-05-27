import 'package:app_tesis/presentation/routes/routess.dart';



class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userRol = RolID.id;
    return Scaffold(
        backgroundColor: MisColores.primary,
        body: Stack(children: [
          Column(
            children: [
              const SizedBox(height: 90),
              Expanded(
                child: Container(
                  color: MisColores.fondo50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20.0),
                      crossAxisCount: 2, // Dos columnas en la cuadrícula
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      children: [
                        IconCard(
                          icon: CommunityMaterialIcons.pig,
                          color: MisColores.iconblanco,
                          title: 'Cerdos',
                          onTap: () {
                            if (viewPermissions[userRol]?['Cerdos'] ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PigsViews()),
                              );
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        IconCard(
                          icon: Icons.campaign,
                          color: MisColores.iconblanco,
                          title: 'Campañas',
                          onTap: () {
                            if (viewPermissions[userRol]?['Campañas'] ??
                                false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Campaing()),
                              );
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        IconCard(
                          icon: CommunityMaterialIcons.cube_outline,
                          color: MisColores.iconblanco,
                          title: 'Alimentos',
                          onTap: () {
                            if (viewPermissions[userRol]?['Alimentos'] ??
                                false) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FoodsScreen()));
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        IconCard(
                          icon: Icons.vaccines_outlined,
                          color: MisColores.iconblanco,
                          title: 'Vacunas',
                          onTap: () {
                            if (viewPermissions[userRol]?['Vacunas'] ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ListVaccinesGeneral()),
                              );
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        IconCard(
                          icon: CommunityMaterialIcons.medical_bag,
                          color: MisColores.iconblanco,
                          title: 'Historial Clinico',
                          onTap: () {
                            if (viewPermissions[userRol]?['Historial'] ??
                                false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HistorialScreen()),
                              );
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        IconCard(
                          icon: CommunityMaterialIcons.weight_pound,
                          color: MisColores.iconblanco,
                          title: 'Control de Peso',
                          onTap: () {
                            if (viewPermissions[userRol]?['Peso'] ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ControlViewGeneral()),
                              );
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        IconCard(
                          icon: CommunityMaterialIcons.face_profile,
                          color: MisColores.iconblanco,
                          title: 'Usuarios',
                          onTap: () {
                            if (viewPermissions[userRol]?['Usuarios'] ??
                                false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserScreen()),
                              );
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        IconCard(
                          icon: CommunityMaterialIcons.details,
                          color: MisColores.iconblanco,
                          title: 'Recetas',
                          onTap: () {
                            if (viewPermissions[userRol]?['Receta'] ??
                                false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RecetaScreen()),
                              );
                            } else {
                              AlertMessages.alertInfo(context, Messages().messagePermission);
                            }
                          },
                        ),
                        // IconCard(
                        //   icon: Icons.dashboard_customize_outlined,
                        //   color: MisColores.iconblanco,
                        //   title: 'Reportes',
                        //   onTap: () {
                        //     if (viewPermissions[userRol]?['Reportes'] ??
                        //         false) {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => const ReportScreen()),
                        //       );
                        //     } else {
                        //       AlertMessages.alertInfo(context, Messages().messagePermission);
                        //     }
                        //   },
                        // ),
                        // Agrega más IconCards aquí según sea necesario
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 120,
              color: MisColores.primary,
              child: const Center(
                child: Text(
                  "CATEGORIAS",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MisColores.blanco,
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
