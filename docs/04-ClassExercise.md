Ekstra øvelse 1: Database over bøger og biblioteker

Opret en database der hedder “Library”

Opret tabellen “Book” med id, titel, forfatter
Opret tabellen “Library” med id, navn, adresse

Udvid databasen, så en bog kan være i mange biblioteker, og et bibliotek kan have mange bøger.
Et bibliotek skal kunne have flere eksemplarer af en given bog.
Opret tabellen “BooksInLibraries” 

Udfyld alle tabellerne med følgende data: 
|||
|--|--|
|Library|<table><tr><th>id</th><th>LibraryName</th><th>Address</th></tr><tr><td>1</td><td>lib A</td><td>A Road</td></tr><tr><td>2</td><td>lib B</td><td>B Road</td></tr><tr><td>3</td><td>lib C</td><td>C Road</td></tr></table>|
|BooksInLibraries|<table><tr><th>Book_Id</th><th>Library_Id</th><th>NumberOfBooks</th></tr><tr><td>1</td><td>2</td><td>3</td></tr><tr><td>1</td><td>3</td><td>1</td></tr><tr><td>2</td><td>1</td><td>2</td></tr><td>2</td><td>2</td><td>1</td></tr><td>3</td><td>1</td><td>1</td></tr><td>3</td><td>2</td><td>2</td></tr><td>3</td><td>3</td><td>2</td></tr></table>|
|Book|<table><tr><th>id</th><th>Title</th><th>Author</th></tr><tr><td>1</td><td>Donald Duck</td><td>Disney</td></tr><tr><td>2</td><td>Mickey Mouse</td><td>Disney</td></tr><tr><td>3</td><td>Pluto</td><td>John</td></tr></table>|






1. Lav en SQL-forespørgsel for at vise de bøger, som en given forfatter har skrevet.
2. Lav en SQL-forespørgsel for at vise, hvor en given bog kan findes.
3. Lav en SQL-forespørgsel for at vise antallet af forskellige bøger på et enkelt bibliotek.
4. Lav en SQL-forespørgsel for at vise antallet af bøger på et enkelt bibliotek.
5. Lav en SQL-forespørgsel for at vise antallet af forskellige bøger på alle biblioteker i en samlet query.
6. Lav en stored procedure, som kan tage navnet fra et bibliotek som parameter og på den måde få vist alle bøger fra det bibliotek.
7. Lav en trigger, som “trigger” at data bliver gemt i en anden tabel når en bog bliver slettet. Gem Bogens titel, Dato i en anden tabel. Den anden tabel skal også have et felt som hedder “solgt” værdien i solgt skal være:  “NEJ”. 

