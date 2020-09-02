FROM alpine:3.12.0
RUN apk add --update --no-cache samba-dc
RUN rm -rf /etc/samba/smb.conf
EXPOSE 389
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
