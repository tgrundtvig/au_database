# Installér git og docker desktop
## Installér docker desktop (docker og docker-compose hvis man er på linux)

1. Installer git ved at følge denne [guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. Installer docker desktop ved at downloade installer [her](https://www.docker.com/products/docker-desktop/)
3. Clone [this](https://github.com/Thomas-Hartmann/mysql_docker) repo til et passende sted på din laptop.
4. Fra en terminal/git bash cd ind i det klonede repo og kør: `docker-compose build` og derefter `docker-compose up -d` og  `docker exec -it mysql_3sem bash` for at åbne en bash prompt inde i en docker container der kører mysql server. 
5. Kør nu kommando: `mysql -u dev -pax2`
6. Kør nu mysql kommandoer herinde: ala `show databases;` og `select User from mysql.user;` med den sidste kommando kan vi se vores dev bruger og de 'grants' der er for denne bruger med `Show grants for dev;`. Det er denne dev bruger vi kommer til at benytte hele dette kursus.
Vi kan lave alt vores database arbejde herindefra, hvis vi har lyst til at arbejde i konsollen. Ellers kan vi installere en GUI application til at kommunikere med database serveren. Her bruger vi Mysql WorkBench. Find installationslink [her](https://dev.mysql.com/downloads/workbench/)
7. Forbind nu til MySQL server med Workbench
Fra Mysql workbench gå til database →  Connect to Database →  user: dev og password: ax2
8. Check at du kan se databaserne startcode osv.
9. Check at du i projektets rodfolder kan se en ny mappe der hedder data (Hvor docker-compose.yml filen er) Inde i denne folder finder du alle de databaser du laver. Det betyder at selv når vi lukker vores docker container ned har vi stadig vores database data.
10. For sample databaser kan vi finde udgangspunkt [her](https://www3.ntu.edu.sg/home/ehchua/programming/sql/SampleDatabases.html).