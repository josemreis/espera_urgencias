# espera_urgencias

Base de dados com Tempos de Espera do Serviço Nacional de Saúde em Portugal usando [um API wrapper](https://github.com/josemreis/esperaR) para a página [Tempos de Espera do Serviço Nacional de Saúde](http://tempos.min-saude.pt/#/instituicoes). Dados recolhidos *live* a cada 20 mins.

### Sobre a base de dados

1. **fonte**: [Tempos de Espera do Serviço Nacional de Saúde](http://tempos.min-saude.pt/#/instituicoes)
2. **actualizacoes**: Dados sao recolhidos aos 15, 35 e 55 minutos de cada hora do dia (usando um cron job local)

