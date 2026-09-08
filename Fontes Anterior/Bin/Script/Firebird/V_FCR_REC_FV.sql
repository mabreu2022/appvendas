--select * from V_FCR_REC_FV;

drop view V_FCR_REC_FV;

create or alter view V_FCR_REC_FV as
select
  a.CODEMP
, a.CODCLIENTE
, a.NUMFAT
, a.NUMPARC
, b.NOME as NOMCLIENTE
, a.SITUACAO
, a.DATAEMISSAO
, a.DATAVENCTO
, a.CODPORT
, a.CODMOEDA
, a.VLFATURA
, a.TPDOC
, a.NUMDOC
, a.USUARIO
, a.CODVEND
, a.NUMNOTA
, a.NUMMOV
, a.DATAMOV
from FCR_FAT a
inner join CAD_CLIENTE b on (b.CODCLIENTE = a.CODCLIENTE)
where SITUACAO = 'A' 
and coalesce(SELECAO,'F') <> 'T'
;