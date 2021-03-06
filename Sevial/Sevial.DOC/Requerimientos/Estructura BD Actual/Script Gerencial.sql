USE [gerencial]
GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerConcZonal]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerConcZonal] 
(
	-- Add the parameters for the function here
	@IdMuncipio char(8)
)
RETURNS Varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Varchar(50)

	SELECT @Result = c.nombre
	from dbo.Municipio m, dbo.Concesionario c
	where m.IdMunicipio = @IdMuncipio
    and m.concesionario = c.IdConcesionario

	-- Return the result of the function
	RETURN @Result

END



GO
/****** Object:  UserDefinedFunction [dbo].[obtenerCtas]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[obtenerCtas] 
(
	-- Add the parameters for the function here
	@p_TipoRecaudo varchar(10) ,
	@p_TipoComparendo char(5),
	@p_IdBanco char(2),
	@p_IdConcesionario char(2)


)
RETURNS VArchar(1000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result VArchar(1000)

set @Result = ''

DECLARE @NumeroCuenta varchar(16), @IdBanco char(2), @IdConcesionario char(2), @TipoComparendo char(5)

DECLARE cuentas_cursor CURSOR FOR 
SELECT IdBanco, IdConcesionario, NumeroCuenta, TipoComparendo
FROM dbo.CuentaRecaudo
WHERE TipoRecaudo = @p_TipoRecaudo 

set @Result	= ' in ('''

OPEN cuentas_cursor

FETCH NEXT FROM cuentas_cursor 
INTO @IdBanco, @IdConcesionario, @NumeroCuenta, @TipoComparendo

DECLARE @ingreso bit
DECLARE @consultar bit

WHILE @@FETCH_STATUS = 0
BEGIN
	set @ingreso = 0

    set @consultar = 0

    if @p_TipoComparendo = 'TODOS'
       set @consultar = 1

    if @p_TipoComparendo = @TipoComparendo
       set @consultar = 1

    if (@p_IdConcesionario = '99' and @p_IdBanco = '99' and @consultar = 1 )
	begin
		set @Result = @Result + @NumeroCuenta 
		set @ingreso = 1
    end

	if (@p_IdConcesionario = '99' and @p_IdBanco <> '99' and @consultar = 1 )
		if (@p_IdBanco = @IdBanco )
		begin
			set @Result = @Result + @NumeroCuenta 
			set @ingreso = 1
	    end
	
	if (@p_IdConcesionario <> '99' and @p_IdBanco = '99' and @consultar = 1 )
		if (@p_IdConcesionario = @IdConcesionario )
		begin
			set @Result = @Result + @NumeroCuenta 
			set @ingreso = 1
		end

	if (@p_IdConcesionario <> '99' and @p_IdBanco <> '99' and @consultar = 1 )
		if (@p_IdConcesionario = @IdConcesionario and @p_IdBanco = @IdBanco  )
		begin
			set @Result = @Result + @NumeroCuenta 
			set @ingreso = 1
		end

	FETCH NEXT FROM cuentas_cursor 
	INTO @IdBanco, @IdConcesionario, @NumeroCuenta, @TipoComparendo

    if (@@FETCH_STATUS = 0 )
	begin	
		if (@ingreso = 1)
			set @Result = @Result + ''','''
	end	
	else
		set @Result = @Result + ''') '

END 

CLOSE cuentas_cursor
DEALLOCATE cuentas_cursor

RETURN @Result

END




GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerDptal]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerDptal] 
(
	-- Add the parameters for the function here
	@IdMuncipio char(8)
)
RETURNS Char(8)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Char(8)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = IdDepartamental
	from dbo.departamental
	where IdMunicipio = @IdMuncipio

	-- Return the result of the function
	RETURN @Result

END

GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerNomConcesionario]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
create FUNCTION [dbo].[ObtenerNomConcesionario] 
(
	-- Add the parameters for the function here
	@IdConcesionario char(2)
)
RETURNS Varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Varchar(50)


	-- Add the T-SQL statements to compute the return value here

	SELECT @Result = Nombre
	from dbo.Concesionario 
	where IdConcesionario = @IdConcesionario

	-- Return the result of the function
	RETURN @Result

END

GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerNomDptal]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerNomDptal] 
(
	-- Add the parameters for the function here
	@IdMuncipio char(8)
)
RETURNS Varchar(250)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Varchar(250)
	Declare @IdMuncipioDptal char(8)


	-- Add the T-SQL statements to compute the return value here
	SELECT @IdMuncipioDptal = IdDepartamental
	from dbo.departamental 
	where IdMunicipio = @IdMuncipio

	SELECT @Result = Nombre
	from dbo.Municipio 
	where IdMunicipio = @IdMuncipioDptal

	-- Return the result of the function
	RETURN @Result

END

GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerNomMunicipio]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerNomMunicipio] 
(
	-- Add the parameters for the function here
	@IdMuncipio char(8)
)
RETURNS Varchar(250)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Varchar(250)


	-- Add the T-SQL statements to compute the return value here

	SELECT @Result = Nombre
	from dbo.Municipio
	where IdMunicipio = @IdMuncipio

	-- Return the result of the function
    if (@Result is null )
    begin
        Set @Result =  @IdMuncipio
    end 

	RETURN @Result

END




GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerPeriodo]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerPeriodo] 
(
	-- Add the parameters for the function here
	@FechaProceso datetime,
    @Periodo int
)
RETURNS Varchar(50)
AS
BEGIN

	-- Declare the return variable here
	DECLARE @Result Varchar(50)

	-- Add the T-SQL statements to compute the return value here
   --Periodo trimestral
	if (@periodo = 1)
    begin
       select @Result = substring(convert(char(8),@FechaProceso,112),1,4) + '-' + periodo
       from dbo.Periodo
       where substring(convert(char(8),@FechaProceso,112),5,2) = mes	
    end
   -- periodo semestral
   if (@periodo = 2)
   begin
       select @Result = substring(convert(char(8),@FechaProceso,112),1,4) + '-' + semestre
       from dbo.Periodo
       where substring(convert(char(8),@FechaProceso,112),5,2) = mes	
    end
   --periodo Anual 
   if (@periodo = 3)
    begin
       select @Result = substring(convert(char(8),@FechaProceso,112),1,4) 
       from dbo.Periodo
       where substring(convert(char(8),@FechaProceso,112),5,2) = mes	
   end
    -- periodo bimestral
	if (@periodo = 4)
    begin
       select @Result = substring(convert(char(8),@FechaProceso,112),1,4) + '-' + bimestre
       from dbo.Periodo
       where substring(convert(char(8),@FechaProceso,112),5,2) = mes	
    end

	RETURN @Result

END





GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerZonaMun]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerZonaMun] 
(
	-- Add the parameters for the function here
	@IdMuncipio char(8)
)
RETURNS Varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Varchar(50)

	SELECT @Result = 'Zona ' + nombre
	from dbo.Municipio 
	where IdMunicipio = @IdMuncipio

	-- Return the result of the function
	RETURN @Result

END


GO
/****** Object:  Table [dbo].[Banco]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banco](
	[Idbanco] [char](2) NULL,
	[Nombre] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cargueDat]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cargueDat](
	[registro] [varchar](1000) NULL,
	[valor] [varchar](1000) NULL,
	[valorNew] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CargueDeuda]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CargueDeuda](
	[CONSECUTIVO_RECAUDO] [varchar](200) NULL,
	[ID_SECRETARIA_ORIGEN] [varchar](200) NULL,
	[ID_TIPO_DOC] [varchar](200) NULL,
	[IDENTIFICACION] [varchar](200) NULL,
	[NUMERO_REFERENCIA] [varchar](200) NULL,
	[NO_COMP] [varchar](200) NULL,
	[FECHA_TRANSACCION] [varchar](200) NULL,
	[FECHA_CONTABLE] [varchar](200) NULL,
	[VALOR_RECAUDO] [varchar](200) NULL,
	[VALOR_ADICIONAL] [varchar](200) NULL,
	[SUMA_PAGOS] [varchar](200) NULL,
	[VALOR_COM] [varchar](200) NULL,
	[FECHA_COM] [varchar](200) NULL,
	[TOTAL_RECAUDO] [varchar](200) NULL,
	[POLCA] [varchar](200) NULL,
	[ID_TIPO_RECAUDO] [varchar](200) NULL,
	[ID_ESTADO_RECAUDO] [varchar](200) NULL,
	[FEC_MOV_DESDE] [varchar](200) NULL,
	[FEC_MOV_HASTA] [varchar](200) NULL,
	[X45] [varchar](200) NULL,
	[XFCM] [varchar](200) NULL,
	[XMUN] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cargueTrf]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cargueTrf](
	[id_secretaria_origen] [varchar](250) NULL,
	[municipio] [varchar](250) NULL,
	[departamento] [varchar](250) NULL,
	[valorPagado] [varchar](250) NULL,
	[peridosCancelados] [varchar](250) NULL,
	[anoCancelado] [varchar](250) NULL,
	[fechaPago] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Concesionario]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Concesionario](
	[IdConcesionario] [char](2) NULL,
	[Nombre] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaRecaudo]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaRecaudo](
	[TipoRecaudo] [varchar](10) NOT NULL,
	[TipoComparendo] [varchar](5) NOT NULL,
	[IdBanco] [char](2) NOT NULL,
	[IdConcesionario] [char](2) NOT NULL,
	[NumeroCuenta] [varchar](16) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[departamental]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departamental](
	[idDepartamental] [char](8) NULL,
	[idMunicipio] [char](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[IdDepartamento] [char](2) NULL,
	[Nombre] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeudaReportada]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeudaReportada](
	[consecutivo_recaudo] [bigint] NULL,
	[id_secretaria_origen] [char](8) NULL,
	[id_tipo_doc] [char](1) NULL,
	[identificacion] [varchar](16) NULL,
	[numero_referencia] [varchar](16) NULL,
	[num_com] [varchar](20) NULL,
	[fecha_transaccion] [datetime] NULL,
	[fecha_contable] [datetime] NULL,
	[valor_recaudo] [money] NULL,
	[valor_adicional] [money] NULL,
	[suma_pagos] [money] NULL,
	[valor_com] [money] NULL,
	[fecha_com] [datetime] NULL,
	[total_recaudo] [money] NULL,
	[polca] [char](1) NULL,
	[id_tipo_recaudo] [char](1) NULL,
	[id_estado_recaudo] [char](1) NULL,
	[fecha_mov_desde] [datetime] NULL,
	[fecha_mov_hasta] [datetime] NULL,
	[x55] [money] NULL,
	[xfcm] [money] NULL,
	[xmun] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeudaReportadaUpload]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeudaReportadaUpload](
	[consecutivo_recaudo] [bigint] NULL,
	[id_secretaria_origen] [char](8) NULL,
	[id_tipo_doc] [char](1) NULL,
	[identificacion] [varchar](16) NULL,
	[numero_referencia] [varchar](16) NULL,
	[num_com] [varchar](20) NULL,
	[fecha_transaccion] [datetime] NULL,
	[fecha_contable] [datetime] NULL,
	[valor_recaudo] [money] NULL,
	[valor_adicional] [money] NULL,
	[suma_pagos] [money] NULL,
	[valor_com] [money] NULL,
	[fecha_com] [datetime] NULL,
	[total_recaudo] [money] NULL,
	[polca] [char](1) NULL,
	[id_tipo_recaudo] [char](1) NULL,
	[id_estado_recaudo] [char](1) NULL,
	[fecha_mov_desde] [datetime] NULL,
	[fecha_mov_hasta] [datetime] NULL,
	[x55] [money] NULL,
	[xfcm] [money] NULL,
	[xmun] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[log]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log](
	[informacion] [varchar](4000) NULL,
	[fecha] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[migraPostgres]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[migraPostgres](
	[cta_rec] [char](9) NULL,
	[fec_apl] [char](8) NULL,
	[fec_trn] [char](8) NULL,
	[ofi_trn] [varchar](250) NULL,
	[vlr_tot] [money] NULL,
	[cod_dan] [char](8) NULL,
	[cod_con] [char](2) NULL,
	[cod_con_due] [char](2) NULL,
	[zon_con_due] [varchar](50) NULL,
	[vlr_bas] [money] NULL,
	[ref1] [varchar](16) NULL,
	[ref2] [varchar](16) NULL,
	[vlr_mun] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MunicipioPLd]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MunicipioPLd](
	[IdMuncipio] [char](8) NOT NULL,
	[IdDepartamento] [char](2) NULL,
	[Nombre] [varchar](250) NULL,
	[IdMunicipioDptal] [char](8) NULL,
	[IdConcesionarioDueno] [char](2) NULL,
	[ZonaConcesionario] [varchar](50) NULL,
 CONSTRAINT [PK_Municipio] PRIMARY KEY CLUSTERED 
(
	[IdMuncipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Periodo]    Script Date: 07/03/2018 18:24:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Periodo](
	[Mes] [char](2) NULL,
	[Periodo] [varchar](50) NULL,
	[Semestre] [varchar](50) NULL,
	[Bimestre] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[public_recaudo]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[public_recaudo](
	[cta_rec] [nvarchar](9) NULL,
	[fec_apl] [nvarchar](8) NULL,
	[fec_trn] [nvarchar](8) NULL,
	[ofi_trn] [nvarchar](250) NULL,
	[vlr_tot] [float] NULL,
	[cod_dan] [nvarchar](8) NULL,
	[cod_con] [nvarchar](2) NULL,
	[cod_con_due] [nvarchar](2) NULL,
	[zon_con_due] [nvarchar](50) NULL,
	[vlr_bas] [float] NULL,
	[ref1] [nvarchar](16) NULL,
	[ref2] [nvarchar](16) NULL,
	[vlr_mun] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecaudoExterno]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecaudoExterno](
	[FechaRecaudo] [datetime] NULL,
	[CuentaRecaudo] [varchar](16) NULL,
	[FechaProceso] [datetime] NULL,
	[FechaDispersion] [datetime] NULL,
	[Oficina] [varchar](50) NULL,
	[NumeroLiquidacion] [varchar](16) NULL,
	[NumeroComparendo] [varchar](20) NULL,
	[Identificacion] [varchar](16) NULL,
	[Divipo] [char](8) NULL,
	[Municipio] [varchar](250) NULL,
	[Departamento] [varchar](250) NULL,
	[TipoRecaudo] [char](5) NULL,
	[IdConcesionarioLiquidador] [char](2) NULL,
	[IdConcesionarioZon] [char](2) NULL,
	[Validador] [char](3) NULL,
	[Fecha2002] [char](1) NULL,
	[VRecaudo] [money] NULL,
	[VAdicional] [money] NULL,
	[VBase] [money] NULL,
	[VSimitBase] [money] NULL,
	[VCLiquidador] [money] NULL,
	[VSimit] [money] NULL,
	[VFCSimit] [money] NULL,
	[VFCConcesionario] [money] NULL,
	[VEquilibrio] [money] NULL,
	[EE18] [money] NULL,
	[EE2] [money] NULL,
	[VSevial3] [money] NULL,
	[VSevial27] [money] NULL,
	[VIva27] [money] NULL,
	[VFCM18] [money] NULL,
	[VIva18] [money] NULL,
	[VPolca] [money] NULL,
	[VTimbre27] [money] NULL,
	[VTimbre27_18] [money] NULL,
	[VRetencion27] [money] NULL,
	[VOperadorCon] [money] NULL,
	[VFcmCon] [money] NULL,
	[VAcuerdo] [money] NULL,
	[VTercero1] [money] NULL,
	[VTercero2] [money] NULL,
	[VTercero3] [money] NULL,
	[VMunicipio] [money] NULL,
	[VIvaCon] [money] NULL,
	[VTimbreCon] [money] NULL,
	[VRetencionContConc] [money] NULL,
	[VTimbreContCon] [money] NULL,
	[FechaComparendo] [datetime] NULL,
	[FechaDispOpe] [datetime] NULL,
	[TipoRec] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecaudoExternoUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecaudoExternoUpload](
	[FechaRecaudo] [datetime] NULL,
	[CuentaRecaudo] [varchar](16) NULL,
	[FechaProceso] [datetime] NULL,
	[FechaDispersion] [datetime] NULL,
	[Oficina] [varchar](50) NULL,
	[NumeroLiquidacion] [varchar](16) NOT NULL,
	[NumeroComparendo] [varchar](20) NULL,
	[Identificacion] [varchar](16) NULL,
	[Divipo] [char](8) NULL,
	[Municipio] [varchar](250) NULL,
	[Departamento] [varchar](250) NULL,
	[TipoRecaudo] [char](5) NULL,
	[IdConcesionarioLiquidador] [char](2) NULL,
	[IdConcesionarioZon] [char](2) NULL,
	[Validador] [char](3) NULL,
	[Fecha2002] [char](1) NULL,
	[VRecaudo] [money] NULL,
	[VAdicional] [money] NULL,
	[VBase] [money] NULL,
	[VSimitBase] [money] NULL,
	[VCLiquidador] [money] NULL,
	[VSimit] [money] NULL,
	[VFCSimit] [money] NULL,
	[VFCConcesionario] [money] NULL,
	[VEquilibrio] [money] NULL,
	[EE18] [money] NULL,
	[EE2] [money] NULL,
	[VSevial3] [money] NULL,
	[VSevial27] [money] NULL,
	[VIva27] [money] NULL,
	[VFCM18] [money] NULL,
	[VIva18] [money] NULL,
	[VPolca] [money] NULL,
	[VTimbre27] [money] NULL,
	[VTimbre27_18] [money] NULL,
	[VRetencion27] [money] NULL,
	[VOperadorCon] [money] NULL,
	[VFcmCon] [money] NULL,
	[VAcuerdo] [money] NULL,
	[VTercero1] [money] NULL,
	[VTercero2] [money] NULL,
	[VTercero3] [money] NULL,
	[VMunicipio] [money] NULL,
	[VIvaCon] [money] NULL,
	[VTimbreCon] [money] NULL,
	[VRetencionContConc] [money] NULL,
	[VTimbreContCon] [money] NULL,
	[FechaComparendo] [datetime] NULL,
	[FechaDispOpe] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecaudoLocal]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecaudoLocal](
	[banco] [varchar](250) NULL,
	[operador] [varchar](50) NULL,
	[cuenta] [varchar](50) NULL,
	[fechaCorte] [datetime] NULL,
	[divipo] [char](8) NULL,
	[municipio] [varchar](250) NULL,
	[departamento] [varchar](250) NULL,
	[origen] [char](3) NULL,
	[fechaTrn] [datetime] NULL,
	[oficinaTrn] [varchar](250) NULL,
	[fechaDisp] [datetime] NULL,
	[vRecaudo] [money] NULL,
	[simitPm] [money] NULL,
	[simitPP] [money] NULL,
	[fcm325] [money] NULL,
	[fondoSimit] [money] NULL,
	[concesionario] [money] NULL,
	[comision] [money] NULL,
	[operador325] [money] NULL,
	[fondoConcesionario] [money] NULL,
	[sevial3] [money] NULL,
	[sevial27] [money] NULL,
	[sevial] [money] NULL,
	[iva27] [money] NULL,
	[retef27] [money] NULL,
	[timbre27] [money] NULL,
	[netoSevial] [money] NULL,
	[fcm18] [money] NULL,
	[iva18] [money] NULL,
	[timbre18] [money] NULL,
	[netoFcm] [money] NULL,
	[polca] [money] NULL,
	[equilibrioPM] [money] NULL,
	[equilibrioPP] [money] NULL,
	[equlibrioCP] [money] NULL,
	[netoEquilibrio] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecaudoLocalUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecaudoLocalUpload](
	[banco] [varchar](250) NULL,
	[operador] [varchar](50) NULL,
	[cuenta] [varchar](50) NULL,
	[fechaCorte] [datetime] NULL,
	[divipo] [char](8) NULL,
	[municipio] [varchar](250) NULL,
	[departamento] [varchar](250) NULL,
	[origen] [char](3) NULL,
	[fechaTrn] [datetime] NULL,
	[oficinaTrn] [varchar](250) NULL,
	[fechaDisp] [datetime] NULL,
	[vRecaudo] [money] NULL,
	[simitPm] [money] NULL,
	[simitPP] [money] NULL,
	[fcm325] [money] NULL,
	[fondoSimit] [money] NULL,
	[concesionario] [money] NULL,
	[comision] [money] NULL,
	[operador325] [money] NULL,
	[fondoConcesionario] [money] NULL,
	[sevial3] [money] NULL,
	[sevial27] [money] NULL,
	[sevial] [money] NULL,
	[iva27] [money] NULL,
	[retef27] [money] NULL,
	[timbre27] [money] NULL,
	[netoSevial] [money] NULL,
	[fcm18] [money] NULL,
	[iva18] [money] NULL,
	[timbre18] [money] NULL,
	[netoFcm] [money] NULL,
	[polca] [money] NULL,
	[equilibrioPM] [money] NULL,
	[equilibrioPP] [money] NULL,
	[equlibrioCP] [money] NULL,
	[netoEquilibrio] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecaudoSimit]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecaudoSimit](
	[banco] [varchar](250) NULL,
	[cuenta] [varchar](50) NULL,
	[operador] [varchar](50) NULL,
	[fechaCorte] [datetime] NULL,
	[divipo] [char](8) NULL,
	[municipio] [varchar](250) NULL,
	[departamento] [varchar](250) NULL,
	[origen] [char](3) NULL,
	[fechaTrn] [datetime] NULL,
	[oficinaTrn] [varchar](250) NULL,
	[fechaDisp] [datetime] NULL,
	[vRecaudo] [money] NULL,
	[concesionario] [money] NULL,
	[comision] [money] NULL,
	[operador65] [money] NULL,
	[fondoConcesionario] [money] NULL,
	[fcm25] [money] NULL,
	[fondoSimit] [money] NULL,
	[Equilibrio] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecaudoSimitUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecaudoSimitUpload](
	[banco] [varchar](250) NULL,
	[cuenta] [varchar](50) NULL,
	[operador] [varchar](50) NULL,
	[fechaCorte] [datetime] NULL,
	[divipo] [char](8) NULL,
	[municipio] [varchar](250) NULL,
	[departamento] [varchar](250) NULL,
	[origen] [char](3) NULL,
	[fechaTrn] [datetime] NULL,
	[oficinaTrn] [varchar](250) NULL,
	[fechaDisp] [datetime] NULL,
	[vRecaudo] [money] NULL,
	[concesionario] [money] NULL,
	[comision] [money] NULL,
	[operador65] [money] NULL,
	[fondoConcesionario] [money] NULL,
	[fcm25] [money] NULL,
	[fondoSimit] [money] NULL,
	[Equilibrio] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt1]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt1](
	[IdMunicipio] [char](8) NULL,
	[Nombre] [varchar](250) NULL,
	[Valor] [money] NULL,
	[NroReg] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt10]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt10](
	[ValorMesAnt] [money] NULL,
	[NroMesAnt] [int] NULL,
	[ValorMesAct] [money] NULL,
	[NroMesAct] [int] NULL,
	[RecaudoMesAnt] [money] NULL,
	[NroRecaudosMesAnt] [int] NULL,
	[MultaMesAnt] [money] NULL,
	[RecaudoMesAct] [money] NULL,
	[NroRcaudosMesAct] [int] NULL,
	[MultaMesAct] [money] NULL,
	[MultaMaxima] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt2]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt2](
	[ValorRec] [money] NULL,
	[NroReg] [int] NULL,
	[VCLiquidador] [money] NULL,
	[VFondo] [money] NULL,
	[VSevial3] [money] NULL,
	[VSevial27] [money] NULL,
	[VIva27] [money] NULL,
	[VTimbre27] [money] NULL,
	[VRetencion27] [money] NULL,
	[VSevial27Base] [money] NULL,
	[Fecha] [char](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt2_banco]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt2_banco](
	[ValorRec] [money] NULL,
	[NroReg] [int] NULL,
	[NumeroCuenta] [varchar](16) NULL,
	[idBanco] [char](2) NULL,
	[banco] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt3]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt3](
	[ValorRec] [money] NULL,
	[NroReg] [int] NULL,
	[VCLiquidador] [money] NULL,
	[VFondo] [money] NULL,
	[VSevial57] [money] NULL,
	[Fecha] [char](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt5]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt5](
	[Oficina] [varchar](50) NULL,
	[Valor] [money] NULL,
	[NroReg] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt6]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt6](
	[ZonaConcesionario] [varchar](50) NULL,
	[Valor] [money] NULL,
	[NroReg] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpt9]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt9](
	[Concesionario] [varchar](50) NULL,
	[Valor] [money] NULL,
	[NroReg] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptA]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptA](
	[Concesionario] [varchar](50) NULL,
	[Zona] [varchar](50) NULL,
	[Valor] [money] NULL,
	[NroReg] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptC]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptC](
	[Concesionario] [varchar](50) NULL,
	[IdMunicipio] [char](8) NULL,
	[Nombre] [varchar](250) NULL,
	[Valor] [money] NULL,
	[NroReg] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptD]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptD](
	[FechaProceso] [datetime] NULL,
	[FechaRecaudo] [datetime] NULL,
	[VRecaudo] [money] NULL,
	[NumeroLiquidacion] [varchar](16) NULL,
	[Identificacion] [varchar](16) NULL,
	[Divipo] [char](8) NULL,
	[Municipio] [varchar](250) NULL,
	[TipoRecaudo] [char](5) NULL,
	[VMunicipio] [money] NULL,
	[NumeroComparendo] [varchar](20) NULL,
	[FechaComparendo] [datetime] NULL,
	[FechaDispersion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptE]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptE](
	[Periodo] [varchar](50) NULL,
	[Valor] [money] NULL,
	[NroReg] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptH]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptH](
	[id_secretaria_origen] [char](8) NULL,
	[identificacion] [varchar](16) NULL,
	[numero_referencia] [varchar](20) NULL,
	[fecha_transaccion] [datetime] NULL,
	[total_recaudo] [money] NULL,
	[polca] [char](1) NULL,
	[x55] [money] NULL,
	[nombre] [varchar](250) NULL,
	[fec_pago] [datetime] NULL,
	[x45] [money] NULL,
	[x10] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptH_Total]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptH_Total](
	[fecha] [char](4) NULL,
	[total_recuado] [money] NULL,
	[x55] [money] NULL,
	[VlrTransferido] [money] NULL,
	[VlrDeuda] [money] NULL,
	[nombre] [varchar](250) NULL,
	[idMunicipio] [char](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptH_vig]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptH_vig](
	[id_secretaria_origen] [varchar](50) NULL,
	[vigencia] [varchar](500) NULL,
	[vlrTrf] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptJ]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptJ](
	[id_secretaria_origen] [char](8) NULL,
	[identificacion] [varchar](16) NULL,
	[numero_referencia] [varchar](20) NULL,
	[fecha_transaccion] [datetime] NULL,
	[total_recaudo] [money] NULL,
	[polca] [char](1) NULL,
	[x55] [money] NULL,
	[nombre] [varchar](250) NULL,
	[fec_pago] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptJ_Total]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptJ_Total](
	[fecha] [char](4) NULL,
	[total_recuado] [money] NULL,
	[x55] [money] NULL,
	[VlrTransferido] [money] NULL,
	[VlrDeuda] [money] NULL,
	[nombre] [varchar](250) NULL,
	[idMunicipio] [char](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrfReportada]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrfReportada](
	[id_secretaria_origen] [varchar](8) NULL,
	[valor_trf] [money] NULL,
	[vigencia] [varchar](500) NULL,
	[fecha_trf] [datetime] NULL,
	[polca] [varchar](1) NULL,
	[fecha_pago] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarDeuda]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ActualizarDeuda]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete from  dbo.DeudaReportada
    where id_secretaria_origen in (select DISTINCT id_secretaria_origen from dbo.DeudaReportadaUpload ) and
    polca in ( select DISTINCT polca from dbo.DeudaReportadaUpload )

	insert into dbo.DeudaReportada
	select * from dbo.DeudaReportadaUpload

END





GO
/****** Object:  StoredProcedure [dbo].[ActualizarRecExt]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRecExt]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete from dbo.RecaudoExterno
	where 
	TipoRec	= 'EXTERNO' AND
    FechaProceso in (select distinct FechaProceso 
							from dbo.RecaudoExternoUpload)

	insert into dbo.RecaudoExterno
	select *,'EXTERNO' from dbo.RecaudoExternoUpload

END



GO
/****** Object:  StoredProcedure [dbo].[ActualizarRecLoc]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRecLoc]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete from dbo.RecaudoLocal
	where FechaCorte in (select distinct FechaCorte 
							from dbo.RecaudoLocalUpload)

	insert into dbo.RecaudoLocal
	select * from dbo.RecaudoLocalUpload

	delete from dbo.Recaudoexterno
	where 
	TipoRec = 'LOCAL' and
    TipoRecaudo = 'POLCA' and
	FechaProceso in (select distinct FechaCorte 
							from dbo.RecaudoLocalUpload)


INSERT INTO [dbo].[RecaudoExterno]
           ([FechaRecaudo]
           ,[CuentaRecaudo]
           ,[FechaProceso]
           ,[FechaDispersion]
           ,[Oficina]
           ,[NumeroLiquidacion]
           ,[NumeroComparendo]
           ,[Identificacion]
           ,[Divipo]
           ,[Municipio]
           ,[Departamento]
           ,[TipoRecaudo]
           ,[IdConcesionarioLiquidador]
           ,[IdConcesionarioZon]
           ,[Validador]
           ,[Fecha2002]
           ,[VRecaudo]
           ,[VAdicional]
           ,[VBase]
           ,[VSimitBase]
           ,[VCLiquidador]
           ,[VSimit]
           ,[VFCSimit]
           ,[VFCConcesionario]
           ,[VEquilibrio]
           ,[EE18]
           ,[EE2]
           ,[VSevial3]
           ,[VSevial27]
           ,[VIva27]
           ,[VFCM18]
           ,[VIva18]
           ,[VPolca]
           ,[VTimbre27]
           ,[VTimbre27_18]
           ,[VRetencion27]
           ,[VOperadorCon]
           ,[VFcmCon]
           ,[VAcuerdo]
           ,[VTercero1]
           ,[VTercero2]
           ,[VTercero3]
           ,[VMunicipio]
           ,[VIvaCon]
           ,[VTimbreCon]
           ,[VRetencionContConc]
           ,[VTimbreContCon]
           ,[FechaComparendo]
           ,[FechaDispOpe]
           ,[TipoRec])

SELECT
      [fechaTrn]
      ,[cuenta]
      ,[fechaCorte]
      ,[fechaDisp]
      ,[oficinaTrn]
	  ,'' -- numero liquidacion
      ,'' -- numero comparendo
	  ,'' -- identificacion      
      ,[divipo]
      ,[municipio]
      ,[departamento]
      ,'POLCA'
      ,(CASE WHEN operador = 'REMO S.A.' then '01'
        WHEN operador = 'SERVIT LTDA' then '02'
        WHEN operador = 'SEVIAL S.A' then '03'
		WHEN operador = 'SIMIT OCCIDENTE' then '04'
		WHEN operador = 'SIMIT CAPITAL' then '05'
        ELSE '06'
        END ) -- IdConcesionarioLiquidador
      ,(CASE WHEN operador = 'REMO S.A.' then '01'
        WHEN operador = 'SERVIT LTDA' then '02'
        WHEN operador = 'SEVIAL S.A' then '03'
		WHEN operador = 'SIMIT OCCIDENTE' then '04'
		WHEN operador = 'SIMIT CAPITAL' then '05'
        ELSE '06'
        END ) -- IdConcesionarioZon
      ,'000' -- Validador
      ,'0'  -- Fecha2002
      ,[vRecaudo]
      ,0 --  VAdicional
      ,[vRecaudo] --VBase
      ,concesionario+[fcm325]+ [fondoConcesionario]+[fondoSimit]+[sevial3]  --VSimitBase
      ,concesionario--VCLiquidador
      ,[fcm325] -- VSimit
      ,[fondoConcesionario]
      ,[fondoSimit]
      ,0 -- VEquilibrio
      ,0 -- EE18
      ,0 -- EE2
      ,[sevial3]
      ,[sevial27] - [timbre27] - [retef27] + [iva27] -- VSevial27 
      ,[iva27]
      ,[fcm18] + [iva18] + [timbre27] + [retef27]  -- VFCM18
      ,[iva18]
      ,[polca]
      ,[timbre27]
      ,([sevial27] + [fcm18] ) * 0.0075 -- VTimbre27_18
      ,[retef27]
      ,0 --  VOperadorCon  
      ,0 --  VFcmCon  
      ,0 --  VAcuerdo
      ,0 --  VTercero1
	  ,0 --  VTercero2
      ,0 --  VTercero3
      ,0 --  VMunicipio
      ,0 --  VIvaCon
      ,0 --  VTimbreCon
      ,0 --  VRetencionContConc
      ,0 --  VTimbreContCon
      ,null -- FechaComparendo
      ,[fechaDisp]
      ,'LOCAL'
     
  FROM [dbo].RecaudoLocalUpload
     
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRecSim]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRecSim]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete from dbo.RecaudoSimit
	where FechaCorte in (select distinct FechaCorte 
							from dbo.RecaudoSimitUpload)

	insert into dbo.RecaudoSimit
	select * from dbo.RecaudoSimitUpload

	delete from dbo.Recaudoexterno
	where 
	TipoRec = 'LOCAL' and
    TipoRecaudo = 'SIMIT' and
	FechaProceso in (select distinct FechaCorte 
							from dbo.RecaudoSimitUpload)


INSERT INTO [dbo].[RecaudoExterno]
           ([FechaRecaudo]
           ,[CuentaRecaudo]
           ,[FechaProceso]
           ,[FechaDispersion]
           ,[Oficina]
           ,[NumeroLiquidacion]
           ,[NumeroComparendo]
           ,[Identificacion]
           ,[Divipo]
           ,[Municipio]
           ,[Departamento]
           ,[TipoRecaudo]
           ,[IdConcesionarioLiquidador]
           ,[IdConcesionarioZon]
           ,[Validador]
           ,[Fecha2002]
           ,[VRecaudo]
           ,[VAdicional]
           ,[VBase]
           ,[VSimitBase]
           ,[VCLiquidador]
           ,[VSimit]
           ,[VFCSimit]
           ,[VFCConcesionario]
           ,[VEquilibrio]
           ,[EE18]
           ,[EE2]
           ,[VSevial3]
           ,[VSevial27]
           ,[VIva27]
           ,[VFCM18]
           ,[VIva18]
           ,[VPolca]
           ,[VTimbre27]
           ,[VTimbre27_18]
           ,[VRetencion27]
           ,[VOperadorCon]
           ,[VFcmCon]
           ,[VAcuerdo]
           ,[VTercero1]
           ,[VTercero2]
           ,[VTercero3]
           ,[VMunicipio]
           ,[VIvaCon]
           ,[VTimbreCon]
           ,[VRetencionContConc]
           ,[VTimbreContCon]
           ,[FechaComparendo]
           ,[FechaDispOpe]
           ,[TipoRec]

)

SELECT
      [fechaTrn]
      ,[cuenta]
      ,[fechaCorte]
      ,[fechaDisp]
      ,substring([oficinaTrn],1,50)
	  ,'' -- numero liquidacion
      ,'' -- numero comparendo
	  ,'' -- identificacion      
      ,[divipo]
      ,[municipio]
      ,[departamento]
      ,'SIMIT'
      ,(CASE WHEN operador = 'REMO S.A.' then '01'
        WHEN operador = 'SERVIT LTDA' then '02'
        WHEN operador = 'SEVIAL S.A' then '03'
		WHEN operador = 'SIMIT OCCIDENTE' then '04'
		WHEN operador = 'SIMIT CAPITAL' then '05'
        ELSE '06'
        END ) -- IdConcesionarioLiquidador
      ,(CASE WHEN operador = 'REMO S.A.' then '01'
        WHEN operador = 'SERVIT LTDA' then '02'
        WHEN operador = 'SEVIAL S.A' then '03'
		WHEN operador = 'SIMIT OCCIDENTE' then '04'
		WHEN operador = 'SIMIT CAPITAL' then '05'
        ELSE '06'
        END ) -- IdConcesionarioZon
      ,'000' -- Validador
      ,'0'  -- Fecha2002
      ,[vRecaudo]
      ,0 --  VAdicional
      ,[vRecaudo] --VBase
      ,concesionario+[fcm25]+ [fondoConcesionario]+[fondoSimit]  --VSimitBase
      ,concesionario--VCLiquidador
      ,[fcm25] -- VSimit
      ,[fondoConcesionario]
      ,[fondoSimit]
      ,0 -- VEquilibrio
      ,0 -- EE18
      ,0 -- EE2
      ,0 --[sevial3]
      ,0 --[sevial27] - [timbre27] - [retef27] + [iva27] -- VSevial27 
      ,0 --[iva27]
      ,0 --[fcm18] + [iva18] + [timbre27] + [retef27]  -- VFCM18
      ,0 --[iva18]
      ,0 --[polca]
      ,0 --[timbre27]
      ,0 --([sevial27] + [fcm18] ) * 0.0075 -- VTimbre27_18
      ,0 --[retef27]
      ,0 --  VOperadorCon  
      ,0 --  VFcmCon  
      ,0 --  VAcuerdo
      ,0 --  VTercero1
	  ,0 --  VTercero2
      ,0 --  VTercero3
      ,0 --  VMunicipio
      ,0 --  VIvaCon
      ,0 --  VTimbreCon
      ,0 --  VRetencionContConc
      ,0 --  VTimbreContCon
      ,null -- FechaComparendo
      ,[fechaDisp]
      ,'LOCAL'
     
  FROM [dbo].RecaudoSimitUpload
     
END
GO
/****** Object:  StoredProcedure [dbo].[CargarDeudaPolca]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CargarDeudaPolca]
@codRespuesta int output
,@mensajeRespuesta varchar(4000) output

AS
BEGIN

SET NOCOUNT ON;
BEGIN TRY

DECLARE @sql varchar(8000)
declare @name varchar(500)

delete from gerencial.dbo.log


INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Inicia Cargue Polca' ,getdate())


--truncate table dbo.cargueDat
truncate table dbo.cargueDeuda


CREATE TABLE #files (name varchar(200) NULL, sql varchar(7000) NULL)

INSERT #files(name)
   exec master..xp_cmdshell 'dir /b D:\Datos\dataRecLocal\POLCA\*'

--UPDATE #files
--SET   sql  = 'BULK INSERT dbo.cargueDat FROM ''' + 'H:\Datos\dataRecLocal\POLCA\' +name + ''' WITH (' +
--             'DATAFILETYPE = ''char'', FIELDTERMINATOR = '';'', FIRSTROW=2, ' +
--             'ROWTERMINATOR = ''\n'')'

UPDATE #files
set sql = 'BULK INSERT gerencial.dbo.cargueDeuda FROM ''D:\Datos\dataRecLocal\POLCA\' + +name  + ''' WITH (' +
             'FIRSTROW=2, MAXERRORS = 0, FORMATFILE = ''D:\Datos\dataRecLocal\cargueDeuda.fmt'' ) '


DECLARE cur CURSOR STATIC LOCAL FOR
   SELECT sql, name FROM #files

OPEN cur

WHILE 1 = 1
BEGIN
   FETCH cur INTO @sql, @name
   IF @@fetch_status <> 0
      BREAK

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga Archivo ' + @name ,getdate())

EXEC(@sql)

END


--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Inicia ajuste ' ,getdate())

--update dbo.cargueDat
--set registro = replace ( replace (  replace(registro,'","',';'), '"', '' ), ',','.')

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Finaliza ajuste ' ,getdate())

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Crea archivo temporal ' ,getdate())

--exec master..xp_cmdshell 'bcp gerencial.dbo.CargueDat out H:\Datos\dataRecLocal\Temp\polca.dat -T -c -Useguimiento -Ssevialppal\sqlexpress -Pseguimiento'

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Archivo temporal OK ' ,getdate())

--truncate table dbo.cargueDeuda

--SET @sql = 'BULK INSERT dbo.cargueDeuda FROM ''H:\Datos\dataRecLocal\Temp\polca.dat'' WITH (' +
--             'DATAFILETYPE = ''char'', FIELDTERMINATOR = '';'', FIRSTROW=1, ' +
--             'ROWTERMINATOR = ''\n'')'

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Carga archivo temporal' ,getdate())

--EXEC(@sql)

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Carga archivo temporal OK' ,getdate())

update cargueDeuda
set VALOR_RECAUDO = replace(VALOR_RECAUDO,',','.'),
VALOR_ADICIONAL = replace(VALOR_ADICIONAL,',','.'),
VALOR_COM = replace(VALOR_COM,',','.'),
TOTAL_RECAUDO = replace(TOTAL_RECAUDO,',','.'),
X45 = replace(X45,',','.'),
Xfcm = replace(Xfcm,',','.'),
Xmun = replace(Xmun,',','.')


INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Borra informacion anterior' ,getdate())

delete from  dbo.DeudaReportada
where polca = 'S'
--id_secretaria_origen in (select DISTINCT id_secretaria_origen from dbo.cargueDeuda ) and
      

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga deuda' ,getdate())


INSERT INTO [dbo].[DeudaReportada]
           ([consecutivo_recaudo]
           ,[id_secretaria_origen]
           ,[id_tipo_doc]
           ,[identificacion]
           ,[numero_referencia]
           ,[num_com]
           ,[fecha_transaccion]
           ,[fecha_contable]
           ,[valor_recaudo]
           ,[valor_adicional]
           ,[suma_pagos]
           ,[valor_com]
           ,[fecha_com]
           ,[total_recaudo]
           ,[polca]
           ,[id_tipo_recaudo]
           ,[id_estado_recaudo]
           ,[fecha_mov_desde]
           ,[fecha_mov_hasta]
           ,[x55]
           ,[xfcm]
           ,[xmun])
SELECT convert(bigint,[CONSECUTIVO_RECAUDO])
      ,substring([ID_SECRETARIA_ORIGEN],1,8)
      ,substring([ID_TIPO_DOC],1,1)
      ,substring([IDENTIFICACION],1,16)
      ,substring([NUMERO_REFERENCIA],1,16)
      ,substring([NO_COMP],1,20)
      ,null --convert(datetime,[FECHA_TRANSACCION],103)
      ,convert(datetime,[FECHA_CONTABLE],103)
      ,convert(money,[VALOR_RECAUDO])
      ,convert(money,[VALOR_ADICIONAL])
      ,convert(money,[SUMA_PAGOS])
      ,convert(money,[VALOR_COM])
      ,convert(datetime,[FECHA_COM],103)
      ,convert(money,[TOTAL_RECAUDO])
      ,substring([POLCA],1,1)
      ,substring([ID_TIPO_RECAUDO],1,1)
      ,substring([ID_ESTADO_RECAUDO],1,1)
      ,null --convert(datetime,[FEC_MOV_DESDE],103)
      ,null --convert(datetime,[FEC_MOV_HASTA],103)
      ,convert(money,[X45])
      ,convert(money,[XFCM])
      ,convert(money,[XMUN])
  FROM [dbo].[CargueDeuda]
--  where isnumeric([VALOR_RECAUDO]) = 1

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Cargue Exitoso' ,getdate())

set @codRespuesta = 0
set @mensajeRespuesta = 'Operacion Correcta'


END TRY

BEGIN CATCH

  SELECT @mensajeRespuesta = ERROR_MESSAGE(),@codRespuesta = ERROR_SEVERITY();

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Problemas en cargue ' + @mensajeRespuesta ,getdate())

END CATCH;


END









GO
/****** Object:  StoredProcedure [dbo].[CargarDeudaSimit]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CargarDeudaSimit]
@codRespuesta int output
,@mensajeRespuesta varchar(4000) output

AS
BEGIN

SET NOCOUNT ON;
BEGIN TRY

DECLARE @sql varchar(8000)
DECLARE @name varchar(500)

delete from gerencial.dbo.log

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Inicio proceso Cargue Deuda Simit' ,getdate())

truncate table dbo.cargueDeuda

CREATE TABLE #files (name varchar(200) NULL, sql varchar(7000) NULL)

INSERT #files(name)
   exec master..xp_cmdshell 'dir /b D:\Datos\dataRecLocal\SIMIT\*'

UPDATE #files
set sql = 'BULK INSERT gerencial.dbo.cargueDeuda FROM ''D:\Datos\dataRecLocal\SIMIT\' + +name  + ''' WITH (' +
             'FIRSTROW=2, MAXERRORS = 0, FORMATFILE = ''D:\Datos\dataRecLocal\cargueDeuda.fmt'' ) '


DECLARE cur CURSOR STATIC LOCAL FOR
   SELECT sql, name FROM #files

OPEN cur

WHILE 1 = 1
BEGIN
   FETCH cur INTO @sql, @name
   IF @@fetch_status <> 0
      BREAK

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga archivo ' + @name ,getdate())

EXEC(@sql)

END


update cargueDeuda
set VALOR_RECAUDO = replace(VALOR_RECAUDO,',','.'),
VALOR_ADICIONAL = replace(VALOR_ADICIONAL,',','.'),
VALOR_COM = replace(VALOR_COM,',','.'),
TOTAL_RECAUDO = replace(TOTAL_RECAUDO,',','.'),
X45 = replace(X45,',','.'),
Xfcm = replace(Xfcm,',','.'),
Xmun = replace(Xmun,',','.')

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Inicia ajuste ' ,getdate())


--update dbo.cargueDat
--set registro = replace ( replace (  replace(registro,'","',';'), '"', '' ), ',','.')

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Finaliza ajuste ' ,getdate())

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Inicia archivo temporal' ,getdate())

--exec master..xp_cmdshell 'bcp gerencial.dbo.CargueDat out H:\Datos\dataRecLocal\Temp\simit.dat -T -c -Useguimiento -Ssevialppal\sqlexpress -Pseguimiento'

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Creo archivo temporal' ,getdate())

--truncate table dbo.cargueDeuda

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Inicia cargue temporal' ,getdate())

--SET @sql = 'BULK INSERT dbo.cargueDeuda FROM ''H:\Datos\dataRecLocal\Temp\simit.dat'' WITH (' +
--             'DATAFILETYPE = ''char'', FIELDTERMINATOR = '';'', FIRSTROW=1, ' +
--             'ROWTERMINATOR = ''\n'')'

--EXEC(@sql)

--INSERT INTO [dbo].[log] ([informacion],[fecha])
--VALUES  ('Finaliza cargue temporal' ,getdate())

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Borra datos anteriores' ,getdate())


delete from  dbo.DeudaReportada
where polca = 'N'
--id_secretaria_origen in (select DISTINCT id_secretaria_origen from dbo.cargueDeuda ) and
--      polca = 'N'

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga deuda' ,getdate())

INSERT INTO [dbo].[DeudaReportada]
           ([consecutivo_recaudo]
           ,[id_secretaria_origen]
           ,[id_tipo_doc]
           ,[identificacion]
           ,[numero_referencia]
           ,[num_com]
           ,[fecha_transaccion]
           ,[fecha_contable]
           ,[valor_recaudo]
           ,[valor_adicional]
           ,[suma_pagos]
           ,[valor_com]
           ,[fecha_com]
           ,[total_recaudo]
           ,[polca]
           ,[id_tipo_recaudo]
           ,[id_estado_recaudo]
           ,[fecha_mov_desde]
           ,[fecha_mov_hasta]
           ,[x55]
           ,[xfcm]
           ,[xmun])
SELECT convert(bigint,[CONSECUTIVO_RECAUDO])
      ,substring([ID_SECRETARIA_ORIGEN],1,8)
      ,substring([ID_TIPO_DOC],1,1)
      ,substring([IDENTIFICACION],1,16)
      ,substring([NUMERO_REFERENCIA],1,16)
      ,substring([NO_COMP],1,20)
      ,null --convert(datetime,[FECHA_TRANSACCION],103)
      ,convert(datetime,[FECHA_CONTABLE],103)
      ,convert(money,[VALOR_RECAUDO])
      ,convert(money,[VALOR_ADICIONAL])
      ,convert(money,[SUMA_PAGOS])
      ,convert(money,[VALOR_COM])
      ,convert(datetime,[FECHA_COM],103)
      ,convert(money,[TOTAL_RECAUDO])
      ,substring([POLCA],1,1)
      ,substring([ID_TIPO_RECAUDO],1,1)
      ,substring([ID_ESTADO_RECAUDO],1,1)
      ,null --convert(datetime,[FEC_MOV_DESDE],103)
      ,null --convert(datetime,[FEC_MOV_HASTA],103)
      ,convert(money,[X45])
      ,convert(money,[XFCM])
      ,convert(money,[XMUN])
  FROM [dbo].[CargueDeuda]
--  where isnumeric([VALOR_RECAUDO]) = 1

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Cargue Exitoso' ,getdate())


set @codRespuesta = 0
set @mensajeRespuesta = 'Operacion Correcta'


END TRY

BEGIN CATCH

  SELECT @mensajeRespuesta = ERROR_MESSAGE(),@codRespuesta = ERROR_SEVERITY();

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Problemas en cargue ' + @mensajeRespuesta  ,getdate())

END CATCH;

END






GO
/****** Object:  StoredProcedure [dbo].[CargarTrfPolca]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CargarTrfPolca]
@codRespuesta int output
,@mensajeRespuesta varchar(4000) output

AS
BEGIN

SET NOCOUNT ON;
BEGIN TRY

DECLARE @sql varchar(8000)
declare @name varchar(500)

truncate table dbo.cargueDat
truncate table dbo.log

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Inicia Cargue Trf Polca' ,getdate())

truncate table dbo.cargueDat

--drop table #files

CREATE TABLE #files (name varchar(200) NULL, sql varchar(7000) NULL)

INSERT #files(name)
   exec master..xp_cmdshell 'dir /b D:\Datos\dataTransfer\POLCA\*'

delete #files
where name is null;


UPDATE #files
set sql = 'BULK INSERT gerencial.dbo.cargueDat FROM ''D:\Datos\dataTransfer\POLCA\' + +name  + ''' WITH (' +
             'FIRSTROW=2, MAXERRORS = 0, FORMATFILE = ''D:\Datos\dataTransfer\cargueIni.fmt'' ) '

SELECT sql, name FROM #files

DECLARE cur CURSOR STATIC LOCAL FOR
   SELECT sql, name FROM #files

OPEN cur

WHILE 1 = 1
BEGIN
   FETCH cur INTO @sql, @name
   IF @@fetch_status <> 0
      BREAK


	INSERT INTO [dbo].[log] ([informacion],[fecha])
	VALUES  ('Carga Archivo ' + @name ,getdate())

    print @sql
	EXEC(@sql)

END

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Inicia ajuste ' ,getdate())

delete  
from dbo.cargueDat
where registro like ';;TOTAL%'

/*delete  
from dbo.cargueDat
where CHARINDEX('"', registro) = 0
*/

/*update dbo.cargueDat
set valor = substring( registro, 
                  CHARINDEX('"', registro), 
                  CHARINDEX('"', registro, CHARINDEX('"', registro) + 1) - CHARINDEX('"', registro) + 1) 
*/

update dbo.cargueDat
set registro = replace (  replace(registro,'$',''), '.', '' )

update dbo.cargueDat
set registro = replace(registro,',','.')


update dbo.cargueDat
set registro = replace(registro,';',',')

/*update dbo.cargueDat
set valorNew = replace (valorNew,'"','')
*/
/*
update dbo.cargueDat
set registro = replace(registro,valor,valorNew)
*/

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Finaliza ajuste ' ,getdate())


INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Crea archivo temporal ' ,getdate())

exec master..xp_cmdshell 'bcp "select registro from gerencial.dbo.CargueDat" queryout D:\Datos\dataTransfer\Temp\polca.dat -T -c -Ugerencial -S192.168.0.7 -Pgerencial'

truncate table dbo.cargueTrf

SET @sql = 'BULK INSERT gerencial.dbo.cargueTrf FROM ''D:\Datos\dataTransfer\Temp\polca.dat'' WITH (' +
             'DATAFILETYPE = ''char'', FIELDTERMINATOR = '','', FIRSTROW=1, ' +
             'ROWTERMINATOR = ''\n'')'

exec(@sql)

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga archivo temporal OK' ,getdate())

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Borra informacion anterior' ,getdate())

delete from dbo.cargueTrf
where valorPagado is null

delete from  dbo.TrfReportada
where  polca = 'S'

--id_secretaria_origen in (select DISTINCT id_secretaria_origen from dbo.cargueTrf ) and


INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga transferencia' ,getdate())

INSERT INTO [dbo].[TrfReportada]
           ([id_secretaria_origen]
           ,[valor_trf]
           ,[vigencia]
           ,[fecha_trf]
           ,[polca]
		   ,[fecha_pago])
SELECT
      substring([id_secretaria_origen],1,8)
      ,convert(money,[valorPagado])
      ,[anoCancelado]
      ,null
      ,'S'
	  ,replace(fechaPago,',','')
  FROM [dbo].cargueTrf

update [dbo].[TrfReportada]
set [vigencia] = '2099'
where [vigencia] is null


INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Cargue Exitoso' ,getdate())

set @codRespuesta = 0
set @mensajeRespuesta = 'Operacion Correcta'


END TRY

BEGIN CATCH

  SELECT @mensajeRespuesta = ERROR_MESSAGE(),@codRespuesta = ERROR_SEVERITY();

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Problemas en cargue ' + @mensajeRespuesta ,getdate())

END CATCH;


END












GO
/****** Object:  StoredProcedure [dbo].[CargarTrfSimit]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CargarTrfSimit]
@codRespuesta int output
,@mensajeRespuesta varchar(4000) output

AS
BEGIN

SET NOCOUNT ON;
BEGIN TRY

DECLARE @sql varchar(8000)
declare @name varchar(500)

truncate table dbo.cargueDat
truncate table dbo.log

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Inicia Cargue Trf Simit' ,getdate())

truncate table dbo.cargueDat

--drop table #files

CREATE TABLE #files (name varchar(200) NULL, sql varchar(7000) NULL)

INSERT #files(name)
   exec master..xp_cmdshell 'dir /b D:\Datos\dataTransfer\SIMIT\*'

delete #files
where name is null;


UPDATE #files
set sql = 'BULK INSERT gerencial.dbo.cargueDat FROM ''D:\Datos\dataTransfer\SIMIT\' + +name  + ''' WITH (' +
             'FIRSTROW=2, MAXERRORS = 0, FORMATFILE = ''D:\Datos\dataTransfer\cargueIni.fmt'' ) '

SELECT sql, name FROM #files

DECLARE cur CURSOR STATIC LOCAL FOR
   SELECT sql, name FROM #files

OPEN cur

WHILE 1 = 1
BEGIN
   FETCH cur INTO @sql, @name
   IF @@fetch_status <> 0
      BREAK


	INSERT INTO [dbo].[log] ([informacion],[fecha])
	VALUES  ('Carga Archivo ' + @name ,getdate())

    print @sql
	EXEC(@sql)

END

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Inicia ajuste ' ,getdate())

delete  
from dbo.cargueDat
where registro like ',,TOTAL%'


/*delete  
from dbo.cargueDat
where CHARINDEX('"', registro) = 0
*/

/*update dbo.cargueDat
set valor = substring( registro, 
                  CHARINDEX('"', registro), 
                  CHARINDEX('"', registro, CHARINDEX('"', registro) + 1) - CHARINDEX('"', registro) + 1) 
*/

update dbo.cargueDat
set registro = replace (  replace(registro,'$',''), '.', '' )

update dbo.cargueDat
set registro = replace(registro,',','.')


update dbo.cargueDat
set registro = replace(registro,';',',')

/*update dbo.cargueDat
set valorNew = replace (valorNew,'"','')
*/
/*
update dbo.cargueDat
set registro = replace(registro,valor,valorNew)
*/

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Finaliza ajuste ' ,getdate())

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Crea archivo temporal ' ,getdate())

exec master..xp_cmdshell 'bcp "select registro from gerencial.dbo.CargueDat" queryout D:\Datos\dataTransfer\Temp\simit.dat -T -c -Ugerencial -S192.168.0.7 -Pgerencial'

truncate table dbo.cargueTrf

SET @sql = 'BULK INSERT gerencial.dbo.cargueTrf FROM ''D:\Datos\dataTransfer\Temp\simit.dat'' WITH (' +
             'DATAFILETYPE = ''char'', FIELDTERMINATOR = '','', FIRSTROW=1, ' +
             'ROWTERMINATOR = ''\n'')'

exec(@sql)

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga archivo temporal OK' ,getdate())

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Borra informacion anterior' ,getdate())

delete from dbo.cargueTrf
where valorPagado is null

delete from  dbo.TrfReportada
where  polca = 'N'

--id_secretaria_origen in (select DISTINCT id_secretaria_origen from dbo.cargueTrf ) and


INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Carga transferencia' ,getdate())

INSERT INTO [dbo].[TrfReportada]
           ([id_secretaria_origen]
           ,[valor_trf]
           ,[vigencia]
           ,[fecha_trf]
           ,[polca]
		   ,[fecha_pago])
SELECT
      substring([id_secretaria_origen],1,8)
      ,convert(money,[valorPagado])
      ,[anoCancelado]
      ,null
      ,'N'
	  ,replace(fechaPago,',','')
  FROM [dbo].cargueTrf

update [dbo].[TrfReportada]
set [vigencia] = '2099'
where [vigencia] is null


INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Cargue Exitoso' ,getdate())

set @codRespuesta = 0
set @mensajeRespuesta = 'Operacion Correcta'


END TRY

BEGIN CATCH

  SELECT @mensajeRespuesta = ERROR_MESSAGE(),@codRespuesta = ERROR_SEVERITY();

INSERT INTO [dbo].[log] ([informacion],[fecha])
VALUES  ('Problemas en cargue ' + @mensajeRespuesta ,getdate())

END CATCH;


END












GO
/****** Object:  StoredProcedure [dbo].[EliminarDeudaUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[EliminarDeudaUpload]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	truncate table dbo.DeudaReportadaUpload

END

GO
/****** Object:  StoredProcedure [dbo].[EliminarRecExtUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarRecExtUpload]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		truncate table dbo.RecaudoExternoUpload

END
GO
/****** Object:  StoredProcedure [dbo].[EliminarRecLocUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarRecLocUpload]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		truncate table dbo.RecaudoLocalUpload

END
GO
/****** Object:  StoredProcedure [dbo].[EliminarRecSimUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarRecSimUpload]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		truncate table dbo.RecaudoSimitUpload

END
GO
/****** Object:  StoredProcedure [dbo].[InsertarDeudaUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertarDeudaUpload]
	@consecutivo_recaudo bigint,
	@id_secretaria_origen char(8),
	@id_tipo_doc char(1) ,
	@identificacion varchar(16),
	@numero_referencia varchar(16),
	@num_com varchar(20),
	@fecha_transaccion datetime ,
	@fecha_contable datetime ,
	@valor_recaudo money ,
	@valor_adicional money ,
	@suma_pagos money ,
	@valor_com money ,
	@fecha_com datetime ,
	@total_recaudo money ,
	@polca char(1) ,
	@id_tipo_recaudo char(1) ,
	@id_estado_recaudo char(1) ,
	@fecha_mov_desde datetime ,
	@fecha_mov_hasta datetime ,
	@x55 money ,
	@xfcm money ,
	@xmun money 


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

if (substring(@id_secretaria_origen,8,1) = ' ' ) 
begin
	set @id_secretaria_origen = '0' + substring(@id_secretaria_origen,1,7)
end

INSERT INTO [gerencial].[dbo].[DeudaReportadaUpload]
           ([consecutivo_recaudo]
           ,[id_secretaria_origen]
           ,[id_tipo_doc]
           ,[identificacion]
           ,[numero_referencia]
           ,[num_com]
           ,[fecha_transaccion]
           ,[fecha_contable]
           ,[valor_recaudo]
           ,[valor_adicional]
           ,[suma_pagos]
           ,[valor_com]
           ,[fecha_com]
           ,[total_recaudo]
           ,[polca]
           ,[id_tipo_recaudo]
           ,[id_estado_recaudo]
           ,[fecha_mov_desde]
           ,[fecha_mov_hasta]
           ,[x55]
           ,[xfcm]
           ,[xmun])
     VALUES
           (
			@consecutivo_recaudo ,
			@id_secretaria_origen ,
			@id_tipo_doc  ,
			@identificacion ,
			@numero_referencia ,
			@num_com ,
			@fecha_transaccion ,
			@fecha_contable  ,
			@valor_recaudo ,
			@valor_adicional  ,
			@suma_pagos  ,
			@valor_com  ,
			@fecha_com  ,
			@total_recaudo  ,
			@polca  ,
			@id_tipo_recaudo  ,
			@id_estado_recaudo  ,
			@fecha_mov_desde  ,
			@fecha_mov_hasta ,
			@x55  ,
			@xfcm  ,
			@xmun  		
		)

END




GO
/****** Object:  StoredProcedure [dbo].[InsertarRecExtUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarRecExtUpload]
           @FechaRecaudo datetime
           ,@CuentaRecaudo varchar(16)
           ,@FechaProceso datetime
           ,@FechaDispersion datetime
           ,@Oficina varchar(50)
           ,@NumeroLiquidacion varchar(16)
           ,@NumeroComparendo varchar(20)
           ,@Identificacion varchar(16)
           ,@Divipo char(8)
           ,@Municipio varchar(250)
           ,@Departamento varchar(250)
           ,@TipoRecaudo char(5)
           ,@IdConcesionarioLiquidador char(2)
           ,@IdConcesionarioZon char(2)
           ,@Validador char(3)
           ,@Fecha2002 char(1)
           ,@VRecaudo money
           ,@VAdicional money
           ,@VBase money
           ,@VSimitBase money
           ,@VCLiquidador money
           ,@VSimit money
           ,@VFCSimit money
           ,@VFCConcesionario money
           ,@VEquilibrio money
           ,@EE18 money
           ,@EE2 money
           ,@VSevial3 money
           ,@VSevial27 money
           ,@VIva27 money
           ,@VFCM18 money
           ,@VIva18 money
           ,@VPolca money
           ,@VTimbre27 money
           ,@VTimbre27_18 money
           ,@VRetencion27 money
           ,@VOperadorCon money
           ,@VFcmCon money
           ,@VAcuerdo money
           ,@VTercero1 money
           ,@VTercero2 money
           ,@VTercero3 money
           ,@VMunicipio money
           ,@VIvaCon money
           ,@VTimbreCon money
           ,@VRetencionContConc money
           ,@VTimbreContCon money
		   ,@FechaComparendo datetime
		   ,@FechaDispOpe datetime


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [dbo].[RecaudoExternoUpload]
           ([FechaRecaudo]
           ,[CuentaRecaudo]
           ,[FechaProceso]
           ,[FechaDispersion]
           ,[Oficina]
           ,[NumeroLiquidacion]
           ,[NumeroComparendo]
           ,[Identificacion]
           ,[Divipo]
           ,[Municipio]
           ,[Departamento]
           ,[TipoRecaudo]
           ,[IdConcesionarioLiquidador]
           ,[IdConcesionarioZon]
           ,[Validador]
           ,[Fecha2002]
           ,[VRecaudo]
           ,[VAdicional]
           ,[VBase]
           ,[VSimitBase]
           ,[VCLiquidador]
           ,[VSimit]
           ,[VFCSimit]
           ,[VFCConcesionario]
           ,[VEquilibrio]
           ,[EE18]
           ,[EE2]
           ,[VSevial3]
           ,[VSevial27]
           ,[VIva27]
           ,[VFCM18]
           ,[VIva18]
           ,[VPolca]
           ,[VTimbre27]
           ,[VTimbre27_18]
           ,[VRetencion27]
           ,[VOperadorCon]
           ,[VFcmCon]
           ,[VAcuerdo]
           ,[VTercero1]
           ,[VTercero2]
           ,[VTercero3]
           ,[VMunicipio]
           ,[VIvaCon]
           ,[VTimbreCon]
           ,[VRetencionContConc]
           ,[VTimbreContCon]
           ,[FechaComparendo]
           ,[FechaDispOpe]
	)
     VALUES
           (
           @FechaRecaudo
           ,@CuentaRecaudo
           ,@FechaProceso
           ,@FechaDispersion
           ,@Oficina
           ,@NumeroLiquidacion
           ,@NumeroComparendo
           ,@Identificacion
           ,@Divipo
           ,@Municipio
           ,@Departamento
           ,@TipoRecaudo
           ,'0' + rtrim(@IdConcesionarioLiquidador)
           ,'0' + rtrim(@IdConcesionarioZon)
           ,@Validador
           ,@Fecha2002
           ,@VRecaudo
           ,@VAdicional
           ,@VBase
           ,@VSimitBase
           ,@VCLiquidador
           ,@VSimit
           ,@VFCSimit
           ,@VFCConcesionario
           ,@VEquilibrio
           ,@EE18
           ,@EE2
           ,@VSevial3
           ,@VSevial27
           ,@VIva27
           ,@VFCM18
           ,@VIva18
           ,@VPolca
           ,@VTimbre27
           ,@VTimbre27_18
           ,@VRetencion27
           ,@VOperadorCon
           ,@VFcmCon
           ,@VAcuerdo
           ,@VTercero1
           ,@VTercero2
           ,@VTercero3
           ,@VMunicipio
           ,@VIvaCon
           ,@VTimbreCon
           ,@VRetencionContConc
           ,@VTimbreContCon
		   ,@FechaComparendo
		   ,@FechaDispOpe
		)

END


GO
/****** Object:  StoredProcedure [dbo].[InsertarRecLocUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[InsertarRecLocUpload]
	@banco varchar(250) 
	,@operador varchar(50) 
	,@cuenta varchar(50) 
	,@fechaCorte datetime 
	,@divipo char(8) 
	,@municipio varchar(250) 
	,@departamento varchar(250) 
	,@origen char(3) 
	,@fechaTrn datetime 
	,@oficinaTrn varchar(250) 
	,@fechaDisp datetime 
	,@vRecaudo money 
	,@simitPm money 
	,@simitPP money 
	,@fcm325 money 
	,@fondoSimit money 
	,@concesionario money 
	,@comision money 
	,@operador325 money 
	,@fondoConcesionario money 
	,@sevial3 money 
	,@sevial27 money 
	,@sevial money 
	,@iva27 money 
	,@retef27 money 
	,@timbre27 money 
	,@netoSevial money 
	,@fcm18 money 
	,@iva18 money 
	,@timbre18 money 
	,@netoFcm money 
	,@polca money 
	,@equilibrioPM money 
	,@equilibrioPP money 
	,@equlibrioCP money 
	,@netoEquilibrio money

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [gerencial].[dbo].[RecaudoLocalUpload]
           ([banco]
           ,[operador]
           ,[cuenta]
           ,[fechaCorte]
           ,[divipo]
           ,[municipio]
           ,[departamento]
           ,[origen]
           ,[fechaTrn]
           ,[oficinaTrn]
           ,[fechaDisp]
           ,[vRecaudo]
           ,[simitPm]
           ,[simitPP]
           ,[fcm325]
           ,[fondoSimit]
           ,[concesionario]
           ,[comision]
           ,[operador325]
           ,[fondoConcesionario]
           ,[sevial3]
           ,[sevial27]
           ,[sevial]
           ,[iva27]
           ,[retef27]
           ,[timbre27]
           ,[netoSevial]
           ,[fcm18]
           ,[iva18]
           ,[timbre18]
           ,[netoFcm]
           ,[polca]
           ,[equilibrioPM]
           ,[equilibrioPP]
           ,[equlibrioCP]
           ,[netoEquilibrio])
     VALUES
           (
	@banco 
	,@operador
	,@cuenta
	,@fechaCorte
	,@divipo
	,@municipio
	,@departamento
	,@origen
	,@fechaTrn
	,@oficinaTrn
	,@fechaDisp
	,@vRecaudo
	,@simitPm
	,@simitPP
	,@fcm325
	,@fondoSimit
	,@concesionario
	,@comision
	,@operador325
	,@fondoConcesionario
	,@sevial3
	,@sevial27
	,@sevial
	,@iva27
	,@retef27
	,@timbre27
	,@netoSevial
	,@fcm18
	,@iva18
	,@timbre18
	,@netoFcm
	,@polca
	,@equilibrioPM
	,@equilibrioPP
	,@equlibrioCP
	,@netoEquilibrio

)


END


GO
/****** Object:  StoredProcedure [dbo].[InsertarRecSimUpload]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[InsertarRecSimUpload]
	@banco varchar(250) 
	,@cuenta varchar(50) 
	,@operador varchar(50) 
	,@fechaCorte datetime 
	,@divipo char(8) 
	,@municipio varchar(250) 
	,@departamento varchar(250) 
	,@origen char(3) 
	,@fechaTrn datetime 
	,@oficinaTrn varchar(250) 
	,@fechaDisp datetime 
	,@vRecaudo money 
	,@concesionario money 
	,@comision money 
	,@operador65 money 
	,@fondoConcesionario money 
	,@fcm25 money 
	,@fondoSimit money 
	,@Equilibrio money

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [gerencial].[dbo].[RecaudoSimitUpload]
           ([banco]
           ,[cuenta]
           ,[operador]
           ,[fechaCorte]
           ,[divipo]
           ,[municipio]
           ,[departamento]
           ,[origen]
           ,[fechaTrn]
           ,[oficinaTrn]
           ,[fechaDisp]
           ,[vRecaudo]
           ,[concesionario]
           ,[comision]
           ,[operador65]
           ,[fondoConcesionario]
           ,[fcm25]
           ,[fondoSimit]
           ,[Equilibrio])
     VALUES
           (
	@banco 
	,@cuenta
	,@operador
	,@fechaCorte
	,@divipo
	,@municipio
	,@departamento
	,@origen
	,@fechaTrn
	,@oficinaTrn
	,@fechaDisp
	,@vRecaudo
	,@concesionario
	,@comision
	,@operador65
	,@fondoConcesionario
	,@fcm25
	,@fondoSimit
	,@Equilibrio

)


END
GO
/****** Object:  StoredProcedure [dbo].[MigraPostgres20100726]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[MigraPostgres20100726]
AS
BEGIN


INSERT INTO [gerencial].[dbo].[RecaudoExterno]
           ([FechaRecaudo]
           ,[CuentaRecaudo]
           ,[FechaProceso]
           ,[Oficina]
           ,[NumeroLiquidacion]
           ,[Identificacion]
           ,[Divipo]
           ,[TipoRecaudo]
           ,[IdConcesionarioLiquidador]
           ,[IdConcesionarioZon]
           ,[VRecaudo]
           ,[TipoRec])    
SELECT convert(datetime,[fec_trn],120)
      ,[cta_rec]
      ,convert(datetime,[fec_apl],120)
      ,[ofi_trn]
      ,[ref1]
      ,[ref2]
      ,[cod_dan]
      ,'SIMIT'
      ,'0' + substring([cod_con],2,1)
      ,[cod_con_due]
      ,[vlr_tot]
      ,'EXTERNO'
FROM [gerencial].[dbo].[public_recaudo]
where cta_rec not in ('086044559','086042058', '086044443', '186001087')
and  fec_apl <= '20091231'

INSERT INTO [gerencial].[dbo].[RecaudoExterno]
           ([FechaRecaudo]
           ,[CuentaRecaudo]
           ,[FechaProceso]
           ,[Oficina]
           ,[NumeroLiquidacion]
           ,[Identificacion]
           ,[Divipo]
           ,[TipoRecaudo]
           ,[IdConcesionarioLiquidador]
           ,[IdConcesionarioZon]
           ,[VRecaudo]
           ,[TipoRec])    
SELECT convert(datetime,[fec_trn],120)
      ,[cta_rec]
      ,convert(datetime,[fec_apl],120)
      ,[ofi_trn]
      ,[ref1]
      ,[ref2]
      ,[cod_dan]
      ,'POLCA'
      ,'0' + substring([cod_con],2,1)
      ,[cod_con_due]
      ,[vlr_tot]
      ,'EXTERNO'
  FROM [gerencial].[dbo].[public_recaudo]
where cta_rec in ('086044443', '186001087')
and  fec_apl <= '20091231'


INSERT INTO [gerencial].[dbo].[RecaudoExterno]
           ([FechaRecaudo]
           ,[CuentaRecaudo]
           ,[FechaProceso]
           ,[Oficina]
           ,[NumeroLiquidacion]
           ,[Identificacion]
           ,[Divipo]
           ,[TipoRecaudo]
           ,[IdConcesionarioLiquidador]
           ,[IdConcesionarioZon]
           ,[VRecaudo]
           ,[TipoRec])    
SELECT convert(datetime,[fec_trn],120)
      ,[cta_rec]
      ,convert(datetime,[fec_apl],120)
      ,[ofi_trn]
      ,[ref1]
      ,[ref2]
      ,[cod_dan]
      ,'POLCA'
      ,[cod_con_due]
      ,[cod_con_due]
      ,[vlr_tot]
      ,'LOCAL'
  FROM [gerencial].[dbo].[public_recaudo]
where cta_rec in ('086044559')
and  fec_apl <= '20091231'

INSERT INTO [gerencial].[dbo].[RecaudoExterno]
           ([FechaRecaudo]
           ,[CuentaRecaudo]
           ,[FechaProceso]
           ,[Oficina]
           ,[NumeroLiquidacion]
           ,[Identificacion]
           ,[Divipo]
           ,[TipoRecaudo]
           ,[IdConcesionarioLiquidador]
           ,[IdConcesionarioZon]
           ,[VRecaudo]
           ,[TipoRec])    
SELECT convert(datetime,[fec_trn],120)
      ,[cta_rec]
      ,convert(datetime,[fec_apl],120)
      ,[ofi_trn]
      ,[ref1]
      ,[ref2]
      ,[cod_dan]
      ,'SIMIT'
      ,[cod_con_due]
      ,[cod_con_due]
      ,[vlr_tot]
      ,'LOCAL'
  FROM [gerencial].[dbo].[public_recaudo]
where cta_rec in ('086042058')
and  fec_apl <= '20091231'

end

     
GO
/****** Object:  StoredProcedure [dbo].[sp_rpt1_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rpt1_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rpt1; insert into rpt1 select gerencial.dbo.ObtenerDptal(r.Divipo) as IdMunicipio, gerencial.dbo.ObtenerNomDptal(gerencial.dbo.ObtenerDptal(r.Divipo)) as Nombre ,  sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r '
Set @Sentencia = 'truncate table rpt1; insert into rpt1 select r.Divipo as IdMunicipio, gerencial.dbo.ObtenerNomMunicipio(r.Divipo) as Nombre ,  sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Group by r.Divipo ' 
set @Sentencia = @Sentencia + ' Order by sum(VRecaudo) Desc' 

print @sentencia
execute (@sentencia)

if (@Top10 = 0)
select * from rpt1
else
begin
	select top 9 * from rpt1
    union
    select '00000000', 'Otros', 
	sum(valor) as valor, 
	sum(Nroreg) as NroReg 
	from Rpt1
    where IdMunicipio not in 
        (select top 9 Idmunicipio from rpt1) 
    order by valor desc 
end

END




GO
/****** Object:  StoredProcedure [dbo].[sp_rpt10_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rpt10_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@AAAAMM1 char(6),
	@AAAAMM2 char(6),
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare @Sentencia varchar(2000)
Declare @fechaAnt datetime
--Declare @AAAAMM2 char(6)
    
Set @Sentencia = 'truncate table rpt10; insert into rpt10 (ValorMesAct, NroMesAct, MultaMesAct, MultaMaxima)  select sum(VRecaudo) as ValorMesAct, count(*) as NroMesAct, avg(VRecaudo) as MultaMesAct, max(VRecaudo) MultaMaxima '
set @Sentencia = @Sentencia + ' FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end
set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + ''''  

execute (@sentencia)                                                         

--set @fechaAnt = convert(datetime, substring(@AAAAMM1,1,4) + '-' + substring(@AAAAMM1,5,2) + '-01',120)
--set @fechaAnt = @fechaAnt - 1
--set @AAAAMM2 = convert(char(6),@fechaAnt,112)

Set @Sentencia = 'update a set a.ValorMesAnt = b.valor1, a.NroMesAnt = b.valor2, a.MultaMesAnt = b.valor3 '
Set @Sentencia = @sentencia + ' from dbo.rpt10 a, ( select sum(VRecaudo) as valor1, count(*) as valor2, avg(VRecaudo) as valor3 from dbo.RecaudoExterno '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''
set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM2 + ''' ) as b '  
execute (@sentencia)                                                         

set @sentencia = 'update c set c.RecaudoMesAct = b.promValorDiario, c.NroRcaudosMesAct = b.promNroDiario '
Set @Sentencia = @sentencia + ' from dbo.rpt10 c, ( select avg(a.valorDiario) as promValorDiario, avg(a.nroDiario) as promNroDiario '
Set @Sentencia = @sentencia + ' from ( select sum(VRecaudo) aS valorDiario, count(*) as nroDiario from dbo.RecaudoExterno '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''
set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + ''' '
set @Sentencia = @Sentencia + ' group by convert(char(8),FechaProceso,112) ) a ) b '
execute (@sentencia)                                                         
  
set @sentencia = 'update c set c.RecaudoMesAnt = b.promValorDiario, c.NroRecaudosMesAnt = b.promNroDiario '
Set @Sentencia = @sentencia + ' from dbo.rpt10 c, ( select avg(a.valorDiario) as promValorDiario, avg(a.nroDiario) as promNroDiario '
Set @Sentencia = @sentencia + ' from ( select sum(VRecaudo) aS valorDiario, count(*) as nroDiario from dbo.RecaudoExterno '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''
set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM2 + ''' '
set @Sentencia = @Sentencia + ' group by convert(char(8),FechaProceso,112) ) a ) b '
execute (@sentencia)                                                         
                              

select * from rpt10

END



























GO
/****** Object:  StoredProcedure [dbo].[sp_rpt2_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_rpt2_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)

Declare @Sentencia varchar(2500)

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	Set @Sentencia = 'truncate table rpt2; insert into rpt2 select  sum(VRecaudo) as Valor, count(*) as NroReg, sum(VCLiquidador) as VCLiquidador, sum(VFCSimit+ VFCConcesionario) as VFondo, sum(VSevial3) as VSevial3, sum(VSevial27) as VSevial27, sum(VIva27) as VIva27, sum(VTimbre27) as VTimbre27, sum(VRetencion27) as VRetencion27, sum(VSevial27+VTimbre27+VRetencion27-VIva27) as VSevial27Base, '
end
else
begin 
	Set @Sentencia = 'truncate table rpt2; insert into rpt2 select  sum(VRecaudo) as Valor, count(*) as NroReg, sum(case convert(int , rtrim(IdConcesionarioLiquidador)) when 3  then VCLiquidador else 0 end  ) as VCLiquidador, sum(case convert(int , rtrim(IdConcesionarioLiquidador)) when 3  then VFCSimit+ VFCConcesionario else 0 end ) as VFondo, sum(VSevial3) as VSevial3, sum(VSevial27) as VSevial27, sum(VIva27) as VIva27, sum(VTimbre27) as VTimbre27, sum(VRetencion27) as VRetencion27, sum(VSevial27+VTimbre27+VRetencion27-VIva27) as VSevial27Base, '
end

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' convert(char(10),FechaProceso,120) as Fecha '

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' convert(char(7),FechaProceso,120) as Fecha '

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' convert(char(4),FechaProceso,112) as Fecha '

set @Sentencia = @Sentencia + ' FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and convert(int , rtrim(IdConcesionarioLiquidador)) = convert(int , rtrim(''' + @IdConcesionario + '''))' 
end

if ( @Periodo = 1 )
begin
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 
    set @Sentencia = @Sentencia + ' Group by convert(char(10),FechaProceso,120) Order by convert(char(10),FechaProceso,120) ' 
end

if ( @Periodo = 2 )
begin
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 
    set @Sentencia = @Sentencia + ' Group by convert(char(7),FechaProceso,120) Order by convert(char(7),FechaProceso,120) ' 
end

if ( @Periodo = 3 )
begin
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 
    set @Sentencia = @Sentencia + ' Group by convert(char(4),FechaProceso,112) Order by convert(char(4),FechaProceso,112) ' 
end

print @sentencia

execute (@sentencia)


-- totales por banco
if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	Set @Sentencia = 'truncate table rpt2_banco; insert into rpt2_banco select  sum(VRecaudo) as Valor, count(*) as NroReg, r.CuentaRecaudo ,''00'' as idbanco, ''BANCO'' as banco '
end
else
begin 
	Set @Sentencia = 'truncate table rpt2_banco; insert into rpt2_banco select  sum(VRecaudo) as Valor, count(*) as NroReg, r.CuentaRecaudo ,''00'' as idbanco, ''BANCO'' as banco '
end

set @Sentencia = @Sentencia + ' FROM dbo.RecaudoExterno r'
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

if ( @Periodo = 1 )
begin
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 
    set @Sentencia = @Sentencia + ' Group by r.CuentaRecaudo ' 
end

if ( @Periodo = 2 )
begin
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 
    set @Sentencia = @Sentencia + ' Group by r.CuentaRecaudo' 
end

if ( @Periodo = 3 )
begin
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 
    set @Sentencia = @Sentencia + ' Group by r.CuentaRecaudo' 
end

print @sentencia

execute (@sentencia)

/*update a
set a.idbanco = b.idbanco
from dbo.rpt2_banco a, dbo.CuentaRecaudo b
where a.numeroCuenta = b.numeroCuenta
*/

update a
set a.idbanco = '01'
from dbo.rpt2_banco a
where substring(a.numeroCuenta,1,3) = '205'

update a
set a.idbanco = '02'
from dbo.rpt2_banco a
where substring(a.numeroCuenta,1,3) = '220'

update a
set a.idbanco = '40'
from dbo.rpt2_banco a
where substring(a.numeroCuenta,1,3) = '408'

update a
set a.idbanco = '52'
from dbo.rpt2_banco a
where substring(a.numeroCuenta,1,3) = '086' OR substring(a.numeroCuenta,1,3) = '059'

update a
set a.idbanco = '50'
from dbo.rpt2_banco a
where substring(a.numeroCuenta,1,3) = '186'

update a
set a.banco = b.nombre
from dbo.rpt2_banco a, dbo.Banco b
where a.idbanco = b.idbanco


select * from rpt2
select * from rpt2_banco


END







GO
/****** Object:  StoredProcedure [dbo].[sp_rpt3_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rpt3_detalle] 
	-- Add the parameters for the stored procedure here
	@P_TipoRecaudo varchar(10) , 
	@P_TipoComparendo char(5) , 
	@P_IdConcesionario char(2) ,
	@P_Periodo int ,
    @P_AAAAMM1 char(6),
    @P_AAAAMM2 char(6),
    @P_Top10 int,
    @P_IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_rpt2_detalle]
		@TipoRecaudo = @P_TipoRecaudo,
		@TipoComparendo = @P_TipoComparendo,
		@IdConcesionario = @P_IdConcesionario,
		@Periodo = @P_Periodo,
		@AAAAMM1 = @P_AAAAMM1,
		@AAAAMM2 = @P_AAAAMM2,
		@Top10 = @P_Top10,
		@IdBanco = @P_IdBanco

END






GO
/****** Object:  StoredProcedure [dbo].[sp_rpt4_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rpt4_detalle] 
	-- Add the parameters for the stored procedure here
	@P_TipoRecaudo varchar(10) , 
	@P_TipoComparendo char(5) , 
	@P_IdConcesionario char(2) ,
	@P_Periodo int ,
    @P_AAAAMM1 char(6),
    @P_AAAAMM2 char(6),
    @P_Top10 int,
    @P_IdBanco char(2)
 
AS
BEGIN
DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_rpt1_detalle]
		@TipoRecaudo = @P_TipoRecaudo ,
		@TipoComparendo = @P_TipoComparendo,
		@IdConcesionario = @P_IdConcesionario,
		@Periodo = @P_Periodo,
		@AAAAMM1 = @P_AAAAMM1,
		@AAAAMM2 = @P_AAAAMM2,
		@Top10 = @P_Top10,
		@IdBanco = @P_IdBanco
END









GO
/****** Object:  StoredProcedure [dbo].[sp_rpt5_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rpt5_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rpt5; INSERT into rpt5  select Oficina ,  sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end


if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Group by Oficina ' 
set @Sentencia = @Sentencia + ' Order by sum(VRecaudo) Desc' 

print @sentencia
execute (@sentencia)

if (@Top10 = 0)
select * from rpt5
else
begin
	select top 9 * from rpt5
    union
    select 'Otros' AS Oficina, 
	sum(valor) as valor, 
	sum(Nroreg) as NroReg 
	from Rpt5
    where Oficina not in 
        (select top 9 Oficina from rpt5) 
    order by valor desc 
end

END












GO
/****** Object:  StoredProcedure [dbo].[sp_rpt6_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rpt6_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rpt6; INSERT into rpt6  select ZonaConcesionario ,  sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r, dbo.Municipio m '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

set @Sentencia = @Sentencia + ' and m.IdMunicipio =  r.Divipo '  


if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Group by ZonaConcesionario ' 
set @Sentencia = @Sentencia + ' Order by sum(VRecaudo) Desc' 

print @sentencia
execute (@sentencia)

select * from rpt6

END















GO
/****** Object:  StoredProcedure [dbo].[sp_rpt9_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rpt9_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rpt9; INSERT into rpt9  select  gerencial.dbo.ObtenerNomConcesionario(IdConcesionarioLiquidador) as Concesionario,  sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Group by gerencial.dbo.ObtenerNomConcesionario(IdConcesionarioLiquidador) ' 
set @Sentencia = @Sentencia + ' Order by sum(VRecaudo) Desc' 

print @sentencia
execute (@sentencia)

SELECT * FROM rpt9

END













GO
/****** Object:  StoredProcedure [dbo].[sp_rptA_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptA_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'TRUNCATE TABLE rptA; insert into rptA select  gerencial.dbo.ObtenerConcZonal(Divipo) as Concesionario, gerencial.dbo.ObtenerZonaMun(Divipo) as Zona,  sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Group by gerencial.dbo.ObtenerConcZonal(Divipo),gerencial.dbo.ObtenerZonaMun(Divipo)  ' 
set @Sentencia = @Sentencia + ' Order by gerencial.dbo.ObtenerConcZonal(Divipo),gerencial.dbo.ObtenerZonaMun(Divipo)' 

print @sentencia
execute (@sentencia)

SELECT * FROM rptA

END













GO
/****** Object:  StoredProcedure [dbo].[sp_rptC_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptC_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rptC; insert into rptC select gerencial.dbo.ObtenerConcZonal(r.Divipo) as Concesionario, gerencial.dbo.ObtenerDptal(r.Divipo) as IdMunicipio, gerencial.dbo.ObtenerNomDptal(gerencial.dbo.ObtenerDptal(r.Divipo)) as Nombre ,  sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Group by gerencial.dbo.ObtenerConcZonal(r.Divipo), gerencial.dbo.ObtenerDptal(r.Divipo) ' 
set @Sentencia = @Sentencia + ' Order by gerencial.dbo.ObtenerConcZonal(r.Divipo), gerencial.dbo.ObtenerDptal(r.Divipo)' 

print @sentencia
execute (@sentencia)

select * from rptC

END












GO
/****** Object:  StoredProcedure [dbo].[sp_rptD_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptD_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2),
    @Divipo varchar(1000)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rptD; insert into rptD select FechaProceso, FechaRecaudo, VRecaudo, NumeroLiquidacion, Identificacion,Divipo, gerencial.dbo.ObtenerNomMunicipio(Divipo) as Municipio,TipoRecaudo, (VMunicipio + VTercero1 + VTercero2 + VTercero3) as VMunicipio, NumeroComparendo, FechaComparendo, FechaDispersion  FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end


if (@IdBanco = '01')
begin
	set @Sentencia = @Sentencia + ' and substring(r.CuentaRecaudo,1,3) = ''205'' ' 
end

if (@IdBanco = '02')
begin
	set @Sentencia = @Sentencia + ' and substring(r.CuentaRecaudo,1,3) = ''220'' ' 
end

if (@IdBanco = '40')
begin
	set @Sentencia = @Sentencia + ' and substring(r.CuentaRecaudo,1,3) = ''408'' ' 
end

if (@IdBanco = '52')
begin
	set @Sentencia = @Sentencia + ' and ( substring(r.CuentaRecaudo,1,3) = ''086'' or substring(r.CuentaRecaudo,1,3) = ''059'' ) ' 
end

if (@IdBanco = '50')
begin
	set @Sentencia = @Sentencia + ' and substring(r.CuentaRecaudo,1,3) = ''186'' ' 
end

if (CHARINDEX ('99999999', @Divipo) = 0 )
begin
	set @Sentencia = @Sentencia + ' and divipo in ' + @Divipo 
end;

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Order by FechaProceso,Divipo ' 

print @sentencia
execute (@sentencia)

select * from rptD

END















GO
/****** Object:  StoredProcedure [dbo].[sp_rptD_dptal]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptD_dptal] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2),
    @Divipo varchar(1000)
-- Divipo llega ('25000000') cundinamarca
-- Divipo llega ('15000000') itboy

 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rptD; insert into rptD select FechaProceso, FechaRecaudo, VRecaudo, NumeroLiquidacion, Identificacion,Divipo, gerencial.dbo.ObtenerNomMunicipio(Divipo) as Municipio,TipoRecaudo, (VMunicipio + VTercero1 + VTercero2 + VTercero3) as VMunicipio, NumeroComparendo, FechaComparendo, FechaDispersion FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''
set @Sentencia = @Sentencia + ' and gerencial.dbo.ObtenerDptal(divipo) in ' + @Divipo 

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Order by FechaProceso,Divipo ' 

print @sentencia
execute (@sentencia)

select * from rptD

END













GO
/****** Object:  StoredProcedure [dbo].[sp_rptD_totalizado]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptD_totalizado]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select 
max(municipio) as nomMunicipio, 
sum((case when tipoRecaudo = 'SIMIT' then 0 else Vrecaudo end )) as VPolca,
sum((case when tipoRecaudo = 'POLCA' then 0 else Vrecaudo end )) as VUrbano,
sum(Vrecaudo) as vRec,
sum(VMunicipio) as Vmun,
count(*) numRec
from dbo.rptD
group by municipio 
order by municipio

END
GO
/****** Object:  StoredProcedure [dbo].[sp_rptE_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptE_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @IdBanco char(2)
    
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rptE; insert into rptE select gerencial.dbo.ObtenerPeriodo(r.FechaProceso,' + convert(char(1),@periodo) + ') as periodo, sum( VRecaudo) as Valor, count(*) as NroReg FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end


if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 
set @Sentencia = @Sentencia + ' Group by gerencial.dbo.ObtenerPeriodo(r.FechaProceso,' + convert(char(1),@periodo) + ')'

print @sentencia
execute (@sentencia)

select * from rptE
order by Periodo

END















GO
/****** Object:  StoredProcedure [dbo].[sp_rptF_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptF_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoRecaudo varchar(10) , 
	@TipoComparendo char(5) , 
	@IdConcesionario char(2) ,
	@Periodo int ,
    @AAAAMM1 char(6),
    @AAAAMM2 char(6),
    @Top10 int,
    @IdBanco char(2),
    @Departamento varchar(1000)
-- Departamento llega ('01',...) 

 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

Declare  @AAAA1 char(4)
Declare  @AAAA2 char(4)

Set @AAAA1 = substring(@AAAAMM1,1,4)
Set @AAAA2 = substring(@AAAAMM2,1,4)


Declare @Sentencia varchar(2000)


Set @Sentencia = 'truncate table rptD; insert into rptD select FechaProceso, FechaRecaudo, VRecaudo, NumeroLiquidacion, Identificacion,Divipo, gerencial.dbo.ObtenerNomMunicipio(Divipo) as Municipio,TipoRecaudo, (VMunicipio + VTercero1 + VTercero2 + VTercero3) as VMunicipio, NumeroComparendo, FechaComparendo, FechaDispersion FROM dbo.RecaudoExterno r '
set @Sentencia = @Sentencia + '  Where TipoRec = ''' + @TipoRecaudo + ''''
set @Sentencia = @Sentencia + ' and substring(divipo,1,2) in ' + @Departamento 

if (@TipoComparendo <> 'TODOS') 
begin 
	set @Sentencia = @Sentencia + '  and TipoRecaudo = ''' + @TipoComparendo + ''''
end

if (@TipoComparendo = 'SIMIT' AND @IdConcesionario <> '99')
begin
	set @Sentencia = @Sentencia + ' and IdConcesionarioLiquidador = ''' + @IdConcesionario + '''' 
end

if ( @Periodo = 1 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) = ''' + @AAAAMM1 + '''' 

if ( @Periodo = 2 )
	set @Sentencia = @Sentencia + ' and convert(char(6),FechaProceso,112) >= ''' + @AAAAMM1 + ''' and convert(char(6),FechaProceso,112) <= ''' + @AAAAMM2 + '''' 

if ( @Periodo = 3 )
	set @Sentencia = @Sentencia + ' and convert(char(4),FechaProceso,112) >= ''' + @AAAA1 + ''' and convert(char(4),FechaProceso,112) <= ''' + @AAAA2 + '''' 

set @Sentencia = @Sentencia + ' Order by FechaProceso,Divipo ' 

print @sentencia
execute (@sentencia)

select * from rptD

END













GO
/****** Object:  StoredProcedure [dbo].[sp_rptH_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
















-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptH_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoComparendo char(5) , 
    @Divipo varchar(1000)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @polca char(1)
Declare @Sentencia varchar(2000)


set @polca = case when @TipoComparendo = 'POLCA' then 'S' else 'N' end

set @Sentencia = ' truncate table rptH; insert into rptH
SELECT [id_secretaria_origen]
      ,[identificacion]
      ,[num_com]
      ,[fecha_com]
      ,[total_recaudo]
      ,[polca]
      ,([x55] + [xfcm] ) as [x55]
      ,m.nombre
      ,fecha_contable as fecha_transaccion
      ,([x55] ) as [x45]
      ,([xfcm] ) as [x10]

FROM [gerencial].[dbo].[DeudaReportada] d, dbo.Municipio M
'

if (@TipoComparendo = 'SIMIT' )
begin
set @Sentencia = ' truncate table rptH; insert into rptH
SELECT [id_secretaria_origen]
      ,[identificacion]
      ,[num_com]
      ,[fecha_com]
      ,[total_recaudo]
      ,[polca]
      ,[xfcm] as x55
      ,m.nombre
      ,fecha_contable as fecha_transaccion
      ,0 as [x45]
      ,0 as [x10]

FROM [gerencial].[dbo].[DeudaReportada] d, dbo.Municipio M
'

end

if (@TipoComparendo <> 'TODOS' )
begin

set @Sentencia = @Sentencia + ' where polca = ''' + @polca + ''' and'
end

if (@TipoComparendo = 'TODOS' )
begin
set @Sentencia = @Sentencia + ' where '
end

set @Sentencia = @Sentencia + ' [id_secretaria_origen] in ' + @Divipo 
set @Sentencia = @Sentencia + 'and d.id_secretaria_origen = m.IdMunicipio
							  order by [fecha_contable]'

print @sentencia

execute (@sentencia)

select * from rptH

end

















GO
/****** Object:  StoredProcedure [dbo].[sp_rptH_total]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
















-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptH_total] 
	-- Add the parameters for the stored procedure here
	@TipoComparendo char(5) , 
    @Divipo varchar(1000)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @polca char(1)
Declare @Sentencia varchar(2000)
declare @ano int
declare @anoAct int 
declare @munic varchar(250)

-- calcula recaudo reportado por fecha contable

set @polca = case when @TipoComparendo = 'POLCA' then 'S' else 'N' end

set @Sentencia = ' truncate table rptH_total; insert into rptH_total
SELECT 
      convert(char(4),[fecha_contable],112) as fecha
      ,sum([total_recaudo]) as total_recaudo
      ,sum([x55]+[xfcm]) as x55
      ,0 as VlrTransferido
      ,0 as VlrDeuda
      , null as nombre
      , min([id_secretaria_origen]) as id_secretaria_origen
FROM [gerencial].[dbo].[DeudaReportada] d '

if (@TipoComparendo = 'SIMIT' )
begin
set @Sentencia = ' truncate table rptH_total; insert into rptH_total
SELECT 
      convert(char(4),[fecha_contable],112) as fecha
      ,sum([total_recaudo]) as total_recaudo
      ,sum([xfcm]) as x55
      ,0 as VlrTransferido
      ,0 as VlrDeuda
      , null as nombre
      ,min([id_secretaria_origen]) as id_secretaria_origen
FROM [gerencial].[dbo].[DeudaReportada] d '

end

if (@TipoComparendo <> 'TODOS' )
begin

set @Sentencia = @Sentencia + ' where polca = ''' + @polca + ''' and'
end

if (@TipoComparendo = 'TODOS' )
begin
set @Sentencia = @Sentencia + ' where '
end

set @Sentencia = @Sentencia + ' [id_secretaria_origen] in ' + @Divipo 
set @Sentencia = @Sentencia + ' group by convert(char(4),[fecha_contable],112)
							  order by convert(char(4),[fecha_contable],112)'

print @sentencia
execute (@sentencia)

------------------------------------
-- calcula transferencias por vigencia

set @Sentencia = ' truncate table rptH_vig; insert into rptH_vig
SELECT min([id_secretaria_origen]) as id_secretaria_origen,
      vigencia
      ,sum([valor_trf]) as trf
FROM [gerencial].[dbo].[TrfReportada] t '

if (@TipoComparendo <> 'TODOS' )
begin

set @Sentencia = @Sentencia + ' where polca = ''' + @polca + ''' and'
end

if (@TipoComparendo = 'TODOS' )
begin
set @Sentencia = @Sentencia + ' where '
end

set @Sentencia = @Sentencia + ' [id_secretaria_origen] in ' + @Divipo 
set @Sentencia = @Sentencia + ' group by vigencia
							    order by vigencia '

print @sentencia
execute (@sentencia)



/*
set @anoAct = convert(int,convert(char(4),getDate(),112))
set @ano = 2002


while ( @ano <= @anoAct )
begin
	print @ano

    if not exists ( select * from [rptH_Total] where fecha = convert(char(4), @ano) )
    begin
  	INSERT INTO [gerencial].[dbo].[rptH_Total]
           ([fecha]
           ,[total_recuado]
           ,[x55]
           ,[VlrTransferido]
           ,[VlrDeuda]
           , '')
     VALUES
           (convert(char(4), @ano)
           ,0
           ,0
           ,0
           ,0
           ,'')
    end
	set @ano = @ano + 1
end



set @Sentencia = ' update a set a.nombre = m.nombre from rptH_total a, dbo.Municipio M where m.IdMunicipio in ' + @Divipo
print @sentencia
execute (@sentencia)

 
set @Sentencia = 'update a set a.VlrTransferido = b.VlrTransferido from rptH_total a, ( '
set @Sentencia = @Sentencia + '	select convert(char(4),[FechaProceso],112) as fecha , sum(VRecaudo) as VlrTransferido  from dbo.Recaudoexterno '

if (@TipoComparendo = 'TODOS' )
begin
set @Sentencia = @Sentencia + '	where TipoRec = ''LOCAL'' and Divipo in ' + @Divipo
end
else begin
set @Sentencia = @Sentencia + '	where TipoRec = ''LOCAL'' and TipoRecaudo = ''' + @TipoComparendo + ''' and Divipo in ' + @Divipo
end

set @Sentencia = @Sentencia + '	group by convert(char(4),[FechaProceso],112) ) b '
set @Sentencia = @Sentencia + ' where a.fecha = b.fecha '

print @sentencia
execute (@sentencia)

update rptH_total
set VlrDeuda = x55 - VlrTransferido
*/

select * from rptH_total
where total_recuado > 0 or x55 > 0 or VlrTransferido > 0
order by fecha, idMunicipio

select * from rptH_vig
where vlrTrf > 0 
order by vigencia, id_secretaria_origen


end




















GO
/****** Object:  StoredProcedure [dbo].[sp_rptJ_detalle]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
















-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptJ_detalle] 
	-- Add the parameters for the stored procedure here
	@TipoComparendo char(5) , 
    @Divipo varchar(1000)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @polca char(1)
Declare @Sentencia varchar(2000)


set @polca = case when @TipoComparendo = 'POLCA' then 'S' else 'N' end

set @Sentencia = ' truncate table rptJ; insert into rptJ
SELECT [id_secretaria_origen]
      ,[identificacion]
      ,[num_com]
      ,[fecha_com]
      ,[total_recaudo]
      ,[polca]
      ,[x55]
      ,m.nombre
      ,fecha_contable as fecha_transaccion
FROM [gerencial].[dbo].[DeudaReportada] d, dbo.Municipio M
'

if (@TipoComparendo = 'SIMIT' )
begin
set @Sentencia = ' truncate table rptJ; insert into rptJ
SELECT [id_secretaria_origen]
      ,[identificacion]
      ,[num_com]
      ,[fecha_com]
      ,[total_recaudo]
      ,[polca]
      ,[xfcm] as x55
      ,m.nombre
      ,fecha_contable as fecha_transaccion
FROM [gerencial].[dbo].[DeudaReportada] d, dbo.Municipio M
'

end

if (@TipoComparendo <> 'TODOS' )
begin

set @Sentencia = @Sentencia + ' where polca = ''' + @polca + ''' and'
end

if (@TipoComparendo = 'TODOS' )
begin
set @Sentencia = @Sentencia + ' where '
end

set @Sentencia = @Sentencia + ' [id_secretaria_origen] in ' + @Divipo 
set @Sentencia = @Sentencia + 'and d.id_secretaria_origen = m.IdMunicipio
							  order by [fecha_contable]'

print @sentencia

execute (@sentencia)

select * from rptJ

end
















GO
/****** Object:  StoredProcedure [dbo].[sp_rptJ_total]    Script Date: 07/03/2018 18:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Hugo Cendales
-- Create date: 
-- Description:	Generar Reporte 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_rptJ_total] 
	-- Add the parameters for the stored procedure here
	@TipoComparendo char(5) , 
    @Divipo varchar(1000)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @polca char(1)
Declare @Sentencia varchar(2000)
declare @ano int
declare @anoAct int 
declare @munic varchar(250)

-- calcula recaudo reportado por fecha contable

set @polca = case when @TipoComparendo = 'POLCA' then 'S' else 'N' end

set @Sentencia = ' truncate table rptJ_total; insert into rptJ_total
SELECT 
      convert(char(4),[fecha_contable],112) as fecha
      ,sum([total_recaudo]) as total_recaudo
      ,sum([x55]) as x55
      ,0 as VlrTransferido
      ,0 as VlrDeuda
      , null as nombre
      , min([id_secretaria_origen]) as id_secretaria_origen
FROM [gerencial].[dbo].[DeudaReportada] d '

if (@TipoComparendo = 'SIMIT' )
begin
set @Sentencia = ' truncate table rptJ_total; insert into rptJ_total
SELECT 
      convert(char(4),[fecha_contable],112) as fecha
      ,sum([total_recaudo]) as total_recaudo
      ,sum([xfcm]) as x55
      ,0 as VlrTransferido
      ,0 as VlrDeuda
      , null as nombre
      ,min([id_secretaria_origen]) as id_secretaria_origen
FROM [gerencial].[dbo].[DeudaReportada] d '

end

if (@TipoComparendo <> 'TODOS' )
begin

set @Sentencia = @Sentencia + ' where polca = ''' + @polca + ''' and'
end

if (@TipoComparendo = 'TODOS' )
begin
set @Sentencia = @Sentencia + ' where '
end

set @Sentencia = @Sentencia + ' [id_secretaria_origen] in ' + @Divipo 
set @Sentencia = @Sentencia + ' group by convert(char(4),[fecha_contable],112)
							  order by convert(char(4),[fecha_contable],112)'

print @sentencia
execute (@sentencia)

------------------------------------
-- calcula transferencias por vigencia

set @Sentencia = ' truncate table rptH_vig; insert into rptH_vig
SELECT min([id_secretaria_origen]) as id_secretaria_origen,
      vigencia
      ,sum([valor_trf]) as trf
FROM [gerencial].[dbo].[TrfReportada] t '

if (@TipoComparendo <> 'TODOS' )
begin

set @Sentencia = @Sentencia + ' where polca = ''' + @polca + ''' and'
end

if (@TipoComparendo = 'TODOS' )
begin
set @Sentencia = @Sentencia + ' where '
end

set @Sentencia = @Sentencia + ' [id_secretaria_origen] in ' + @Divipo 
set @Sentencia = @Sentencia + ' group by vigencia
							    order by vigencia '

print @sentencia
execute (@sentencia)




select * from rptJ_total
where total_recuado > 0 or x55 > 0 or VlrTransferido > 0
order by fecha, idMunicipio

select * from rptH_vig
where vlrTrf > 0 
order by vigencia, id_secretaria_origen


end




















GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'cta_rec' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'cta_rec' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cta_rec'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'fec_apl' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'fec_apl' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_apl'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'fec_trn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'fec_trn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'fec_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ofi_trn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'250' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ofi_trn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ofi_trn'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'vlr_tot' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'vlr_tot' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_tot'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'cod_dan' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'cod_dan' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_dan'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'cod_con' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'cod_con' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'cod_con_due' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'cod_con_due' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'cod_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'zon_con_due' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'zon_con_due' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'zon_con_due'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'vlr_bas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'vlr_bas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_bas'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ref1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'11' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'16' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ref1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ref2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'16' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ref2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'3082' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'vlr_mun' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'vlr_mun' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo', @level2type=N'COLUMN',@level2name=N'vlr_mun'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'27/07/2010 03:40:28 p.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'27/07/2010 03:46:07 p.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'public_recaudo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'1141441' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'public_recaudo'
GO
