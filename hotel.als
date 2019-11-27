module projetoLogica
one sig Hotel{
	sistemaCartoes: one SistemaCartoes
}

sig Identificador{
}

one sig SistemaCartoes{
	quartos: some Quarto
}
abstract sig Quarto{
}

abstract sig Cartao{
}

sig Compra{
}

sig Conta{
	compras: set Compra
}

sig CartaoBloqueado in Cartao {
}

sig CartaoDesbloqueado in Cartao{ 
	conta: one Conta,
	numero: one Identificador 
}

sig QuartoOcupado in Quarto{ 
	cartoesValidos: some Cartao
}
sig QuartoDesocupado in Quarto{
}

fact {
	all q:Quarto | one q.~quartos
	all q:Quarto | q in QuartoDesocupado => (q not in (QuartoOcupado))
	all q:QuartoOcupado | #(q.cartoesValidos) = 3
	all q:Quarto | q in QuartoDesocupado or q in QuartoOcupado
	all q:QuartoOcupado | q.cartoesValidos not in CartaoBloqueado
	all q:QuartoOcupado | one q.cartoesValidos.numero
	all c:Cartao | one c.~cartoesValidos
	all c:Cartao | c in CartaoBloqueado => (c not in (CartaoDesbloqueado))
	all c:Cartao | c in CartaoBloqueado or c in CartaoDesbloqueado
	all i:Identificador | #(i.~numero) < 4   
	all i:Identificador | some i.~numero
	all i:Identificador | #(i.~numero.~cartoesValidos) = 1
	all c:Conta | one c.~conta
	all c:Compra | one c.~compras 
}

pred show[]{
}
run show for 6
