# Samba-AD-DC-LDAP-Local

- Local上でLDAPサーバ (Active Directory)が立つ
- とりあえずダミーのLDAP認証を置きたい時に使う
- port番号とかは `docker-compose.yml`参照
- たとえば `dev@v2-okimochi.local`という指定はこう分けられる
  - dev: ユーザ名 (CN)
  - v2-okimochi: ドメイン (DC)
  - local: ドメイン (DC)


## 使い方
`docker-compose.yml`で立ち上げる。
たとえばこうする。

```
$ docker-compose up -d
```

`docker-compose.yml`の中で色々指定する。

- active-directory:
  - DOMAIN
  - REALM
  - ADMIN_PASSWORD
  - DNS_BACKEND: これは `SAMBA_INTERNAL`のままで良い
  - SAMPLE_USER_NAME: 任意のユーザ名をスッと登録する
  - SAMPLE_USER_PASSWORD: 任意のユーザのパスワードをスッと登録する
- ldap-admin: WebからLDAPサーバに入る用 (削っても良い)


## Build
手元でやるならこう

```
docker build ./ --tag v2okimochi/samba-ad-local:1.0.0
```

