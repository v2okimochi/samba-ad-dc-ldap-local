# Samba-AD-DC-LDAP-Local

- Local上でLDAPサーバ (Active Directory)が立つ
- とりあえずダミーのLDAP認証を置きたい時に使う
  - たとえば `dev@v2-okimochi.local`の表記で認証を通せる
    - dev: ユーザ名 (CN)
    - v2-okimochi: ドメイン (DC)
    - local: ドメイン (DC)
  - 管理者ログインなら `cn=Administrator,dc=v2-okimochi,dc=local`
  - Local以外で使うことは想定していない
- port番号とかは `docker-compose.yml`参照


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
DockerHubと連携して自動ビルドされる。

cf. https://hub.docker.com/repository/docker/v2okimochi/samba-ad-dc-ldap-local

- `master`ブランチへのマージ:
  - DockerHubのTag = `latest`
- `vX.Y.Z`Tagをつける:
  - DockerHubのTag = `X.Y.Z`
  - たとえばGitHub上で `v1.0.5`タグをつければ、 `1.0.5`となる


あえて手元でやるなら、たとえばこうする。

```
$ docker build ./ --tag v2okimochi/samba-ad-local:1.0.0
```
