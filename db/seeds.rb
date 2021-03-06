#Localidades
Localidad.create!(nombre: 'Mar del Plata')
Localidad.create!(nombre: 'Buenos Aires')
Localidad.create!(nombre: 'Cordoba')
Localidad.create!(nombre: 'Rosario')
Localidad.create!(nombre: 'La Plata')
Localidad.create!(nombre: 'Formosa')
Localidad.create!(nombre: 'Mendoza')
Localidad.create!(nombre: 'Salta')
Localidad.create!(nombre: 'Jujuy')
Localidad.create!(nombre: 'Rio Gallegos')
Localidad.create!(nombre: 'Ushuaia')
Localidad.create!(nombre: 'Resistencia')
Localidad.create!(nombre: 'Santa Rosa')
Localidad.create!(nombre: 'Posadas')
Localidad.create!(nombre: 'Corrientes')
Localidad.create!(nombre: 'Parana')
Localidad.create!(nombre: 'San Luis')
Localidad.create!(nombre: 'New York')
Localidad.create!(nombre: 'Viedma')
Localidad.create!(nombre: 'Rawson')
Localidad.create!(nombre: 'Santa Fe')
Localidad.create!(nombre: 'Tucuman')
Localidad.create!(nombre: 'San Juan')
Localidad.create!(nombre: 'Neuquen')
Localidad.create!(nombre: 'La Rioja')
Localidad.create!(nombre: 'Catamarca')

#Empresas
Empresa.create!(razon_social: "Arcor S.A.", cuit: '30-55673345-0', domicilio: '25 de Mayo 454', localidad_id: '1')
Empresa.create!(razon_social: "Molinos S.A.", cuit: '33-59845650-9', domicilio: 'Dellepiane 23', localidad_id: '4')
Empresa.create!(razon_social: "Holbrook Co.", cuit: '30-35556789-3', domicilio: 'Entre Rios 224', localidad_id: '5')
Empresa.create!(razon_social: "Marshfield Llc.", cuit: '33-98976532-1', domicilio: 'Av. de Mayo 110', localidad_id: '6')
Empresa.create!(razon_social: "Iron Cobra Inc.", cuit: '30-19345843-0', domicilio: '9 de Julio 332', localidad_id: '20')
Empresa.create!(razon_social: "Symantec Ltd.", cuit: '30-54339160-2', domicilio: '132 5th Avenue', localidad_id: '18')
Empresa.create!(razon_social: "Pindonga S.R.L", cuit: '30-33457653-2', domicilio: 'Alvarado 283', localidad_id: '11')
Empresa.create!(razon_social: "Apple Inc.", cuit: '30-11220956-6', domicilio: '333 Ocean Drive', localidad_id: '9')

#Puestos
Puesto.create!(descripcion: 'maestranza A', basico: '8468.35')
Puesto.create!(descripcion: 'maestranza B', basico: '8500.40')
Puesto.create!(descripcion: 'maestranza C', basico: '8612.73')
Puesto.create!(descripcion: 'maestranza D', basico: '8834.42')
Puesto.create!(descripcion: 'auxiliar A', basico: '8628.77')
Puesto.create!(descripcion: 'auxiliar B', basico: '8708.97')
Puesto.create!(descripcion: 'aux_especial A', basico: '8725.00')
Puesto.create!(descripcion: 'aux_especial B', basico: '8869.40')
Puesto.create!(descripcion: 'administrativo A', basico: '8588.68')
Puesto.create!(descripcion: 'administrativo B', basico: '8636.81')
Puesto.create!(descripcion: 'administrativo C', basico: '8684.86')
Puesto.create!(descripcion: 'administrativo D', basico: '8829.29')
Puesto.create!(descripcion: 'vendedor A', basico: '8628.75')
Puesto.create!(descripcion: 'vendedor B', basico: '8869.40')
Puesto.create!(descripcion: 'vendedor C', basico: '8949.63')
Puesto.create!(descripcion: 'vendedor D', basico: '9126.07')
Puesto.create!(descripcion: 'cajero A', basico: '8828.75')
Puesto.create!(descripcion: 'cajero B', basico: '8684.86')
Puesto.create!(descripcion: 'cajero C', basico: '8757.12')
Puesto.create!(descripcion: 'cajero D', basico: '8834.76')

#Empleados
Empleado.create!(nro_legajo: '33', nombre_y_apellido: 'Hernan Bengoa', fecha_nacimiento: '1985-06-29', dni: '31.734.090', localidad_id: '1', empresa_id: '1', puesto_id: '5')
Empleado.create!(nro_legajo: '52', nombre_y_apellido: 'Pablo Vizcay', fecha_nacimiento: '1985-10-08', dni: '31.821.972', localidad_id: '3', empresa_id: '1', puesto_id: '10')
Empleado.create!(nro_legajo: '22', nombre_y_apellido: 'Marcos Aguerre', fecha_nacimiento: '1980-11-08', dni: '28.554.323', localidad_id: '1', empresa_id: '1', puesto_id: '9')
Empleado.create!(nro_legajo: '84', nombre_y_apellido: 'Miguel Lopez', fecha_nacimiento: '1956-12-15', dni: '11.543.765', localidad_id: '22', empresa_id: '1', puesto_id: '3')
Empleado.create!(nro_legajo: '18', nombre_y_apellido: 'Jorge Gonzalez', fecha_nacimiento: '1997-04-03', dni: '38.521.214', localidad_id: '11', empresa_id: '1', puesto_id: '15')
Empleado.create!(nro_legajo: '97', nombre_y_apellido: 'Jorge Marin', fecha_nacimiento: '1948-08-11', dni: '09.346.886', localidad_id: '5', empresa_id: '1', puesto_id: '11')
Empleado.create!(nro_legajo: '66', nombre_y_apellido: 'Carolina Herrera', fecha_nacimiento: '1976-01-12', dni: '89.346.866', localidad_id: '21', empresa_id: '2', puesto_id: '8')
Empleado.create!(nro_legajo: '21', nombre_y_apellido: 'Mario Gomez', fecha_nacimiento: '1956-03-22', dni: '13.434.776', localidad_id: '6', empresa_id: '1', puesto_id: '19')
Empleado.create!(nro_legajo: '1', nombre_y_apellido: 'Mike Thompson', fecha_nacimiento: '1978-03-11', dni: '23.966.875', localidad_id: '8', empresa_id: '8', puesto_id: '7')
Empleado.create!(nro_legajo: '2', nombre_y_apellido: 'Roger Federer', fecha_nacimiento: '1980-05-05', dni: '32.568.654', localidad_id: '5', empresa_id: '8', puesto_id: '2')
Empleado.create!(nro_legajo: '3', nombre_y_apellido: 'Stan Wawrinka', fecha_nacimiento: '1982-01-31', dni: '88.432.576', localidad_id: '11', empresa_id: '8', puesto_id: '6')
Empleado.create!(nro_legajo: '54', nombre_y_apellido: 'Lionel Messi', fecha_nacimiento: '1987-06-24', dni: '23.675.331', localidad_id: '4', empresa_id: '7', puesto_id: '20')
Empleado.create!(nro_legajo: '99', nombre_y_apellido: 'Marcos Galvan', fecha_nacimiento: '1984-12-21', dni: '33.765.421', localidad_id: '3', empresa_id: '7', puesto_id: '6')
Empleado.create!(nro_legajo: '77', nombre_y_apellido: 'Pete Sampras', fecha_nacimiento: '1972-10-03', dni: '22.345.321', localidad_id: '11', empresa_id: '8', puesto_id: '8')

#Recibos
Recibo.create!(empleado_id: '10', puesto: 'aux_especial A', fecha: '2014-10-10', total_remunerativo: '9700.46', total_no_remunerativo: '0.00', total_descuentos: '1940.09', total_neto: '7760.36', basico: '8725.00', anios_antiguedad: '2', antiguedad: '174.50', presentismo: '741.63', suma_no_remunerativa: '0.00', jubilacion: '1067.05', ley_pami: '291.01', obra_social: '291.01', cuota_sindical: '242.51', dias_vacaciones: '1', vacaciones: '355.98', aguinaldo: '0.00', dias_inasistencias: '1', inasistencias: '296.65', faecys: '48.50')
Recibo.create!(empleado_id: '11', puesto: 'maestranza B', fecha: '2014-10-31', total_remunerativo: '14783.05', total_no_remunerativo: '700.00', total_descuentos: '2956.61', total_neto: '12526.44', basico: '8500.40', anios_antiguedad: '2', antiguedad: '170.01', presentismo: '722.53', suma_no_remunerativa: '700.00', jubilacion: '1626.14', ley_pami: '443.49', obra_social: '443.49', cuota_sindical: '369.58', dias_vacaciones: '8', vacaciones: '2774.53', aguinaldo: '4927.68', dias_inasistencias: '8', inasistencias: '2312.11', faecys: '73.92')
