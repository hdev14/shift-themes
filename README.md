### DESCRIÇÃO
Este script serve para alterar os temas do XFCE, VSCode e wallpapers. Quando o horário está entre 6 e 18, temas claros são configurados nos outros horários os temas escuros são defindos.

### COMO USAR
Primeiramente é preciso <b>definir os temas claros e escuros</b> tanto para o XCFE como para o VSCode. Vale lembrar que é preciso que esses temas e wallpapers já estejam <b>instalados/baixados</b> corretamente.

> Executa o script <br />
``` $ ./shift-themes.sh $USER ```
 

### SCRIPT + CRON
Para automatizar esse script, basta utilizar o agendamento de tarefas. O cron é recurso presente no Linux que permite a execução automática de tarefas. Basta utilzar o seguinte comando:

> ``` $ crontab -e ```


Após isso, irá abrir um editor de texto, dessa forma basta adicionar esta linha de comando: 
<br /><br />
0-55/5 * * * * <caminho-completo-até-o-arquivo> <usuário> 
<br />

<b>Ex:</b> 
>```0-55/5 * * * * /home/joao/Documents/shift-themes.sh joao```

<br />
Essa tarefa irá executar este script a cada 5 minutos. Porém você pode escolher o intervalo mais adequado para você. Basta pesquisar sobre regras do crontab.

### 
> <b>OBS:</b> Esse script foi desenvolvido na distro XUBUNTU. Dessa forma se você usa outra distro que utiliza XCFE, talvez seja preciso fazer alterações.