SET SQL DIALECT 3;

/*  Generators or sequences */
CREATE GENERATOR EMPLEADOS_SEQ;
CREATE GENERATOR EMPRESAS_SEQ;
CREATE GENERATOR LOCALIDADES_SEQ;
CREATE GENERATOR PUESTOS_SEQ;
CREATE GENERATOR RECIBOS_SEQ;


/* Table: EMPLEADOS, Owner: SYSDBA */
CREATE TABLE EMPLEADOS (ID INTEGER NOT NULL,
        NRO_LEGAJO INTEGER NOT NULL,
        NOMBRE_Y_APELLIDO VARCHAR(30),
        FECHA_NACIMIENTO DATE,
        DNI VARCHAR(10),
        LOCALIDAD_ID INTEGER,
        EMPRESA_ID INTEGER NOT NULL,
        PUESTO_ID INTEGER NOT NULL,
PRIMARY KEY (ID),
UNIQUE (NRO_LEGAJO, EMPRESA_ID));

/* Table: EMPRESAS, Owner: SYSDBA */
CREATE TABLE EMPRESAS (ID INTEGER NOT NULL,
        RAZON_SOCIAL VARCHAR(30) NOT NULL,
        CUIT VARCHAR(13),
        DOMICILIO VARCHAR(35),
        LOCALIDAD_ID INTEGER,
PRIMARY KEY (ID),
UNIQUE (CUIT));

/* Table: LOCALIDADES, Owner: SYSDBA */
CREATE TABLE LOCALIDADES (ID INTEGER NOT NULL,
        NOMBRE VARCHAR(25),
PRIMARY KEY (ID));

/* Table: PUESTOS, Owner: SYSDBA */
CREATE TABLE PUESTOS (ID INTEGER NOT NULL,
        DESCRIPCION VARCHAR(30),
        BASICO DECIMAL(18, 2),
PRIMARY KEY (ID));

/* Table: RECIBOS, Owner: SYSDBA */
CREATE TABLE RECIBOS (ID INTEGER NOT NULL,
        EMPLEADO_ID INTEGER NOT NULL,
        PUESTO VARCHAR(30),
        FECHA DATE,
        TOTAL_REMUNERATIVO DECIMAL(18, 2),
        TOTAL_NO_REMUNERATIVO DECIMAL(18, 2),
        TOTAL_DESCUENTOS DECIMAL(18, 2),
        TOTAL_NETO DECIMAL(18, 2),
        BASICO DECIMAL(18, 2),
        ANIOS_ANTIGUEDAD INTEGER,
        ANTIGUEDAD DECIMAL(18, 2),
        PRESENTISMO DECIMAL(18, 2),
        SUMA_NO_REMUNERATIVA DECIMAL(18, 2),
        JUBILACION DECIMAL(18, 2),
        LEY_PAMI DECIMAL(18, 2),
        OBRA_SOCIAL DECIMAL(18, 2),
        CUOTA_SINDICAL DECIMAL(18, 2),
        DIAS_VACACIONES INTEGER,
        VACACIONES DECIMAL(18, 2),
        AGUINALDO DECIMAL(18, 2),
        DIAS_INASISTENCIAS INTEGER,
        INASISTENCIAS DECIMAL(18, 2),
        FAECYS DECIMAL(18, 2),
PRIMARY KEY (ID));

ALTER TABLE EMPLEADOS ADD FOREIGN KEY (LOCALIDAD_ID) REFERENCES LOCALIDADES (ID);

ALTER TABLE EMPLEADOS ADD FOREIGN KEY (EMPRESA_ID) REFERENCES EMPRESAS (ID);

ALTER TABLE EMPRESAS ADD FOREIGN KEY (LOCALIDAD_ID) REFERENCES LOCALIDADES (ID);

ALTER TABLE RECIBOS ADD FOREIGN KEY (EMPLEADO_ID) REFERENCES EMPLEADOS (ID);
