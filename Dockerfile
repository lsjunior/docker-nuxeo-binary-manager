FROM ubuntu

LABEL maintainer="Lourival Sabino <lourival.sabino.junior@gmail.com>"

ENV INPUT= SRC= DST=

COPY scripts/* /

RUN chmod +x /*.sh

CMD [ "/run.sh" ]
