//                      Processo de separação de mercadorias! 
TODO: 
(`OK!`)`FEITO!` `'Montar Pedido'`;

(`OK!`)`FEITO!` `Confirma pedido - muda status para  'Aguardando Separação'`;

(`OK!`)`FEITO!` `Marca liberar separação - Mostrar no 'Monitor de Separação'`; 

(`OK!`)`FEITO!` `Bloquear edição do pedido caso campo 'Liberar Separação = "S"'`;
               {`Criação da Trigger: TRG_ALTERPEDIDOEMSEPARACAO_JGD`};

(`OK!`)`FEITO!` `Clicar botão 'Iniciar Separação' - Inicia a mesma`;

(`OK!`)`FEITO!` `Clicar botão 'Cancelar Separação' - Cancela a separação e desmarca o campo 'Libera Separação' - libera pedido para alteração`;
               {`Criação da Procedure('Ações'): STP_CANCELASEPARACAO_JOUGLARD`};

(`OK!`)`FEITO!` `Clicar botão 'Finalizar separação' - Altera Status para 'Aguardando Conferência' e *****bloqueia total a edição do pedido******`;
               {`Criação da Procedure('Ações'): STP_FINALSEPARACAO_JOUGLARD`};

('OK!')'FEITO!' 'Iniciar Conferência altera status para "Em Conferência"';
               {`Criação da Procedure('Eventos'): STP_STTSSEPARCON2_JOUGLARD`};

(`OK!`)`ERRO!`  `Criar bloqueio de alterações enquanto a nota está em conferência`;

(`OK!`)`FEITO!` `Após conferência finalizada altera status 'Aguardando Faturamento'`;
               {`Criação da Procedure('Eventos'): STP_STTSSEPARCON2_JOUGLARD`};

(`OK!`)`FEITO!` `Após emissão/faturamento da nota (confirmando a mesma) altera status para 'Faturado'`
					{`Criação da Procedure('Evento'): STP_ATUALIZANOTA_JOUGLARD`};
`-------------` 							 
` --------------- Extras --------------- `
   `Levar nota para e gerar Etiquetas`;
   `Tratar registro de entrega`;
` -------------------------------------- `
