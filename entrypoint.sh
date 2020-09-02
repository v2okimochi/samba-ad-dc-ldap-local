#!/bin/sh

# Active Directory Domain Controllerを設定

echo "## コンテナ開始 =========="
echo "## Domain Provisioningを開始します"
samba-tool domain provision \
           --domain="${DOMAIN}" \
           --adminpass="${ADMIN_PASSWORD}" \
           --server-role=dc \
           --realm="${REALM}" \
           --dns-backend="${DNS_BACKEND}"

echo "## パスワードの強固なポリシーを解除します"
samba-tool domain passwordsettings set \
           --complexity=off \
           --min-pwd-length=1 \
           --min-pwd-age=0 \
           --max-pwd-age=0 \
           --account-lockout-duration=5 \
           --account-lockout-threshold=10 \
           --reset-account-lockout-after=1

echo "## 設定ファイルに追記します"
# allow dns updates = disabled
# => `Failed DNS update with exit code 29`を回避したかったがダメそう
sed -i '/\[global\]/a allow dns updates = disabled' \
    /etc/samba/smb.conf

# ldap server require strong auth = no
# => `Strong(er) authentication required (8)`を回避
sed -i '/\[global\]/a ldap server require strong auth = no' \
    /etc/samba/smb.conf

echo "##### 設定ファイルを確認 #####"
cat /etc/samba/smb.conf
echo "##################################"

echo "## サンプル用としてユーザを追加します"
# パスワードは `Constraint violation - check_password_restrictions`を回避
samba-tool user create "${SAMPLE_USER_NAME}" "${SAMPLE_USER_PASSWORD}"

echo "## ユーザ一覧を確認します"
samba-tool user list

echo "## Sambaを開始します"
exec /usr/sbin/samba -i
