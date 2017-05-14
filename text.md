## Telemetría en aplicación ruby con telegraf

### Caso práctico, como monitorizar el comportamiento de un webservice externo de una aplicacion ruby, mediante el protocolo de statsd con storage en influxdb y visualizacion en grafana.

Ya ha llovido bastante desde que, en 2XXX, Etsy nos sacudiera con su post "Monitor All the Things" presentando su uso Statsd. Desde entonces statsd es un protocolo tan sencillo que hay numerosas implementaciones. Una de ellas, la que usa este post se encuentra integrada en Telegraf, una de las piezas habituales del stack de monitorizacion que usamos en The Cocktail. Aun con ello, hay varias implementaciones para todos los gustos de statsd, por lo que al margen de los ejemplos, el resto se puede aplicar al stack favorito de cada cual.

## Recap: Que es statsd? 

StatsD fue un servidor de almacenamiento de estadísticas, desarrollado en Node por Etsy pensado para recibir telemetría interna de aplicación. A grandes trazos es un programa que queda en memoria y memoriza los datos que le vayan llegando por TCP o UDP. Ni siquiera está encargado de persistirlos o mostrarlos!. Como servidor puede almacenar Gauges, Counters, Sets y Timers. Los timers son interesantes, porque irán almacenando los tiempos que les digamos, calculando medias, máximas, mínimas y el percentil que queramos calcular.

## Configurar Telegraf para comportarse como StatsD

StatsD además es un protocolo tan simple que ya no se usa el servidor desarrollado por Etsy, quen mas quien menos ha desarrollado el protocolo como complemento a otro sistema. Es el caso de Telegraf. Telegraf puede configurarse como servidor de statsd y los resultados de los diferentes intevalos se ira almacenando en influxdb




