1. Create Application

```
docker-compose run web rails new . --force --no-deps --database=mysql --skip-test --webpacker
```

2. Build Docker

```
docker-compose build
```

3. Create Database

```
 docker-compose run web rake db:migrate
```

4. Run Application

```
 docker-compose up -d
```
