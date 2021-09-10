1. Build Docker

```
$ docker-compose build
```

2. Create Database

```
 $ docker-compose run web rake db:create db:migrate
```

3. Run Application

```
 $ docker-compose up -d
```

4. Create Score

```
$ curl -X POST http://localhost:3000/scores -d 'player=EDO' -d 'score=100' -d 'time=2020-09-10 14:00'
$ curl -X POST http://localhost:3000/scores -d 'player=EDO' -d 'score=300' -d 'time=2020-09-11 9:00'
$ curl -X POST http://localhost:3000/scores -d 'player=Osaka' -d 'score=400' -d 'time=2020-09-13 9:00'
$ curl -X POST http://localhost:3000/scores -d 'player=Osaka' -d 'score=280' -d 'time=2020-09-11 9:00'
```

5. Get Score
- You can find id out from list of scores.

```
$ curl -X GET http://localhost:3000/scores/2
```

6. Get list of scores
```
$ curl -X GET http://localhost:3000/scores -d 'players=osaka,edo' -d 'before=2020-09-14' -d 'after=2020-09-10' -d 'page=3' -d 'limit=1'
```


7. Delete Score
- You can find id out from list of scores

```
$ curl -X DELETE http://localhost:3000/scores/2
```


8. Get players' history
```
$ curl -X GET http://localhost:3000/players_history/Edo
```
