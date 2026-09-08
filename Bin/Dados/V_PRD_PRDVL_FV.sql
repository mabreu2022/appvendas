CREATE OR ALTER VIEW V_PRD_PRDVL_FV(
    CODPROD,
    DESCRICAO,
    DESCCOMPLETA,
    UNIDMEDIDA,
    CODBAR,
    VLVENDA,
    VLVENDAMIN,
    VLVENDAATACADO,
    VLCTOULTCOMP,
    QTFISICA)
AS
Select
e.CodProd,
e.Descricao,
e.DescCompleta,
e.UnidMedida,
e.CodBar,
CASE
    WHEN v.moedacompra <> b.codmoeda THEN
      CASE
        WHEN C.tipocalc = 'M' and b.codmoeda <> 3 THEN
            COALESCE(CAST((v.VlVenda*c.valor) as numeric(14,4)),0)
        WHEN C.tipocalc = 'D' and b.codmoeda <> 3 THEN
            COALESCE(CAST((v.VlVenda/c.valor) as numeric(14,4)),0)
        WHEN C.tipocalc = 'M' and b.codmoeda = 3 THEN
            COALESCE(CAST((v.VlVenda*c.valor) as numeric(14,0)),0)
        WHEN C.tipocalc = 'D' and b.codmoeda = 3 THEN
            COALESCE(CAST((v.VlVenda/c.valor) as numeric(14,0)),0)
      END
    ELSE
        COALESCE(CAST(v.VlVenda as numeric(14,3)),0)
END as VlVenda,
CASE
    WHEN v.moedacompra <> b.codmoeda THEN
      CASE
        WHEN C.tipocalc = 'M' and b.codmoeda <> 3 THEN
            COALESCE(CAST((v.VlVendaMin*c.valor) as numeric(14,4)),0)
        WHEN C.tipocalc = 'D' and b.codmoeda <> 3 THEN
            COALESCE(CAST((v.VlVendaMin/c.valor) as numeric(14,4)),0)
        WHEN C.tipocalc = 'M' and b.codmoeda = 3 THEN
            COALESCE(CAST((v.VlVendaMin*c.valor) as numeric(14,0)),0)
        WHEN C.tipocalc = 'D' and b.codmoeda = 3 THEN
            COALESCE(CAST((v.VlVendaMin/c.valor) as numeric(14,0)),0)
      END
    ELSE
       COALESCE(CAST(v.VlVendaMin as numeric(14,3)),0)
END as VlVendaMin,
CASE
    WHEN v.moedacompra <> b.codmoeda THEN
      CASE
        WHEN C.tipocalc = 'M' and b.codmoeda <> 3 THEN
            COALESCE(CAST((v.VlVendaAtacado*c.valor) as numeric(14,4)),0)
        WHEN C.tipocalc = 'D' and b.codmoeda <> 3 THEN
            COALESCE(CAST((v.VlVendaAtacado/c.valor) as numeric(14,4)),0)
        WHEN C.tipocalc = 'M' and b.codmoeda = 3 THEN
            COALESCE(CAST((v.VlVendaAtacado*c.valor) as numeric(14,0)),0)
        WHEN C.tipocalc = 'D' and b.codmoeda = 3 THEN
            COALESCE(CAST((v.VlVendaAtacado/c.valor) as numeric(14,0)),0)
      END
    ELSE
       COALESCE(CAST(v.VlVendaAtacado as numeric(14,3)),0)
END as VlVendaAtacado,
COALESCE(v.VlCtoUltComp,0) as VlCtoUltComp,
n.qtfisica
From V_PRD_PRDEMP E
Left Join PRD_PRODUTO D  on d.codprod      =e.codprod
Left Join PRD_ITEM1 I    on i.coditem1     =e.coditem1
Left Join PRD_VALOR V    on v.codemp       =e.codemp
                        and v.codprod      =e.codprod
Left Join PRD_QTDE  N    on n.codemp       =e.codemp
                        and n.codprod      =v.codprod
Left Join CAD_MOEDA M    on m.codmoeda     =v.moedacompra
Left Join ADM_PARAM B    on b.codemp       =e.codemp
Left Join TIP_SITPROD F  on f.codsitprod   =d.codsitprod
Left Join CAD_COTACAO C  on c.codemp       =v.codemp
                         and c.codmoedaori =v.moedacompra
                         and c.codmoedaconv=b.codmoeda
                         and c.datacotacao =b.datasistema
;
